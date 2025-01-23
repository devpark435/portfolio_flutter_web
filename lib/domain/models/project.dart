class Project {
  final String id; // 프로젝트 고유 식별자
  final String title; // 프로젝트 제목
  final String description; // 프로젝트 설명
  final List<String> technologies; // 사용된 기술 스택
  final List<String> metrics; // 프로젝트 주요 성과/지표
  final String? imageUrl; // 프로젝트 이미지 URL (선택)
  final String? demoUrl; // 데모 사이트 URL (선택)
  final String? githubUrl; // GitHub 저장소 URL (선택)
  final String period; // 프로젝트 진행 기간 (예: 2024.02)
  final String teamSize; // 팀 구성 (예: 1인 개인 프로젝트)

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.metrics,
    required this.period,
    required this.teamSize,
    this.imageUrl,
    this.demoUrl,
    this.githubUrl,
  });
}
