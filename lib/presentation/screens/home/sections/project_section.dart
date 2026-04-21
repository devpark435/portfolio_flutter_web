import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/domain/models/project.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsProvider);

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: '프로젝트'),
          const SizedBox(height: 48),
          projectsAsync.when(
            loading: () => const SizedBox(
              height: 500,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Center(child: Text('로드 실패: $e')),
            data: (projects) => LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                return isWide
                    ? _WideLayout(
                        projects: projects,
                        selectedIndex: _selectedIndex,
                        onSelect: (i) => setState(() => _selectedIndex = i),
                      )
                    : _NarrowLayout(
                        projects: projects,
                        selectedIndex: _selectedIndex,
                        onSelect: (i) => setState(() => _selectedIndex = i),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Wide: phone left + detail right ────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  final List<Project> projects;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _WideLayout({
    required this.projects,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: phone simulator
        Expanded(
          flex: 4,
          child: Center(
            child: _PhoneFrame(
              projects: projects,
              selectedIndex: selectedIndex,
              onSelect: onSelect,
            ),
          ),
        ),
        const SizedBox(width: 48),
        // Right: detail panel
        Expanded(
          flex: 5,
          child: _DetailPanel(
            key: ValueKey(selectedIndex),
            project: projects[selectedIndex],
          ),
        ),
      ],
    );
  }
}

// ─── Narrow: phone + detail stacked ─────────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  final List<Project> projects;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _NarrowLayout({
    required this.projects,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneFrame(
          projects: projects,
          selectedIndex: selectedIndex,
          onSelect: onSelect,
          compact: true,
        ),
        const SizedBox(height: 40),
        _DetailPanel(
          key: ValueKey(selectedIndex),
          project: projects[selectedIndex],
        ),
      ],
    );
  }
}

// ─── Phone frame ─────────────────────────────────────────────────────────────

class _PhoneFrame extends StatelessWidget {
  final List<Project> projects;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool compact;

  const _PhoneFrame({
    required this.projects,
    required this.selectedIndex,
    required this.onSelect,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final phoneW = compact ? 240.0 : 280.0;
    final phoneH = compact ? 480.0 : 560.0;

    return Container(
      width: phoneW,
      height: phoneH,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(44),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.15)
              : Colors.black.withOpacity(0.10),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.55 : 0.18),
            blurRadius: 48,
            offset: const Offset(0, 24),
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            blurRadius: 60,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(42),
        child: Column(
          children: [
            // Dynamic Island
            const _DynamicIsland(),
            // Wallpaper screen
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [
                            const Color(0xFF0D1B2A),
                            const Color(0xFF1A2744),
                          ]
                        : [
                            const Color(0xFF4A90D9),
                            const Color(0xFF7FB3E8),
                          ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: _AppIconGrid(
                    projects: projects,
                    selectedIndex: selectedIndex,
                    onSelect: onSelect,
                  ),
                ),
              ),
            ),
            // Home indicator
            const _HomeIndicator(),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.94, 0.94), duration: 600.ms, curve: Curves.easeOut);
  }
}

class _DynamicIsland extends StatelessWidget {
  const _DynamicIsland();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: const Color(0xFF1C1C1E),
      child: Center(
        child: Container(
          width: 80,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.black,
      child: Center(
        child: Container(
          width: 90,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ─── App icon grid ───────────────────────────────────────────────────────────

class _AppIconGrid extends StatelessWidget {
  final List<Project> projects;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _AppIconGrid({
    required this.projects,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: projects.length,
      itemBuilder: (context, i) => _AppIcon(
        project: projects[i],
        index: i,
        isSelected: i == selectedIndex,
        onTap: () => onSelect(i),
      ),
    );
  }
}

class _AppIcon extends StatefulWidget {
  final Project project;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _AppIcon({
    required this.project,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<_AppIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  static const _colors = [
    Color(0xFF5B8AF5),
    Color(0xFF7C6FFF),
    Color(0xFF34A853),
    Color(0xFFF5A623),
    Color(0xFFE84A5F),
    Color(0xFF00B4D8),
    Color(0xFFFF6B6B),
    Color(0xFF6BCB77),
    Color(0xFFFFD166),
  ];

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bounceAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.85)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.85, end: 1.08)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.08, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
    ]).animate(_bounceCtrl);
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _bounceCtrl.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final color = _colors[widget.index % _colors.length];
    final shortName = _shortName(widget.project.title);

    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _bounceAnim,
            builder: (context, child) => Transform.scale(
              scale: _bounceAnim.value,
              child: child,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.7),
                          blurRadius: 14,
                          spreadRadius: 1,
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                border: widget.isSelected
                    ? Border.all(color: Colors.white, width: 2)
                    : null,
              ),
              child: widget.project.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.asset(
                        'assets/${widget.project.imageUrl}',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _IconFallback(
                          name: widget.project.title,
                          color: color,
                        ),
                      ),
                    )
                  : _IconFallback(name: widget.project.title, color: color),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            shortName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(color: Colors.black54, blurRadius: 4),
              ],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _shortName(String title) {
    // 괄호 이전 텍스트만
    final clean = title.replaceAll(RegExp(r'\(.*?\)'), '').trim();
    return clean.length > 7 ? clean.substring(0, 7) : clean;
  }
}

