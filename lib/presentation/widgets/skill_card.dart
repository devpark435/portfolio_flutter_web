import 'package:flutter/material.dart';
import '../../domain/models/skill.dart';

class SkillCard extends StatelessWidget {
  final Skill skill;

  const SkillCard({
    super.key,
    required this.skill,
  });

  IconData _getTitleIcon() {
    switch (skill.title) {
      case 'Flutter Development':
        return Icons.flutter_dash;
      case 'iOS Development':
        return Icons.phone_iphone;
      case 'Backend Services':
        return Icons.cloud;
      case 'Development Tools':
        return Icons.code;
      case 'Architecture & Design Patterns':
        return Icons.architecture;
      default:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  _getTitleIcon(),
                  color: primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    skill.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...skill.skills.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    item,
                    style: theme.textTheme.bodyLarge,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
