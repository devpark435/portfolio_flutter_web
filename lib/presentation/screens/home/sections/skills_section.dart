import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/skills.dart';
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
              // 공식: (전체 너비 - (카드 사이 간격 * (카드 개수-1))) / 카드 개수
              const spacing = 24.0; // Wrap의 spacing 값
              cardWidth = (availableWidth - (spacing * (itemsPerRow - 1))) /
                  itemsPerRow;

              return Wrap(
                spacing: spacing, // 가로 간격
                runSpacing: 24, // 세로 간격
                alignment: WrapAlignment.start,
                children: skills.map((skill) {
                  return SizedBox(
                    width: cardWidth,
                    child: SkillCard(skill: skill),
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
