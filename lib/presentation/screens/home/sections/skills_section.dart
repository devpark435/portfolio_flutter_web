import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/skills.dart';
import '../../../widgets/scroll_reveal_widget.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';
import '../../../widgets/skill_card.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: "기술 스택"),
          const SizedBox(height: 16),
          Text(
            '다양한 기술 스택을 활용하여 사용자 중심의 솔루션을 제공합니다',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              int itemsPerRow;
              if (availableWidth > 1200) {
                itemsPerRow = 3;
              } else if (availableWidth > 800) {
                itemsPerRow = 2;
              } else {
                itemsPerRow = 1;
              }
              const spacing = 24.0;
              final cardWidth =
                  (availableWidth - (spacing * (itemsPerRow - 1))) /
                      itemsPerRow;

              return Wrap(
                spacing: spacing,
                runSpacing: 32,
                alignment: WrapAlignment.start,
                children: skills.asMap().entries.map((entry) {
                  return SizedBox(
                    width: cardWidth,
                    child: ScrollRevealWidget(
                      delay: Duration(milliseconds: entry.key * 90),
                      child: SkillCard(skill: entry.value),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
