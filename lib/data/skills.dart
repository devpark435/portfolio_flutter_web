import '../domain/models/skill.dart';

const List<Skill> skills = [
  Skill(
    title: 'Flutter / iOS',
    skills: ['Flutter', 'Dart', 'Swift', 'SwiftUI', 'UIKit', 'Riverpod', 'Bloc', 'Combine', 'RxSwift'],
    description: '크로스 플랫폼 및 네이티브 모바일 앱 개발',
  ),
  Skill(
    title: 'Backend',
    skills: ['Firebase', 'Supabase', 'Spring Boot', 'Node.js', 'Express', 'REST API'],
    description: '백엔드 서비스 및 API 개발',
  ),
  Skill(
    title: 'Architecture',
    skills: ['Clean Architecture', 'MVVM', 'MVC', 'Repository Pattern', 'Observer Pattern', 'Singleton Pattern'],
    description: '소프트웨어 아키텍처 설계',
  ),
  Skill(
    title: 'Tools',
    skills: ['Git / GitHub', 'Figma', 'Xcode', 'Android Studio', 'VS Code', 'Slack', 'Notion'],
    description: '개발 생산성 도구 활용',
  ),
  Skill(
    title: 'AI Tools',
    skills: ['Claude Code', 'MCP', 'Cursor', 'Windsurf', 'Prompt Engineering', 'GitHub Copilot'],
    description: 'AI 기반 개발 도구 활용 및 LLM 워크플로 구성',
  ),
];
