import 'package:flutter/material.dart';

import '../domain/models/profile_info.dart';

const String profileBio =
    'Flutter/iOS 개발자 박현렬입니다. UI/UX에 대한 높은 이해도를 바탕으로 사용자 중심의 매력적인 앱을 만드는 것을 좋아합니다. 새로운 기술을 배우고 동료와 지식을 공유하는 과정에서 즐거움을 느낍니다.';

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
  'github': 'https://github.com/epreep',
  'velog': 'https://velog.io/@epreep',
};
