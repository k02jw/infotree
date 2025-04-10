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
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

// 공지 ID로 공지 정보 불러오기
app.get('/notifications/:id', async (req, res) => {
  const notiId = req.params.id;

  try {
    const result = await pool.query(
      'SELECT * FROM notifications WHERE id = $1',
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

app.get('/notifications', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM notifications ORDER BY id DESC'
    );
    res.json(result.rows);
    console.log(result.rows);
  } catch (err) {
    console.error('DB Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
