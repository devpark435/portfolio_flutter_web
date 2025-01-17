import '../domain/models/experience.dart';

final List<Experience> experiences = [
  const Experience(
    title: '대학교 프로그래밍 동아리',
    role: '프론트엔드 개발 팀장',
    period: '2023.03 - 현재',
    description: [
      '동아리 웹사이트 개발 및 유지보수',
      '신입 회원 대상 Flutter/React 교육 진행',
      '팀 프로젝트 3개 리드',
    ],
  ),
  const Experience(
    title: '프리랜서 외주 프로젝트',
    role: '프론트엔드 개발자',
    period: '2023.06 - 2023.08',
    description: [
      '로컬 카페 웹사이트 제작',
      'Flutter Web 활용한 반응형 디자인 구현',
      '주문 관리 시스템 개발',
    ],
  ),
  const Experience(
    title: '교내 해커톤 참가',
    role: '풀스택 개발자',
    period: '2023.09',
    description: [
      'AI 기반 학습 플랫폼 개발',
      'Flutter와 Firebase 활용',
      '우수상 수상',
    ],
  ),
];
