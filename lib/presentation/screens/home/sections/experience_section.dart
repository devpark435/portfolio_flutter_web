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
          LayoutBuilder(
            builder: (context, constraints) {
              // 800px 미만이면 모바일 모드 (왼쪽 정렬)
              final isMobile = constraints.maxWidth < 800;
              return Column(
                children: _buildTimeline(context, isMobile),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimeline(BuildContext context, bool isMobile) {
    final List<Widget> timelineItems = [];

    for (int i = 0; i < experiences.length; i++) {
      final experience = experiences[i];
      // 모바일이면 무조건 오른쪽(endChild)에 배치, 데스크탑이면 지그재그
      final bool isLeft = isMobile ? false : i.isEven;

      timelineItems.add(
        TimelineTile(
          axis: TimelineAxis.vertical,
          // 모바일: 왼쪽 정렬 (좌측 0.1 지점), 데스크탑: 중앙 정렬
          alignment: isMobile ? TimelineAlign.manual : TimelineAlign.center,
          lineXY: isMobile ? 0.05 : 0.5,
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
          // 모바일일 땐 startChild 사용 안함
          startChild: isMobile
              ? null
              : (isLeft
                  ? _ExperienceTimelineCard(experience: experience)
                  : null),
          // 모바일일 땐 무조건 endChild에 배치
          endChild: isMobile
              ? _ExperienceTimelineCard(experience: experience, isMobile: true)
              : (!isLeft
                  ? _ExperienceTimelineCard(experience: experience)
                  : null),
        ).animate().fadeIn(duration: 800.ms, delay: (200 * i).ms).moveX(
              // 모바일: 오른쪽에서 등장, 데스크탑: 좌우 방향에 맞게
              begin: isMobile ? 50 : (isLeft ? -100 : 100),
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
  final bool isMobile;

  const _ExperienceTimelineCard({
    required this.experience,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getExperienceColor(experience.type);

    return Card(
      elevation: 4,
      // 모바일일 때 마진 조정 (왼쪽 여백을 줄이고 오른쪽을 확보)
      margin: isMobile
          ? const EdgeInsets.fromLTRB(16, 16, 0, 16)
          : const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
