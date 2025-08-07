import 'package:flutter/material.dart';
import '../../../../data/experiences.dart';
import '../../../widgets/experience_card.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= 800;

    return SectionWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width > 800
                ? 42.0 // 데스크톱일 때 패딩
                : 20.0 // 모바일일 때 패딩
            ),
        child: Column(
          children: [
            const SectionTitle(title: '경력 & 활동'),
            const SizedBox(height: 48),
            Column(
              children: experiences
                  .map((experience) => Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: ExperienceCard(
                          experience: experience,
                          isMobile: isMobile,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
