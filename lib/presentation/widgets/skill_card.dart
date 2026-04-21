import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import '../../domain/models/skill.dart';

class SkillCard extends ConsumerStatefulWidget {
  final Skill skill;
  const SkillCard({super.key, required this.skill});

  @override
  ConsumerState<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends ConsumerState<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = _getCategoryColor();
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        ref.read(cursorProvider.notifier).setHovering(true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        ref.read(cursorProvider.notifier).setHovering(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? categoryColor.withOpacity(0.55)
                : Colors.white.withOpacity(isDark ? 0.07 : 0.3),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: categoryColor.withOpacity(0.18),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Glassmorphism background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? RadialGradient(
                              colors: [
                                categoryColor.withOpacity(isDark ? 0.12 : 0.08),
                                isDark
                                    ? Colors.white.withOpacity(0.03)
                                    : Colors.white.withOpacity(0.6),
                              ],
                              center: Alignment.center,
                              radius: 0.9,
                            )
                          : null,
                      color: _isHovered
                          ? null
                          : isDark
                              ? Colors.white.withOpacity(0.04)
                              : Colors.white.withOpacity(0.65),
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getTitleIcon(), size: 36, color: categoryColor),
                    const SizedBox(height: 16),
                    Text(
                      widget.skill.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: categoryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.skill.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.skill.skills.map((skillName) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: categoryColor.withOpacity(0.2),
                                width: 1),
                          ),
                          child: Text(
                            skillName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
      ),
    );
  }

  IconData _getTitleIcon() {
    switch (widget.skill.title) {
      case 'Flutter Development':
        return Icons.flutter_dash;
      case 'iOS Development':
        return Icons.phone_iphone;
      case 'Backend Services':
        return Icons.cloud_queue;
      case 'Development Tools':
        return Icons.build;
      case 'Architecture & Design Patterns':
        return Icons.architecture;
      default:
        return Icons.code;
    }
  }

  Color _getCategoryColor() {
    switch (widget.skill.title) {
      case 'Flutter Development':
      case 'iOS Development':
        return const Color(0xFF027DFD);
      case 'Backend Services':
        return const Color(0xFF4CAF50);
      case 'Development Tools':
        return const Color(0xFFF44336);
      case 'Architecture & Design Patterns':
        return const Color(0xFF9C27B0);
      default:
        return Colors.grey;
    }
  }
}
