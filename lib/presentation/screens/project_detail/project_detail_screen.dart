import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
      data: (projects) {
        final project = projects.firstWhere((p) => p.id == projectId);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/'),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(project.title),
                  background: project.imageUrl != null
                      ? Image.network(
                          project.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.6),
                                Theme.of(context).primaryColor.withOpacity(0.2),
                              ],
                            ),
                          ),
                        ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Project Description
                    const SizedBox(height: 24),
                    Text(
                      '프로젝트 소개',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    // Technologies Used
                    const SizedBox(height: 32),
                    Text(
                      '사용 기술',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies.map((tech) {
                        return Chip(
                          label: Text(tech),
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                        );
                      }).toList(),
                    ),

                    // Project Metrics
                    const SizedBox(height: 32),
                    Text(
                      '주요 성과',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.metrics,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    // Project Links
                    if (project.demoUrl != null ||
                        project.githubUrl != null) ...[
                      const SizedBox(height: 32),
                      Text(
                        '프로젝트 링크',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          if (project.demoUrl != null)
                            ElevatedButton.icon(
                              onPressed: () {
                                // URL 실행 로직
                              },
                              icon: const Icon(Icons.launch),
                              label: const Text('Live Demo'),
                            ),
                          if (project.githubUrl != null)
                            OutlinedButton.icon(
                              onPressed: () {
                                // URL 실행 로직
                              },
                              icon: const Icon(Icons.code),
                              label: const Text('Source Code'),
                            ),
                        ],
                      ),
                    ],
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
