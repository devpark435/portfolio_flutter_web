import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/widgets/project_card.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200
        ? 3
        : width > 800
            ? 2
            : 1;

    final projectsAsync = ref.watch(projectsProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 64,
        horizontal: width > 800 ? 32 : 16,
      ),
      child: Column(
        children: [
          const SectionTitle(title: '프로젝트'),
          const SizedBox(height: 48),
          projectsAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (projects) => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: width > 800 ? 3 / 2 : 3 / 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(project: project);
              },
            ),
          ),
        ],
      ),
    );
  }
}
