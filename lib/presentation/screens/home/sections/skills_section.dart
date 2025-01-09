import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200
        ? 3
        : width > 800
            ? 2
            : 1;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 64,
        horizontal: width > 800 ? 32 : 16,
      ),
      child: Column(
        children: [
          Text(
            '기술 스택',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 48),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSkillCard(
                context,
                'Frontend',
                ['Flutter', 'React', 'Next.js', 'TypeScript', 'Tailwind CSS'],
              ),
              _buildSkillCard(
                context,
                'Backend',
                ['Node.js', 'Express', 'NestJS', 'Python', 'Django'],
              ),
              _buildSkillCard(
                context,
                'Database & DevOps',
                ['PostgreSQL', 'MongoDB', 'Docker', 'AWS', 'Firebase'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(
      BuildContext context, String title, List<String> skills) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            ...skills.map((skill) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
