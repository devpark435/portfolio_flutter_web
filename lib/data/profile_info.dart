import 'package:flutter/material.dart';

import '../domain/models/profile_info.dart';

const String profileBio =
    'Flutter와 iOS를 넘나들며 서비스 전 과정을 주도해온 모바일 개발자입니다.\n스타트업에서 혼자 앱 전체를 담당하며 설계·개발·출시·운영을 경험했고, 오픈소스 패키지 배포와 App Store 50위 달성이라는 실질적인 결과를 만들었습니다. 좋은 구조와 좋은 사용자 경험, 둘 다 포기하지 않는 개발자입니다.';

const List<ProfileInfo> profileDetails = [
  ProfileInfo(
    label: '이름',
    values: ['박현렬'],
  ),
  ProfileInfo(
    label: '생년월일',
    values: ['98.10.31'],
  ),
  ProfileInfo(
    label: '위치',
    values: ['서울특별시 중랑구'],
  ),
  ProfileInfo(
    label: '이메일',
    values: ['devpark435@gmail.com'],
  ),
  ProfileInfo(
    label: '학력',
    values: [
      '성공회대학교',
      '소프트웨어공학 / 컴퓨터공학과',
    ],
  ),
  ProfileInfo(
    label: '관심 분야',
    values: ['Flutter, iOS'],
  ),
];

const Map<String, String> socialLinks = {
  'github': 'https://github.com/devpark435',
  'velog': 'https://velog.io/@devpark435',
};
