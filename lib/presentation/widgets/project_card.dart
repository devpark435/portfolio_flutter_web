import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/models/project.dart';
import '../screens/project_detail/project_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projectColor = _getProjectColor();

    return Consumer(
      builder: (context, ref, child) {
        return MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            ref.read(cursorProvider.notifier).setHovering(true);
          },
          onExit: (_) {
            setState(() => _isHovered = false);
            ref.read(cursorProvider.notifier).setHovering(false);
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _showProjectDetailDialog(context, theme, projectColor),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered
                      ? projectColor.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: projectColor.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(projectColor),
                  _buildInfoSection(theme, projectColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getProjectColor() {
    // 프로젝트별로 다른 색상 적용
    switch (widget.project.id) {
      case '1':
        return const Color(0xFF2196F3); // Blue
      case '2':
        return const Color(0xFF4CAF50); // Green
      case '3':
        return const Color(0xFFFF9800); // Orange
      case '4':
        return const Color(0xFF9C27B0); // Purple
      case '5':
        return const Color(0xFFE91E63); // Pink
      default:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  Widget _buildImageSection(Color projectColor) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.project.imageUrl != null)
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _isHovered ? 1.05 : 1.0,
                child: Image.asset(
                  'assets/${widget.project.imageUrl!}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholderImage(projectColor),
                ),
              )
            else
              _buildPlaceholderImage(projectColor),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isHovered ? 1.0 : 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(ThemeData theme, Color projectColor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: projectColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.project.period}  |  ${widget.project.teamSize}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.project.summary,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.technologies
                .take(4)
                .map((tech) => Chip(
                      avatar: CircleAvatar(
                        backgroundColor: projectColor.withOpacity(0.2),
                        child: Icon(
                          _getTechIcon(tech),
                          size: 14,
                          color: projectColor,
                        ),
                      ),
                      label: Text(tech),
                      backgroundColor: projectColor.withOpacity(0.1),
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      labelStyle: theme.textTheme.bodySmall?.copyWith(
                        color: projectColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  IconData _getTechIcon(String tech) {
    // 기술별 아이콘 매핑
    switch (tech.toLowerCase()) {
      case 'swift':
        return Icons.code;
      case 'uikit':
        return Icons.phone_iphone;
      case 'flutter':
        return Icons.flutter_dash;
      case 'dart':
        return Icons.code;
      case 'firebase':
      case 'firebase realtime database':
        return Icons.cloud_circle;
      case 'github api':
        return Icons.hub;
      case 'restpullapi':
        return Icons.http;
      default:
        return Icons.memory;
    }
  }

  Widget _buildPlaceholderImage(Color projectColor) {
    return Container(
      color: projectColor.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: projectColor.withOpacity(0.5),
        ),
      ),
    );
  }

  void _showProjectDetailDialog(
      BuildContext context, ThemeData theme, Color projectColor) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= 800;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Animate(
          effects: [
            FadeEffect(duration: 400.ms, curve: Curves.easeOut),
            ScaleEffect(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOut),
          ],
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: isMobile
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
                : const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ProjectDetailScreen(projectId: widget.project.id),
              ),
            ),
          ),
        );
      },
    );
  }
}