class _IconFallback extends StatelessWidget {
  final String name;
  final Color color;

  const _IconFallback({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ─── Detail panel ─────────────────────────────────────────────────────────────

class _DetailPanel extends StatelessWidget {
  final Project project;

  const _DetailPanel({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 800;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────
        Text(
          project.title,
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          '${project.period}  ·  ${project.teamSize}',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: primary.withOpacity(0.75)),
        ),
        const SizedBox(height: 20),

        // ── Tech stack ──────────────────────────────────────
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: project.technologies.map((tech) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.10)
                      : Colors.black.withOpacity(0.08),
                ),
              ),
              child: Text(
                tech,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // ── 개요 ────────────────────────────────────────────
        _SectionHeader(title: '개요', primary: primary),
        Text(
          project.summary,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.75,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
          ),
        ),

        // ── 담당 업무 ───────────────────────────────────────
        if (project.responsibilities.isNotEmpty) ...[
          const SizedBox(height: 28),
          _SectionHeader(title: '담당 업무', primary: primary),
          ...project.responsibilities.map((r) => _BulletItem(text: r, primary: primary)),
        ],

        // ── 개발 배경 ───────────────────────────────────────
        if (project.background.isNotEmpty) ...[
          const SizedBox(height: 28),
          _SectionHeader(title: '개발 배경', primary: primary),
          Text(
            project.background,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.75,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
            ),
          ),
        ],

        // ── 주요 기능 ───────────────────────────────────────
        if (project.keyFeatures.isNotEmpty) ...[
          const SizedBox(height: 28),
          _SectionHeader(title: '주요 기능', primary: primary),
          ...project.keyFeatures.map((f) => _BulletItem(text: f, primary: primary)),
        ],

        // ── Troubleshooting ─────────────────────────────────
        if (project.troubleshooting.isNotEmpty) ...[
          const SizedBox(height: 28),
          _SectionHeader(title: 'Troubleshooting', primary: primary),
          ...project.troubleshooting.map((ts) => _TsCard(
                ts: ts,
                isDark: isDark,
                primary: primary,
                theme: theme,
              )),
        ],

        // ── 링크 ────────────────────────────────────────────
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (project.githubUrl != null)
              _LinkButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: project.githubUrl!,
                primary: primary,
                filled: false,
                faIcon: true,
              ),
            if (project.deployUrl != null)
              _LinkButton(
                icon: Icons.rocket_launch,
                label: '배포 링크',
                url: project.deployUrl!,
                primary: primary,
                filled: true,
              ),
            if (project.demoUrl != null)
              _LinkButton(
                icon: Icons.play_circle_outline,
                label: 'Demo',
                url: project.demoUrl!,
                primary: primary,
                filled: false,
              ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    )
        .animate()
        .fadeIn(duration: 320.ms)
        .slideX(begin: 0.04, duration: 320.ms, curve: Curves.easeOut);

    // Desktop: fix panel height to phone height, scroll internally
    if (isWide) {
      return SizedBox(
        height: 560,
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 12),
            child: content,
          ),
        ),
      );
    }

    // Mobile: full height, no constraint
    return content;
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color primary;

  const _SectionHeader({required this.title, required this.primary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 28,
            height: 2,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final Color primary;

  const _BulletItem({required this.text, required this.primary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.65,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.82),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TsCard extends StatelessWidget {
  final dynamic ts; // Troubleshooting
  final bool isDark;
  final Color primary;
  final ThemeData theme;

  const _TsCard({
    required this.ts,
    required this.isDark,
    required this.primary,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.04)
            : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ts.issue,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          _TsDetail(label: '상황', value: ts.context, theme: theme),
          const SizedBox(height: 6),
          _TsDetail(label: '해결', value: ts.solution, theme: theme, highlight: true),
          const SizedBox(height: 6),
          _TsDetail(label: '배운점', value: ts.learning, theme: theme),
        ],
      ),
    );
  }
}

class _TsDetail extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;
  final bool highlight;

  const _TsDetail({
    required this.label,
    required this.value,
    required this.theme,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2, right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: highlight
                  ? const Color(0xFF64B5F6).withOpacity(0.12)
                  : theme.colorScheme.onSurface.withOpacity(0.07),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                height: 1.4,
                color: highlight
                    ? const Color(0xFF64B5F6)
                    : theme.textTheme.bodySmall?.color?.withOpacity(0.50),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.6,
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color primary;
  final bool filled;
  final bool faIcon;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.primary,
    required this.filled,
    this.faIcon = false,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor =
        widget.filled ? theme.colorScheme.onPrimary : widget.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hovered ? widget.primary : widget.primary.withOpacity(0.85))
                : (_hovered
                    ? widget.primary.withOpacity(0.08)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.filled
                  ? Colors.transparent
                  : widget.primary.withOpacity(_hovered ? 0.5 : 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.faIcon
                  ? FaIcon(widget.icon, size: 14, color: iconColor)
                  : Icon(widget.icon, size: 16, color: iconColor),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
