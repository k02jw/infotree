import express from 'express';
import { dirname } from 'path';
import { fileURLToPath } from 'url';
import pg from 'pg';

const { Pool } = pg;
const __dirname = dirname(fileURLToPath(import.meta.url));
const app = express();

app.use(express.json());
app.use(express.static('public'));
app.set('port', process.env.PORT || 3000);

// PostgreSQL 연결 설정
const pool = new Pool({
  user: 'infotree',
  host: 'localhost',
  database: 'infotree',
  password: 'info1234',
  port: 5432,
});

// 서버 실행
app.listen(app.get('port'), () => {
  console.log('LISTENING AT PORT: ', app.get('port'));
});

// 페이지 렌더
app.get('/', (req, res) => {
  res.render('index.ejs');
});

app.get('/users/:id', async (req, res) => {
  const userId = req.params.id;

  try {
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [
      userId,
    ]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    //console.log(result.rows[0]);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

// 공지 ID로 공지 정보 불러오기
app.get('/benefit/:id', async (req, res) => {
  const notiId = req.params.id;

  try {
    const result = await pool.query(
      'SELECT * FROM benefits WHERE id = $1 AND end_date >= NOW()',
      [notiId]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Notification not found' });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

// GET /channels/:id
app.get('/channels/:id', async (req, res) => {
  const channelId = req.params.id;
  //console.log(channelId);
  try {
    const result = await pool.query('SELECT * FROM channels WHERE id = $1', [
      channelId,
    ]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Channel not found' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

// 특정 채널의 혜택 목록 불러오기
app.get('/channel/:id/benefits', async (req, res) => {
  const channelId = req.params.id;

  try {
    const result = await pool.query(
      'SELECT * FROM benefits WHERE channel_id = $1 AND end_date >= NOW() ORDER BY id DESC',
      [channelId]
    );
    if (result.rows.length === 0) {
      return res
        .status(404)
        .json({ error: 'No valid benefits found for this channel' });
    }
    res.json(result.rows);
  } catch (err) {
    console.error('DB Error:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

app.post('/channels/names', async (req, res) => {
  const ids = req.body.ids;

  if (!Array.isArray(ids) || ids.length === 0) {
    return res.status(400).json({ error: '채널 ID 배열이 필요합니다.' });
  }

  try {
    const query = `
      SELECT id, name
      FROM channels
      WHERE id = ANY($1::int[])
    `;
    const result = await pool.query(query, [ids]);

    const channelMap = {};
    for (const row of result.rows) {
      channelMap[row.id] = row.name;
    }

    res.json({ channels: channelMap });
  } catch (err) {
    console.error('DB 오류:', err);
    res.status(500).json({ error: '데이터베이스 오류' });
  }
});

// POST /benefits/liked id를 주면 해당하는 benfit 전체를 리턴
app.post('/benefits/liked', async (req, res) => {
  const ids = req.body.ids;

  if (!Array.isArray(ids) || ids.length === 0) {
    return res.status(400).json({ error: 'likes 배열이 필요합니다' });
  }

  try {
    const result = await pool.query(
      'SELECT * FROM benefits WHERE id = ANY($1::int[]) AND end_date >= NOW()',
      [ids]
    );

    res.json(result.rows);
  } catch (err) {
    console.error('DB 오류:', err);
    res.status(500).json({ error: '데이터베이스 오류' });
  }
});

// POST /benefits/category
app.post('/benefits/category', async (req, res) => {
  const { category } = req.body;

  if (!category) {
    return res.status(400).json({ error: '카테고리 이름이 필요합니다.' });
  }

  try {
    const now = new Date().toISOString();
    const query = `
      SELECT * FROM benefits
      WHERE $1 = ANY(categories)
      AND end_date >= $2
      AND private = false
      ORDER BY end_date ASC
    `;

    const result = await pool.query(query, [category, now]);

    res.json(result.rows);
  } catch (err) {
    console.error('DB Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/benefits/search', async (req, res) => {
  const { searchTerm } = req.body;

  if (!searchTerm) {
    return res.status(400).json({ error: '검색어가 필요합니다.' });
  }

  try {
    const now = new Date().toISOString();
    const query = `
      SELECT * FROM benefits
      WHERE (title ILIKE $1 OR description ILIKE $1)
      AND end_date >= $2
      AND private = false
      ORDER BY end_date ASC
    `;
    const result = await pool.query(query, [`%${searchTerm}%`, now]);

    res.json(result.rows);
  } catch (err) {
    console.error('DB Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/channels/search', async (req, res) => {
  const { searchTerm } = req.body;

  if (!searchTerm) {
    return res.status(400).json({ error: '검색어가 필요합니다.' });
  }

  try {
    const query = `
      SELECT * FROM channels
      WHERE name ILIKE $1 OR description ILIKE $1
      ORDER BY name ASC
    `;
    const result = await pool.query(query, [`%${searchTerm}%`]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: '검색된 채널이 없습니다.' });
    }

    res.json(result.rows);
  } catch (err) {
    console.error('DB Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
