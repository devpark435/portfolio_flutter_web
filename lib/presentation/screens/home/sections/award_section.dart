import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/data/awards.dart';
import '../../../../domain/models/award.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '수상 경력'),
          const SizedBox(height: 16),
          Text(
            '저의 노력과 열정이 담긴 성과들입니다.',
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
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: awards
                  .map((award) => ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: isWide ? 300 : 400),
                        child: _AwardCard(award: award),
                      ))
                  .toList()
                  .animate(interval: 100.ms)
                  .fadeIn(duration: 500.ms, delay: 200.ms)
                  .moveY(begin: 30, duration: 500.ms, curve: Curves.easeOut),
            );
          }),
        ],
      ),
    );
  }
}

class _AwardCard extends ConsumerStatefulWidget {
  final Award award;
  const _AwardCard({required this.award});

  @override
  ConsumerState<_AwardCard> createState() => _AwardCardState();
}

class _AwardCardState extends ConsumerState<_AwardCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final awardColor = _getAwardColor(context, widget.award.award);

    return MouseRegion(
      onEnter: (event) {
        setState(() => _isHovered = true);
        ref.read(cursorProvider.notifier).setHovering(true);
      },
      onExit: (event) {
        setState(() => _isHovered = false);
        ref.read(cursorProvider.notifier).setHovering(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? awardColor.withOpacity(0.5)
                : theme.dividerColor.withOpacity(0.2),
            width: 1,
          ),
          gradient: _isHovered
              ? RadialGradient(
                  colors: [awardColor.withOpacity(0.15), theme.cardColor],
                  center: Alignment.center,
                  radius: 0.8,
                )
              : null,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: awardColor.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          children: [
            Icon(
              _getAwardIcon(widget.award.award),
              size: 48,
              color: awardColor,
            ),
            const SizedBox(height: 24),
            Text(
              widget.award.award,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: awardColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.award.title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.award.date,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAwardColor(BuildContext context, String award) {
    final theme = Theme.of(context);
    switch (award.toLowerCase()) {
      case '우수상':
      case '1등':
      case '금상':
      case '대상':
        return const Color(0xFFFFD700); // Gold
      case '2등':
      case '은상':
        return const Color(0xFFC0C0C0); // Silver
      case '3등':
      case '동상':
      case '장려상':
        return const Color(0xFFCD7F32); // Bronze
      case '인기상':
        return Colors.pinkAccent;
      default:
        return theme.colorScheme.primary;
    }
  }

  IconData _getAwardIcon(String award) {
    switch (award.toLowerCase()) {
      case '인기상':
        return Icons.favorite;
      default:
        return Icons.emoji_events;
    }
  }
}
