import 'package:flutter/material.dart';
import 'package:portfolio_web/data/experiences.dart';
import '../../../../domain/models/experience.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: '경력 & 활동'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            return isWide
                ? _DesktopLayout(
                    selected: _selected,
                    onSelect: (i) => setState(() => _selected = i),
                  )
                : _MobileLayout();
          }),
        ],
      ),
    );
  }
}

// ─── Desktop: left tab list + right animated panel ───────────────────────────

class _DesktopLayout extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const _DesktopLayout({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left tab rail
        SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: experiences.asMap().entries.map((e) {
              return _TabItem(
                experience: e.value,
                isActive: e.key == selected,
                onTap: () => onSelect(e.key),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 48),
        // Right content panel
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: child,
                ),
              );
            },
            child: _ContentPanel(
              key: ValueKey(selected),
              experience: experiences[selected],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabItem extends StatefulWidget {
  final Experience experience;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.experience,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final typeColor = _typeColor(widget.experience.type);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget.isActive ? primary : Colors.transparent,
                width: 2,
              ),
            ),
            color: widget.isActive
                ? primary.withOpacity(0.08)
                : (_hovered ? primary.withOpacity(0.04) : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: typeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.experience.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: widget.isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: widget.isActive
                            ? primary
                            : theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.75),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  widget.experience.period,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentPanel extends StatelessWidget {
  final Experience experience;

  const _ContentPanel({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final typeColor = _typeColor(experience.type);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Type badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: typeColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: typeColor.withOpacity(0.35)),
          ),
          child: Text(
            _typeLabel(experience.type),
            style: theme.textTheme.bodySmall?.copyWith(
              color: typeColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          experience.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${experience.role}  ·  ${experience.period}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: primary.withOpacity(0.85),
          ),
        ),
        const SizedBox(height: 28),
        ...experience.description.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.65,
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.82),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

// ─── Mobile: accordion ───────────────────────────────────────────────────────

class _MobileLayout extends StatefulWidget {
  @override
  State<_MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<_MobileLayout> {
  int _expanded = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((e) {
        final isOpen = e.key == _expanded;
        return _AccordionItem(
          experience: e.value,
          isOpen: isOpen,
          onTap: () => setState(() => _expanded = isOpen ? -1 : e.key),
        );
      }).toList(),
    );
  }
}

class _AccordionItem extends StatelessWidget {
  final Experience experience;
  final bool isOpen;
  final VoidCallback onTap;

  const _AccordionItem({
    required this.experience,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final typeColor = _typeColor(experience.type);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isOpen ? primary.withOpacity(0.06) : Colors.transparent,
              border: Border(
                left: BorderSide(
                  color: isOpen ? primary : Colors.transparent,
                  width: 2,
                ),
                bottom: BorderSide(
                  color: theme.dividerColor.withOpacity(0.12),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight:
                              isOpen ? FontWeight.w600 : FontWeight.w400,
                          color: isOpen ? primary : null,
                        ),
                      ),
                      Text(
                        experience.period,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color
                              ?.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: primary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: _ContentPanel(experience: experience),
          ),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 260),
        ),
      ],
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

Color _typeColor(String type) {
  switch (type) {
    case 'work':
      return const Color(0xFF4285F4);
    case 'freelance':
      return const Color(0xFF34A853);
    case 'activity':
      return const Color(0xFF9C6FFF);
    default:
      return Colors.grey;
  }
}

String _typeLabel(String type) {
  switch (type) {
    case 'work':
      return 'WORK';
    case 'freelance':
      return 'FREELANCE';
    case 'activity':
      return 'ACTIVITY';
    default:
      return 'ETC';
  }
}
