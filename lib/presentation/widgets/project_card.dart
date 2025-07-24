import 'package:flutter/material.dart';
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

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getProjectColor() {
    // 프로젝트별로 다른 색상 적용
    switch (widget.project.id) {
      case 'copro':
        return const Color(0xFF4CAF50); // Green
      case 'sikmogil':
        return const Color(0xFF2196F3); // Blue
      case 'twelvecinema':
        return const Color(0xFF9C27B0); // Purple
      case 'weather':
        return const Color(0xFFFF9800); // Orange
      case 'zikiza':
        return const Color(0xFFE91E63); // Pink
      default:
        return const Color(0xFF607D8B); // Blue Grey
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projectColor = _getProjectColor();

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: GestureDetector(
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
                      ? MediaQuery.of(context).size.width * 0.95
                      : MediaQuery.of(context).size.width * 0.7,
                  height: isMobile
                      ? MediaQuery.of(context).size.height * 0.95
                      : MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ProjectDetailScreen(projectId: widget.project.id),
                ),
              );
            },
          );
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      projectColor.withOpacity(0.1),
                      projectColor.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(
                    color: projectColor.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: projectColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 프로젝트 이미지 영역
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: projectColor.withOpacity(0.1),
                      ),
                      child: widget.project.imageUrl != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                widget.project.imageUrl!,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholderImage(projectColor);
                                },
                              ),
                            )
                          : _buildPlaceholderImage(projectColor),
                    ),

                    // 프로젝트 정보
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 프로젝트 제목과 기간
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.project.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: projectColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: projectColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  widget.project.teamSize,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: projectColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            widget.project.period,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.7),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 프로젝트 요약
                          Text(
                            widget.project.summary,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // 주요 기능
                          if (widget.project.keyFeatures.isNotEmpty) ...[
                            Text(
                              '주요 기능',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: projectColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...widget.project.keyFeatures
                                .take(3)
                                .map((feature) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 4,
                                            height: 4,
                                            margin: const EdgeInsets.only(
                                                top: 8, right: 8),
                                            decoration: BoxDecoration(
                                              color: projectColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              feature,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                            const SizedBox(height: 16),
                          ],

                          // 기술 스택
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children:
                                widget.project.technologies.take(5).map((tech) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: projectColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: projectColor.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: projectColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(Color projectColor) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: projectColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Icon(
        Icons.code,
        size: 48,
        color: projectColor.withOpacity(0.5),
      ),
    );
  }
}
