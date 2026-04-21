import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/widgets/project_card.dart';
import 'package:portfolio_web/presentation/widgets/scroll_reveal_widget.dart';
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
          const SizedBox(height: 16),
          Text(
            '사용자 중심의 솔루션을 제공하는 다양한 프로젝트들입니다',
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
          projectsAsync.when(
            loading: () => _buildLoadingState(context),
            error: (err, stack) => _buildErrorState(context, err.toString()),
            data: (projects) => _buildProjectsGrid(context, projects),
          ),
          const SizedBox(height: 48),
          const ContactButton(
            label: 'GitHub에서 더보기',
            icon: Icons.code,
            url: 'https://github.com/devpark435',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '프로젝트를 불러오는 중...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              '프로젝트를 불러오는데 실패했습니다',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List projects) {
    return LayoutBuilder(
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
        const spacing = 32.0;
        final cardWidth =
            (availableWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;

        return Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                '${projects.length}개의 프로젝트',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: spacing,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: projects.asMap().entries.map((entry) {
                return SizedBox(
                  width: cardWidth,
                  child: ScrollRevealWidget(
                    delay: Duration(milliseconds: entry.key * 80),
                    child: ProjectCard(project: entry.value),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
