import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/data/profile_info.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Contact'),
          const SizedBox(height: 16),
          Text(
            '새로운 기회를 찾고 있습니다. 편하게 연락주세요.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 64),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            return isWide
                ? _WideContact(primary: primary)
                : _NarrowContact(primary: primary);
          }),
        ],
      ),
    );
  }
}

class _WideContact extends StatelessWidget {
  final Color primary;
  const _WideContact({required this.primary});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _ContactCta(primary: primary),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 2,
          child: _ContactLinks(primary: primary),
        ),
      ],
    );
  }
}

class _NarrowContact extends StatelessWidget {
  final Color primary;
  const _NarrowContact({required this.primary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactCta(primary: primary),
        const SizedBox(height: 56),
        _ContactLinks(primary: primary),
      ],
    );
  }
}

// ─── Left: headline + email button ───────────────────────────────────────────

class _ContactCta extends StatelessWidget {
  final Color primary;
  const _ContactCta({required this.primary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's work\ntogether.",
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '함께 멋진 프로젝트를 만들어봐요.\n아래 이메일로 연락주시면 빠르게 답변드리겠습니다.',
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.65),
          ),
        ),
        const SizedBox(height: 40),
        _EmailButton(primary: primary),
      ],
    );
  }
}

class _EmailButton extends ConsumerStatefulWidget {
  final Color primary;
  const _EmailButton({required this.primary});

  @override
  ConsumerState<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends ConsumerState<_EmailButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
        ref.read(cursorProvider.notifier).setHovering(true);
      },
      onExit: (_) {
        setState(() => _hovered = false);
        ref.read(cursorProvider.notifier).setHovering(false);
      },
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('mailto:devpark435@gmail.com')),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          decoration: BoxDecoration(
            color: _hovered ? widget.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.primary, width: 1.5),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.primary.withOpacity(0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mail_outline,
                size: 18,
                color: _hovered
                    ? theme.colorScheme.onPrimary
                    : widget.primary,
              ),
              const SizedBox(width: 12),
              Text(
                'devpark435@gmail.com',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _hovered
                      ? theme.colorScheme.onPrimary
                      : widget.primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Right: social links ─────────────────────────────────────────────────────

class _ContactLinks extends StatelessWidget {
  final Color primary;
  const _ContactLinks({required this.primary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find me on',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.4),
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        _LinkRow(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          sub: 'devpark435',
          url: socialLinks['github']!,
          primary: primary,
        ),
        const SizedBox(height: 12),
        _LinkRow(
          icon: FontAwesomeIcons.rss,
          label: 'Velog',
          sub: '@devpark435',
          url: socialLinks['velog']!,
          primary: primary,
        ),
      ],
    );
  }
}

class _LinkRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final String sub;
  final String url;
  final Color primary;

  const _LinkRow({
    required this.icon,
    required this.label,
    required this.sub,
    required this.url,
    required this.primary,
  });

  @override
  State<_LinkRow> createState() => _LinkRowState();
}

class _LinkRowState extends State<_LinkRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _hovered
                ? widget.primary.withOpacity(0.07)
                : (isDark
                    ? Colors.white.withOpacity(0.03)
                    : Colors.black.withOpacity(0.03)),
            border: Border.all(
              color: _hovered
                  ? widget.primary.withOpacity(0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: _hovered ? widget.primary : widget.primary.withOpacity(0.6),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.sub,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.45),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 14,
                color: _hovered
                    ? widget.primary
                    : theme.iconTheme.color?.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
