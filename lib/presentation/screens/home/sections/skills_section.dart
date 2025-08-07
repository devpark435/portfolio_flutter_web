import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/skills.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';
import '../../../widgets/skill_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

              // 화면 너비별 카드 개수 및 너비 계산
              int itemsPerRow;
              double cardWidth;

              if (availableWidth > 1200) {
                itemsPerRow = 3; // 대형 화면: 3개
              } else if (availableWidth > 800) {
                itemsPerRow = 2; // 중간 화면: 2개
              } else {
                itemsPerRow = 1; // 모바일: 1개
              }

              // 간격을 고려한 카드 너비 계산
              const spacing = 24.0; // Wrap의 spacing 값
              cardWidth = (availableWidth - (spacing * (itemsPerRow - 1))) /
                  itemsPerRow;

              return Wrap(
                spacing: spacing, // 가로 간격
                runSpacing: 32, // 세로 간격 증가
                alignment: WrapAlignment.start,
                children: skills
                    .map((skill) => SizedBox(
                          width: cardWidth,
                          child: SkillCard(skill: skill),
                        ))
                    .toList()
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 500.ms, delay: 200.ms)
                    .moveY(
                      begin: 30,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
