import '../domain/models/skill.dart';

const List<Skill> skills = [
  Skill(
    title: 'Flutter Development',
    skills: ['Flutter/Dart', 'Riverpod', 'Cubit', 'GetX', 'Flutter Hooks'],
    description: '크로스 플랫폼 모바일 앱 개발',
  ),
  Skill(
    title: 'iOS Development',
    skills: ['Swift', 'UIKit', 'SwiftUI', 'AutoLayout', 'Combine', 'RxSwift'],
    description: '네이티브 iOS 앱 개발',
  ),
  Skill(
    title: 'Backend Services',
    skills: ['Firebase', 'Supabase', 'SpringBoot', 'Node.js', 'Express'],
    description: '백엔드 서비스 및 API 개발',
  ),
  Skill(
    title: 'Development Tools',
    skills: [
      'Git/GitHub',
      'Figma',
      'Slack',
      'VS Code',
      'Xcode',
      'Android Studio'
    ],
    description: '개발 생산성 도구 활용',
  ),
  Skill(
    title: 'Architecture & Design Patterns',
    skills: [
      'MVC',
      'MVVM',
      'Clean Architecture',
      'Repository Pattern',
      'Singleton Pattern',
      'Observer Pattern'
    ],
    description: '소프트웨어 아키텍처 설계',
  ),
];
