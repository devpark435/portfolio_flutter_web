import 'package:flutter/material.dart';
import '../../../../data/skills.dart';
import '../../../../domain/models/skill.dart';
import '../../../widgets/scroll_reveal_widget.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: '기술 스택'),
          const SizedBox(height: 48),
          ...skills.asMap().entries.map(
                (e) => ScrollRevealWidget(
                  delay: Duration(milliseconds: e.key * 70),
                  child: _SkillRow(skill: e.value),
                ),
              ),
        ],
      ),
    );
  }
}

class _SkillRow extends StatefulWidget {
  final Skill skill;
  const _SkillRow({required this.skill});

  @override
  State<_SkillRow> createState() => _SkillRowState();
}

class _SkillRowState extends State<_SkillRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = _categoryColor(widget.skill.title);
    final isAI = widget.skill.title == 'AI Tools';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: _hovered
              ? color.withOpacity(0.05)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.black.withOpacity(0.06),
            ),
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return isWide
              ? _WideRow(
                  skill: widget.skill,
                  color: color,
                  isAI: isAI,
                  hovered: _hovered,
                )
              : _NarrowRow(
                  skill: widget.skill,
                  color: color,
                  isAI: isAI,
                  hovered: _hovered,
                );
        }),
      ),
    );
  }
}

class _WideRow extends StatelessWidget {
  final Skill skill;
  final Color color;
  final bool isAI;
  final bool hovered;

  const _WideRow({
    required this.skill,
    required this.color,
    required this.isAI,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: icon + title
        SizedBox(
          width: 180,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(hovered ? 0.18 : 0.10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  _categoryIcon(skill.title),
                  size: 17,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          skill.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: hovered ? color : null,
                          ),
                        ),
                        if (isAI) ...[
                          const SizedBox(width: 5),
                          Icon(Icons.auto_awesome, size: 12, color: color),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${skill.skills.length} skills',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.38),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Right: pills
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skill.skills.map((s) => _Pill(
                  name: s,
                  color: color,
                  isAI: isAI,
                  hovered: hovered,
                )).toList(),
          ),
        ),
      ],
    );
  }
}

class _NarrowRow extends StatelessWidget {
  final Skill skill;
  final Color color;
  final bool isAI;
  final bool hovered;

  const _NarrowRow({
    required this.skill,
    required this.color,
    required this.isAI,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_categoryIcon(skill.title), size: 15, color: color),
            ),
            const SizedBox(width: 10),
            Text(
              skill.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isAI) ...[
              const SizedBox(width: 5),
              Icon(Icons.auto_awesome, size: 12, color: color),
            ],
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skill.skills.map((s) => _Pill(
                name: s,
                color: color,
                isAI: isAI,
                hovered: hovered,
              )).toList(),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String name;
  final Color color;
  final bool isAI;
  final bool hovered;

  const _Pill({
    required this.name,
    required this.color,
    required this.isAI,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: hovered
            ? color.withOpacity(0.10)
            : (isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.04)),
        border: Border.all(
          color: hovered
              ? color.withOpacity(0.35)
              : (isDark
                  ? Colors.white.withOpacity(0.09)
                  : Colors.black.withOpacity(0.08)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAI) ...[
            Icon(Icons.auto_awesome, size: 10, color: color.withOpacity(0.7)),
            const SizedBox(width: 5),
          ],
          Text(
            name,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.5,
              color: hovered
                  ? color
                  : theme.textTheme.bodySmall?.color?.withOpacity(0.80),
            ),
          ),
        ],
      ),
    );
  }
}

Color _categoryColor(String title) {
  switch (title) {
    case 'Flutter / iOS':
      return const Color(0xFF027DFD);
    case 'Backend':
      return const Color(0xFF34A853);
    case 'Architecture':
      return const Color(0xFF9C27B0);
    case 'Tools':
      return const Color(0xFFF5A623);
    case 'AI Tools':
      return const Color(0xFF7C6FFF);
    default:
      return Colors.grey;
  }
}

IconData _categoryIcon(String title) {
  switch (title) {
    case 'Flutter / iOS':
      return Icons.phone_iphone;
    case 'Backend':
      return Icons.cloud_queue;
    case 'Architecture':
      return Icons.account_tree_outlined;
    case 'Tools':
      return Icons.build_outlined;
    case 'AI Tools':
      return Icons.auto_awesome;
    default:
      return Icons.code;
  }
}
