INSERT INTO users (name, school, email, phone, major, channel, keywords, likes)
VALUES (
  '김동국',
  '동국대학교',
  'dongguk@example.com',
  '010-1234-5678',
  ARRAY['컴퓨터공학과'],
  ARRAY[11, 22, 33],
  ARRAY['코딩', '보드게임', '디지털 드로잉'],
  ARRAY[1, 2, 3, 4]
);

INSERT INTO channels (name, owner_id, flowers, notification_id)
VALUES (
  'CAPS',
  11,
  24, -- 꽃 수(=팔로워 수)
  ARRAY[1, 2, 3]
);


INSERT INTO notifications (
  id, name, start_date, end_date, description, owner_id, channel_id,
  image, link, latitude, longitude, likes
) VALUES
(
  1,
  '[★동국대학교 X 에듀윌 쉬운 토익 공식 얼리버드 프로모션★]',
  '2025-04-08',
  '2025-04-20',
  '딱 한 번의 기회! 동국대학교 첨단융합대학 학생회를 통해
에듀윌X시원스쿨 토익 얼리버드 혜택을 제공합니다.

총 200여개 자격증 강의 + 토익 AI앱 + 제2외국어 + 한국사 + 오픽 강의까지!

지금 신청하면 정상가 2,980,000원 → 지원가 298,000원!
(선착순 30명 한정 / 조기 마감 가능)

자세한 내용은 링크를 통해 확인 바랍니다.',
  11,
  101,
  'https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj',
  'https://forms.gle/jLS9kFPZGA3JwrSNA',
  NULL,
  NULL,
  42
),
(
  2,
  '[📢 2025학년도 1학기 국가장학금 2차 신청 안내]',
  '2025-04-01',
  '2025-04-18',
  '동국대학교 학생지원팀입니다.

✅ 신청 대상: 재학생, 복학생, 신입생, 편입생  
✅ 신청 기간: 2025.04.01(월) ~ 04.18(금) 18:00까지  
✅ 신청 방법: 한국장학재단 홈페이지 및 모바일 앱

* 재학생은 1차 신청 원칙, 2차는 1회 구제 신청만 허용됩니다.',
  11,
  201,
  'https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj',
  'https://www.kosaf.go.kr',
  NULL,
  NULL,
  17
),
(
  3,
  '[🍜 동국대 학생증 제시 시 제휴 음식점 할인 안내]',
  '2025-04-05',
  '2025-06-30',
  '총학생회 복지국에서 안내드립니다.

학생증 제시 시 다음 제휴 음식점에서 혜택 제공:
- 명동칼국수: 10% 할인
- 동대문찜닭: 음료 서비스
- 김밥천국: 1,000원 할인
- 신전떡볶이: 토핑 무료 제공

복지 혜택, 꼭 챙기세요!',
  11,
  102,
  'https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj',
  NULL,
  NULL,
  NULL,
  63
),
(
  4,
  '동국대학생 아메리카노 10% 할인',
  NOW(),
  NOW() + INTERVAL '10 days',
  '빨리 오세요',
  11,
  101,
  'https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj',
  'https://forms.gle/...',
  NULL,
  NULL,
  42
);
