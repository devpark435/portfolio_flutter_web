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
    final width = MediaQuery.of(context).size.width;

    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: "기술 스택"),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: skills.map((skill) {
              return SizedBox(
                width: width > 1200
                    ? width * 0.25 // 3개씩
                    : width > 800
                        ? width * 0.4 // 2개씩
                        : width * 0.8, // 1개씩
                child: SkillCard(skill: skill),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
