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
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? categoryColor.withOpacity(0.5)
                : theme.dividerColor.withOpacity(0.2),
            width: 1,
          ),
          gradient: _isHovered
              ? RadialGradient(
                  colors: [categoryColor.withOpacity(0.15), theme.cardColor],
                  center: Alignment.center,
                  radius: 0.8,
                )
              : null,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: categoryColor.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 4,
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
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skill.skills.map((skillName) {
                return Chip(
                  label: Text(skillName),
                  backgroundColor: categoryColor.withOpacity(0.1),
                  side: BorderSide(color: categoryColor.withOpacity(0.2)),
                );
              }).toList(),
            ),
          ],
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
