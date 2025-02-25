import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/widgets/project_card.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';
import 'package:portfolio_web/presentation/widgets/section_wrapper.dart';

import '../../../widgets/contact_button.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '프로젝트'),
          const SizedBox(height: 48),
          projectsAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (projects) => LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;

                // 화면 너비별 카드 개수 및 너비 계산
                int itemsPerRow;
                double cardWidth;

                if (availableWidth > 1200) {
                  itemsPerRow = 4; // 대형 화면: 4개
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
                  children: projects.map((project) {
                    return SizedBox(
                      width: cardWidth,
                      child: ProjectCard(project: project),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 48),
          const ContactButton(
            label: '프로젝트 더보기',
            icon: Icons.code,
            url: 'https://github.com/devpark435',
          ),
        ],
      ),
    );
  }
}
