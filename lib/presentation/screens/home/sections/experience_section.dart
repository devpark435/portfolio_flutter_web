import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/data/experiences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../domain/models/experience.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: "경력 & 활동"),
          const SizedBox(height: 16),
          Text(
            '저의 성장 과정을 시간 순서대로 확인해보세요.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          ..._buildTimeline(context),
        ],
      ),
    );
  }

  List<Widget> _buildTimeline(BuildContext context) {
    List<Widget> timelineItems = [];
    for (int i = 0; i < experiences.length; i++) {
      final experience = experiences[i];
      final bool isLeft = i.isEven;

      timelineItems.add(
        TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.center,
          isFirst: i == 0,
          isLast: i == experiences.length - 1,
          beforeLineStyle: LineStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            thickness: 2,
          ),
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: _buildIndicator(context, experience),
            padding: const EdgeInsets.all(8),
          ),
          startChild:
              isLeft ? _ExperienceTimelineCard(experience: experience) : null,
          endChild:
              !isLeft ? _ExperienceTimelineCard(experience: experience) : null,
        ).animate().fadeIn(duration: 800.ms, delay: (200 * i).ms).moveX(
              begin: isLeft ? -100 : 100,
              duration: 600.ms,
              delay: (200 * i).ms,
              curve: Curves.easeOut,
            ),
      );
    }
    return timelineItems;
  }

  Widget _buildIndicator(BuildContext context, Experience experience) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getExperienceColor(experience.type).withOpacity(0.2),
        border: Border.all(
          color: _getExperienceColor(experience.type),
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          _getExperienceIcon(experience.type),
          color: _getExperienceColor(experience.type),
          size: 20,
        ),
      ),
    );
  }
}

class _ExperienceTimelineCard extends StatelessWidget {
  final Experience experience;

  const _ExperienceTimelineCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getExperienceColor(experience.type);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getExperienceType(experience.type),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(experience.title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              '${experience.role} | ${experience.period}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            ...experience.description.map(
              (item) => Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color, fontSize: 16)),
                    Expanded(
                        child: Text(item, style: theme.textTheme.bodyMedium)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper functions to get color, icon, and type string
Color _getExperienceColor(String type) {
  switch (type) {
    case 'work':
      return const Color(0xFF4285F4);
    case 'freelance':
      return const Color(0xFF34A853);
    case 'activity':
      return const Color(0xFF6C63FF);
    default:
      return Colors.grey;
  }
}

IconData _getExperienceIcon(String type) {
  switch (type) {
    case 'work':
      return Icons.work;
    case 'freelance':
      return Icons.computer;
    case 'activity':
      return Icons.groups;
    default:
      return Icons.circle;
  }
}

String _getExperienceType(String type) {
  switch (type) {
    case 'work':
      return '회사 경력';
    case 'freelance':
      return '프리랜서';
    case 'activity':
      return '활동 경험';
    default:
      return '경험';
  }
}
