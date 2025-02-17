import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/widgets/project_card.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';
import 'package:portfolio_web/presentation/widgets/section_wrapper.dart';
// import 'package:url_launcher/url_launcher.dart';

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

    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '프로젝트'),
          const SizedBox(height: 48),
          projectsAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (projects) => Wrap(
              spacing: 24,
              runSpacing: 24,
              children: projects.map((project) {
                return SizedBox(
                  width: width > 1200
                      ? width * 0.25 // 4개씩
                      : width > 800
                          ? width * 0.4 // 2개씩
                          : width * 0.8, // 1개씩
                  child: ProjectCard(project: project),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
