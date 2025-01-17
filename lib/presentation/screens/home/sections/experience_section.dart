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
      child: Column(
        children: [
          const SectionTitle(title: '활동 경험'),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
