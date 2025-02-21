import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

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
          backgroundColor: Theme.of(context).cardColor,
          body: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    project.title,
                    style: const TextStyle(fontSize: 16), // 폰트 크기 조정
                    overflow: TextOverflow.ellipsis, // 오버플로우 처리
                  ),
                  centerTitle: true, // 제목 중앙 정렬
                  titlePadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width > 800
                        ? 40
                        : 48, // 좌측 패딩 조정
                    right: 40,
                    bottom: 16,
                  ),
                  background: Container(
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
                      Builder(
                        builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final isMobile = width <= 800;

                          final periodSection = Row(
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
                            ],
                          );

                          final teamSection = Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              // 모바일에서만 Expanded 사용
                              if (isMobile)
                                Expanded(
                                  child: Text(
                                    project.teamSize,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                              else
                                Text(
                                  project.teamSize,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                            ],
                          );

                          return isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    periodSection,
                                    const SizedBox(height: 8),
                                    teamSection,
                                  ],
                                )
                              : Row(
                                  children: [
                                    periodSection,
                                    const SizedBox(width: 24),
                                    teamSection,
                                  ],
                                );
                        },
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
                                    onPressed: () async {
                                      final url = Uri.parse(project.githubUrl!);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
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
                            project.summary,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      // Background
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Background',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            project.background,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      // Meaning
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.insights,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Meaning',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            project.meaning,
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
                                'Key Features',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...project.keyFeatures.map((feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        feature,
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

                      // Challenges
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.engineering,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Challenges',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...project.challenges.map((challenge) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        challenge,
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

                      // Improvements
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Future Improvements',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...project.improvements.map((improvement) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• '),
                                    Expanded(
                                      child: Text(
                                        improvement,
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
                  itemCount: 8, // 섹션의 총 개수
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
