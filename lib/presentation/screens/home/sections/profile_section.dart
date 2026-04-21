import 'dart:html' as html;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/profile_info.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ProfileSection extends ConsumerWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: '저를 소개합니다'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            return isWide
                ? _WideLayout()
                : _NarrowLayout();
          }),
        ],
      ),
    );
  }
}

// ─── Wide layout (>900px): left photo col + right info col ───────────────────

class _WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _PhotoColumn()),
        const SizedBox(width: 56),
        Expanded(flex: 3, child: _InfoColumn()),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PhotoColumn(),
        const SizedBox(height: 48),
        _InfoColumn(),
      ],
    );
  }
}

// ─── Left: photo + name + bio + buttons ──────────────────────────────────────

class _PhotoColumn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Photo with ring
        Center(
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 700.ms).scale(
                begin: const Offset(0.92, 0.92),
                end: const Offset(1, 1),
                duration: 700.ms,
                curve: Curves.easeOut,
              ),
        ),
        const SizedBox(height: 28),
        // Name
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '박현렬',
              textStyle: theme.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              speed: const Duration(milliseconds: 130),
            ),
          ],
          totalRepeatCount: 1,
        ),
        const SizedBox(height: 6),
        Text(
          'Flutter & iOS Developer',
          style: theme.textTheme.titleMedium?.copyWith(
            color: primary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        // Bio
        Text(
          profileBio,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.85,
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.75),
          ),
        ),
        const SizedBox(height: 32),
        _SocialAndDownload(),
      ],
    );
  }
}

class _SocialAndDownload extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          url: socialLinks['github']!,
        ),
        const SizedBox(width: 4),
        _SocialIcon(
          icon: FontAwesomeIcons.rss,
          tooltip: 'Velog',
          url: socialLinks['velog']!,
        ),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () {
            html.AnchorElement(href: 'assets/assets/docs/resume.pdf')
              ..setAttribute('download', 'resume_parkhyunryeol.pdf')
              ..click();
          },
          icon: const Icon(Icons.download, size: 18),
          label: const Text('이력서'),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final String url;

  const _SocialIcon(
      {required this.icon, required this.tooltip, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon, size: 18),
      tooltip: tooltip,
      onPressed: () => launchUrl(Uri.parse(url)),
    );
  }
}

// ─── Right: status + info chips ──────────────────────────────────────────────

class _InfoColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const green = Color(0xFF4CAF50);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available status
        Row(
          children: [
            _BlinkingDot(color: green),
            const SizedBox(width: 8),
            Text(
              '현재 구직 중',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        // Info chips grid
        LayoutBuilder(builder: (context, constraints) {
          final double chipW = (constraints.maxWidth - 14) / 2;
          return Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              SizedBox(
                width: chipW,
                child: const _InfoChip(
                  icon: Icons.location_on_outlined,
                  label: '위치',
                  value: '서울특별시 중랑구',
                ),
              ),
              SizedBox(
                width: chipW,
                child: const _InfoChip(
                  icon: Icons.school_outlined,
                  label: '학력',
                  value: '성공회대학교\n소프트웨어공학과',
                ),
              ),
              SizedBox(
                width: chipW,
                child: const _InfoChip(
                  icon: Icons.flutter_dash,
                  label: '관심 분야',
                  value: 'Flutter · iOS',
                ),
              ),
              SizedBox(
                width: chipW,
                child: const _InfoChip(
                  icon: Icons.email_outlined,
                  label: '이메일',
                  value: 'devpark435@gmail.com',
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

// ─── Blinking dot ────────────────────────────────────────────────────────────

class _BlinkingDot extends StatelessWidget {
  final Color color;
  const _BlinkingDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fade(begin: 1.0, end: 0.25, duration: 950.ms, curve: Curves.easeInOut);
  }
}

// ─── Info chip tile ───────────────────────────────────────────────────────────

class _InfoChip extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  State<_InfoChip> createState() => _InfoChipState();
}

class _InfoChipState extends State<_InfoChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _hovered
              ? primary.withOpacity(0.08)
              : (isDark
                  ? Colors.white.withOpacity(0.04)
                  : Colors.white.withOpacity(0.55)),
          border: Border.all(
            color: _hovered
                ? primary.withOpacity(0.35)
                : Colors.white.withOpacity(isDark ? 0.08 : 0.35),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: primary.withOpacity(0.12),
                    blurRadius: 16,
                  )
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.icon,
              size: 17,
              color: _hovered ? primary : primary.withOpacity(0.55),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.45),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
