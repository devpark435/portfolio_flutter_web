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
    final crossAxisCount = width > 1200
        ? 3
        : width > 800
            ? 2
            : 1;

    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: "기술 스택"),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: width > 800 ? 1.2 : 1.0,
              mainAxisExtent: 350, // 카드의 최대 높이 지정
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) => SkillCard(skill: skills[index]),
          ),
        ],
      ),
    );
  }
}
