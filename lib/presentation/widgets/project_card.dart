import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/project.dart';
import '../screens/project_detail/project_detail_screen.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        // onTap: () => context.go('/projects/${widget.project.id}'),
        onTap: () {
          final width = MediaQuery.of(context).size.width;
          final isMobile = width <= 800;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  width: isMobile
                      ? MediaQuery.of(context).size.width * 0.95 // 모바일에서는 95%
                      : MediaQuery.of(context).size.width * 0.7, // 데스크톱에서는 70%
                  height: isMobile
                      ? MediaQuery.of(context).size.height * 0.95 // 모바일에서는 95%
                      : MediaQuery.of(context).size.height * 0.9, // 데스크톱에서는 90%
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ProjectDetailScreen(projectId: widget.project.id),
                ),
              );
            },
          );
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 내용물 크기에 맞춤
                  children: [
                    Text(
                      widget.project.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.period,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.project.teamSize,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                    const Divider(height: 16),
                    Text(
                      widget.project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.project.metrics.take(4).map((metric) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(
                                child: Text(
                                  metric,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.map((tech) {
                        return Chip(
                          label: Text(tech, style: theme.textTheme.bodySmall),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: theme.primaryColor.withAlpha(10),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
