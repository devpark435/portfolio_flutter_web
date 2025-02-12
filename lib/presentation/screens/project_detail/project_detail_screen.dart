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
                                Theme.of(context).primaryColor.withAlpha(153),
                                Theme.of(context).primaryColor.withAlpha(50),
                              ],
                            ),
                          ),
                        ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final section = [
                      // Period & Team
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.period,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 24),
                          Icon(
                            Icons.people,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.teamSize,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),

                      // Project Links
                      if (project.demoUrl != null || project.githubUrl != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.link,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Deployment URL',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 16,
                              children: [
                                if (project.demoUrl != null)
                                  OutlinedButton.icon(
                                    onPressed: () {/* URL 실행 */},
                                    icon: const Icon(Icons.launch),
                                    label: const Text('Live Demo'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                  ),
                                if (project.githubUrl != null)
                                  OutlinedButton.icon(
                                    onPressed: () {/* URL 실행 */},
                                    icon: const Icon(Icons.code),
                                    label: const Text('Source Code'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),

                      // Summary
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Summary',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            project.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      // Technologies
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.code,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '사용 기술',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.technologies
                                .map((tech) => Chip(
                                      label: Text(tech),
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withAlpha(25),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),

                      // Key Features
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '주요 기능',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...project.metrics.map((metric) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        metric,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ];

                    return section[index];
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 48),
                  itemCount: 5, // 섹션의 총 개수
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
