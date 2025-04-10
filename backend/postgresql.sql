CREATE TABLE users (
  id SERIAL PRIMARY KEY,               -- 고유 ID (자동 증가)
  name TEXT NOT NULL,                  -- 이름
  school TEXT NOT NULL,                -- 학교
  email TEXT NOT NULL UNIQUE,          -- 이메일 (중복 금지)
  phone TEXT NOT NULL,                 -- 전화번호
  major TEXT[] DEFAULT '{}',           -- 전공 (문자열 배열, null 허용)
  channel INTEGER[] DEFAULT '{}',      -- 구독 채널 (정수 배열, null 허용)
  keywords TEXT[] DEFAULT '{}',        -- 관심 키워드
  likes INTEGER[] DEFAULT '{}'         -- 좋아요한 공지 ID
);


CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,              -- 공지 ID (자동 증가)
  name TEXT NOT NULL,                 -- 공지 제목
  start_date TIMESTAMP NOT NULL,      -- 시작일
  end_date TIMESTAMP NOT NULL,        -- 종료일
  description TEXT NOT NULL,          -- 공지 설명
  owner_id INTEGER NOT NULL,          -- 작성자 ID
  channel_id INTEGER NOT NULL,        -- 소속 채널 ID
  image TEXT,                         -- 이미지 링크 (nullable)
  link TEXT,                          -- 외부 링크 (nullable)
  latitude DOUBLE PRECISION,          -- 위도 (nullable)
  longitude DOUBLE PRECISION,         -- 경도 (nullable)
  likes INTEGER DEFAULT 0             -- 좋아요 수 (기본 0)
);


CREATE TABLE channels (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  owner_id INTEGER NOT NULL,
  flowers INTEGER DEFAULT 0,                   
  notification_id INTEGER[] DEFAULT '{}'
);
