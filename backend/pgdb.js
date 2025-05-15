import pg from 'pg';

const { Pool } = pg;
const pool = new Pool({
  user: 'infotree',
  host: 'localhost',
  database: 'infotree',
  password: 'info1234',
  port: 5432,
});

// 저장 함수
export async function savePostToBenefits(post) {
  const query = `
      INSERT INTO benefits (
    title, start_date, end_date, description,
    private, categories, channel_id,
    image, link, latitude, longitude
  )
  VALUES (
    $1, $2, $3, $4,
    $5, $6, $7,
    $8, $9, $10, $11
  )

  `;
  const startDate = post.start_date || new Date().toISOString().split('T')[0];
  //시작 날짜를 제공하지 않는다면 데이터를 받은 날부터 시작
  const values = [
    post.title,
    startDate,
    post.end_date && post.end_date !== '' ? post.end_date : post.start_date,
    post.description,
    false, // private
    post.categories,
    0, // channel_id
    post.image || null,
    post.link || null,
    null, // latitude
    null, // longitude
  ];

  try {
    await pool.query(query, values);
    console.log(`✅ 저장됨: ${post.title}`);
  } catch (err) {
    console.error(`❌ 저장 오류: ${post.title}`, err.message);
  }
}

async function titlecheck(title) {
    const query = `select 1 from benefits where title = $1 limit 1`;
    const { rows } = await pool.query(query, [title]);
    return rows.length > 0;
}

// 전체 저장 처리
async function saveAllPosts(posts) {
    for (const post of posts) {
        const titleexits = await titlecheck(post.title);
        if (!titleexits) {
            await savePostToBenefits(post);
        }
    }
}
