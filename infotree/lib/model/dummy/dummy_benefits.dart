import 'package:infotree/model/benefit_data.dart';

final dummyBenefit1 = BenefitData(
  id: 1,
  title: '[★동국대학교 X 에듀윌 쉬운 토익 공식 얼리버드 프로모션★]',
  startDate: DateTime(2025, 4, 8),
  endDate: DateTime(2025, 4, 20),
  description: '''
딱 한 번의 기회! 동국대학교 첨단융합대학 학생회를 통해
에듀윌X시원스쿨 토익 얼리버드 혜택을 제공합니다.

총 200여개 자격증 강의 + 토익 AI앱 + 제2외국어 + 한국사 + 오픽 강의까지!

지금 신청하면 정상가 2,980,000원 → 지원가 298,000원!
(선착순 30명 한정 / 조기 마감 가능)

자세한 내용은 링크를 통해 확인 바랍니다.
''',
  ownerId: 11,
  private: false,
  categories: [],
  channelId: 101,
  image:
      "https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj",
  link: 'https://forms.gle/jLS9kFPZGA3JwrSNA',
  latitude: 37.5563,
  longitude: 126.9996,
  likes: 42,
);

final dummyBenefit2 = BenefitData(
  id: 2,
  title: '[📢 2025학년도 1학기 국가장학금 2차 신청 안내]',
  startDate: DateTime(2025, 4, 1),
  endDate: DateTime(2025, 4, 18),
  description: '''
동국대학교 학생지원팀입니다.

✅ 신청 대상: 재학생, 복학생, 신입생, 편입생  
✅ 신청 기간: 2025.04.01(월) ~ 04.18(금) 18:00까지  
✅ 신청 방법: 한국장학재단 홈페이지 및 모바일 앱

* 재학생은 1차 신청 원칙, 2차는 1회 구제 신청만 허용됩니다.
''',
  ownerId: 11,
  private: false,
  categories: [],
  channelId: 201,
  image:
      "https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj",
  link: 'https://www.kosaf.go.kr',
  latitude: 37.5573,
  longitude: 126.9986,
  likes: 17,
);

final dummyBenefit3 = BenefitData(
  id: 3,
  title: '[🍜 동국대 학생증 제시 시 제휴 음식점 할인 안내]',
  startDate: DateTime(2025, 4, 5),
  endDate: DateTime(2025, 6, 30),
  description: '''
총학생회 복지국에서 안내드립니다.

학생증 제시 시 다음 제휴 음식점에서 혜택 제공:
- 명동칼국수: 10% 할인
- 동대문찜닭: 음료 서비스
- 김밥천국: 1,000원 할인
- 신전떡볶이: 토핑 무료 제공

복지 혜택, 꼭 챙기세요!
''',
  ownerId: 11,
  private: false,
  categories: [],
  channelId: 102,
  image:
      "https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj",
  link: null,
  latitude: null,
  longitude: null,
  likes: 63,
);

final dummyBenefit4 = BenefitData(
  id: 4,
  title: '동국대학생 아메리카노 10% 할인',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 10)),
  description: '빨리 오세요',
  ownerId: 11,
  private: false,
  categories: [],
  channelId: 101,
  image:
      "https://yt3.googleusercontent.com/HwcqRjByAr2qW33Z1UDjUTg-1vKH-NG1S9S7Cdw-O7CSrN0mfYEx5TmB-q3JoUMnLod3OAXNrA=s900-c-k-c0x00ffffff-no-rj",
  link: 'https://forms.gle/...',
  latitude: null,
  longitude: null,
  likes: 42,
);

List<BenefitData> dummyBenefits = [
  dummyBenefit1,
  dummyBenefit2,
  dummyBenefit3,
  dummyBenefit4,
];
