import 'package:portfolio_web/data/awards.dart';
import 'package:portfolio_web/data/experiences.dart';
import 'package:portfolio_web/data/profile_info.dart';
import 'package:portfolio_web/data/skills.dart';
import 'package:portfolio_web/domain/models/project.dart';

class MarkdownService {
  String generatePortfolioMarkdown({required List<Project> projects}) {
    final buffer = StringBuffer();

    // 1. Profile
    buffer.writeln('# 박현렬 | Flutter 개발자 포트폴리오');
    buffer.writeln('---');
    buffer.writeln('## 👤 소개');
    buffer.writeln(profileBio);
    buffer.writeln('\n### 기본 정보');
    for (final info in profileDetails) {
      buffer.writeln('- **${info.label}:** ${info.values.join(', ')}');
    }
    buffer.writeln('\n### 🌐 소셜 링크');
    for (final entry in socialLinks.entries) {
      buffer.writeln(
          '- **${entry.key.toUpperCase()}:** [${entry.value}](${entry.value})');
    }

    // 2. Experience
    buffer.writeln('\n## 🚀 경력');
    buffer.writeln('---');
    for (final exp in experiences) {
      buffer.writeln('### ${exp.title} (${exp.period})');
      buffer.writeln('**${exp.role}**');
      for (final desc in exp.description) {
        buffer.writeln('- $desc');
      }
      buffer.writeln();
    }

    // 3. Awards
    buffer.writeln('\n## 🏆 수상 경력');
    buffer.writeln('---');
    for (final award in awards) {
      buffer.writeln('- **${award.award}** - ${award.title} (${award.date})');
    }

    // 4. Projects
    buffer.writeln('\n## 🛠️ 프로젝트');
    buffer.writeln('---');
    for (final project in projects) {
      buffer.writeln('### ${project.title}');
      buffer.writeln(
          project.summary); // Use summary instead of description for brevity
      buffer.writeln('- **기간:** ${project.period}');
      buffer.writeln(
          '- **담당 역할:** ${project.responsibilities.join(', ')}'); // Corrected field name
      buffer.writeln('- **기술 스택:** ${project.technologies.join(', ')}');
      if (project.githubUrl != null && project.githubUrl!.isNotEmpty) {
        buffer.writeln(
            '- **GitHub:** [${project.githubUrl}](${project.githubUrl})');
      }
      if (project.demoUrl != null && project.demoUrl!.isNotEmpty) {
        // Corrected field name
        buffer.writeln(
            '- **Live Demo:** [${project.demoUrl}](${project.demoUrl})');
      }
      buffer.writeln();
    }

    // 5. Skills
    buffer.writeln('\n## 💻 기술 스택');
    buffer.writeln('---');
    for (final skill in skills) {
      buffer.writeln('### ${skill.title}');
      buffer.writeln(skill.skills.join(', '));
      buffer.writeln();
    }

    return buffer.toString();
  }
}
