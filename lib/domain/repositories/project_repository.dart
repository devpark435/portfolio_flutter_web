import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

class ProjectRepository {
  Future<List<Project>> getProjects() async {
    return [
      Project(
        id: '1',
        title: 'AI 기반 건강관리 플랫폼',
        description:
            '사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션사용자의 생활패턴을 분석하여 맞춤형 건강 관리 솔루션을 제공하는 웹 애플리케이션',
        technologies: ['React', 'TensorFlow.js', 'Node.js', 'MongoDB'],
        metrics: 'MAU 50,000+ / 전년 대비 사용자 만족도 32% 향상',
      ),
    ];
  }
}
