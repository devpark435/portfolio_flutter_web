import 'troubleshooting.dart';

class ReleaseLog {
  final String version;
  final String date;
  final List<String> changes;

  const ReleaseLog({
    required this.version,
    required this.date,
    required this.changes,
  });
}

class Project {
  final String id; // 프로젝트 고유 식별자
  final String title; // 프로젝트 제목
  final String summary; // 프로젝트 한 줄 요약
  final List<String> keyFeatures; // 주요 기능 목록
  final String background; // 프로젝트 배경
  final String meaning; // 프로젝트 의의/배운점
  final String description; // 프로젝트 상세 설명
  final List<String> technologies; // 사용된 기술 스택
  final List<String> challenges; // 도전 과제 및 해결 방법
  final List<Troubleshooting> troubleshooting; // 구체적인 문제 해결 사례
  final List<String> responsibilities; // 담당 업무 및 역할
  final List<String> improvements; // 개선점 및 향후 계획
  final String period; // 프로젝트 진행 기간
  final String teamSize; // 팀 구성
  final String? imageUrl; // 프로젝트 이미지 URL
  final String? demoUrl; // 데모 사이트 URL (영상 등)
  final String? deployUrl; // 실제 배포 URL (스토어/패키지 링크)
  final String? githubUrl; // GitHub 저장소 URL
  final List<ReleaseLog>? releaseLogs; // 릴리즈 로그

  Project({
    required this.id,
    required this.title,
    required this.summary,
    required this.keyFeatures,
    required this.background,
    required this.meaning,
    required this.description,
    required this.technologies,
    required this.challenges,
    required this.troubleshooting,
    required this.responsibilities, // 추가된 필드
    required this.improvements,
    required this.period,
    required this.teamSize,
    this.imageUrl,
    this.demoUrl,
    this.deployUrl,
    this.githubUrl,
    this.releaseLogs,
  });
}
