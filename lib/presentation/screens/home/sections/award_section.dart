import 'package:flutter/material.dart';
import 'package:portfolio_web/data/awards.dart';
import '../../../../domain/models/award.dart';
import '../../../widgets/scroll_reveal_widget.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: '수상 경력'),
          const SizedBox(height: 48),
          ...awards.asMap().entries.map(
                (e) => ScrollRevealWidget(
                  delay: Duration(milliseconds: e.key * 80),
                  child: _AwardRow(award: e.value),
                ),
              ),
        ],
      ),
    );
  }
}

class _AwardRow extends StatefulWidget {
  final Award award;
  const _AwardRow({required this.award});

  @override
  State<_AwardRow> createState() => _AwardRowState();
}

class _AwardRowState extends State<_AwardRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    final awardColor = _awardColor(widget.award.award);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: _hovered
              ? primary.withOpacity(0.05)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.black.withOpacity(0.06),
            ),
          ),
        ),
        child: Row(
          children: [
            // Medal icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: awardColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _awardIcon(widget.award.award),
                color: awardColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
            // Rank + title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.award.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.award.date,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.45),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Award rank pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: _hovered
                    ? awardColor.withOpacity(0.18)
                    : awardColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: awardColor.withOpacity(_hovered ? 0.45 : 0.25),
                ),
              ),
              child: Text(
                widget.award.award,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: awardColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _awardColor(String award) {
    switch (award) {
      case '우수상':
      case '1등':
      case '금상':
      case '대상':
        return const Color(0xFFFFD700);
      case '2등':
      case '은상':
        return const Color(0xFFB0BEC5);
      case '3등':
      case '동상':
      case '장려상':
        return const Color(0xFFCD7F32);
      case '인기상':
        return Colors.pinkAccent;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _awardIcon(String award) {
    if (award == '인기상') return Icons.favorite;
    return Icons.emoji_events;
  }
}
