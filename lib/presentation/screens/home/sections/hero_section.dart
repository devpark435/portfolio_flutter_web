import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

import '../../../widgets/contact_button.dart';

class HeroSection extends ConsumerStatefulWidget {
  final Map<String, GlobalKey> sectionKeys;
  const HeroSection({super.key, required this.sectionKeys});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    final count = kIsWeb ? 55 : 20;
    _particles = List.generate(count, (_) => _Particle.random());

    // Controller drives the time value for particles
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorPos = ref.watch(cursorProvider).position;
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Dark base gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D1117),
                    Color(0xFF0F1923),
                    Color(0xFF0D1117),
                  ],
                ),
              ),
            ),
          ),
          // Particle system
          Positioned.fill(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _ParticlesPainter(
                      particles: _particles,
                      time: _controller.value * 120,
                      cursorPos: cursorPos,
                      primaryColor: primary,
                    ),
                  );
                },
              ),
            ),
          ),
          // Radial vignette overlay
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.1,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.35),
                    ],
                  ),
                ),
              ),
            ),
          ),
          HeroContent(sectionKeys: widget.sectionKeys),
        ],
      ),
    );
  }
}

// ---------- Particle data ----------

class _Particle {
  final double baseX, baseY;
  final double speedX, speedY;
  final double phase;
  final double amplitude;
  final double size;

  static final _rng = Random();

  const _Particle({
    required this.baseX,
    required this.baseY,
    required this.speedX,
    required this.speedY,
    required this.phase,
    required this.amplitude,
    required this.size,
  });

  factory _Particle.random() {
    return _Particle(
      baseX: _rng.nextDouble(),
      baseY: _rng.nextDouble(),
      speedX: (_rng.nextDouble() - 0.5) * 0.35,
      speedY: (_rng.nextDouble() - 0.5) * 0.35,
      phase: _rng.nextDouble() * pi * 2,
      amplitude: 0.04 + _rng.nextDouble() * 0.07,
      size: 1.2 + _rng.nextDouble() * 2.2,
    );
  }

  Offset position(double time, Size size) {
    var x = baseX + sin(time * speedX + phase) * amplitude;
    var y = baseY + cos(time * speedY + phase + pi / 3) * amplitude;
    x = (x % 1.0 + 1.0) % 1.0;
    y = (y % 1.0 + 1.0) % 1.0;
    return Offset(x * size.width, y * size.height);
  }
}

// ---------- Particle CustomPainter ----------

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double time;
  final Offset cursorPos;
  final Color primaryColor;

  const _ParticlesPainter({
    required this.particles,
    required this.time,
    required this.cursorPos,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 0.7;
    final dotPaint = Paint();

    // Pre-compute positions
    final positions = particles.map((p) => p.position(time, size)).toList();

    // Draw connections between nearby particles
    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        final dist = (positions[i] - positions[j]).distance;
        if (dist < 125) {
          linePaint.color =
              primaryColor.withOpacity((1 - dist / 125) * 0.18);
          canvas.drawLine(positions[i], positions[j], linePaint);
        }
      }
    }

    // Draw particles with cursor repulsion
    for (int i = 0; i < particles.length; i++) {
      var pos = positions[i];
      final p = particles[i];

      // Cursor repulsion
      final toCursor = pos - cursorPos;
      final dist = toCursor.distance;
      if (dist < 90 && dist > 0) {
        final repel = (1 - dist / 90) * 32;
        pos += toCursor / dist * repel;
      }

      final opacity = 0.35 + (sin(time * 0.8 + p.phase) + 1) / 2 * 0.45;
      dotPaint.color = primaryColor.withOpacity(opacity);
      canvas.drawCircle(pos, p.size, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter old) =>
      old.time != time || old.cursorPos != cursorPos;
}

// ---------- Hero content ----------

class HeroContent extends StatefulWidget {
  final Map<String, GlobalKey> sectionKeys;
  const HeroContent({super.key, required this.sectionKeys});

  @override
  State<HeroContent> createState() => _HeroContentState();
}

class _HeroContentState extends State<HeroContent> {
  bool _showSubtitle = false;
  bool _showIntro = false;
  bool _showArrow = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _showSubtitle = true);
    });
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => _showIntro = true);
    });
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) setState(() => _showArrow = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width > 800;

    final titleStyle = (isWide
            ? textTheme.displayMedium
            : textTheme.displaySmall)
        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

    final subtitleStyle = isWide
        ? textTheme.headlineMedium
            ?.copyWith(color: Theme.of(context).primaryColor)
        : textTheme.headlineSmall
            ?.copyWith(color: Theme.of(context).primaryColor);

    final introStyle = (isWide ? textTheme.titleLarge : textTheme.titleMedium)
        ?.copyWith(color: Colors.white.withOpacity(0.65));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Text('박현렬', style: titleStyle),
          const SizedBox(height: 24),
          if (_showSubtitle)
            SizedBox(
              height: isWide ? 60 : 40,
              child: DefaultTextStyle(
                style: subtitleStyle ?? const TextStyle(),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'A Creative iOS Developer',
                      speed: const Duration(milliseconds: 90),
                    ),
                    TypewriterAnimatedText(
                      'A Proactive Problem Solver',
                      speed: const Duration(milliseconds: 90),
                    ),
                    TypewriterAnimatedText(
                      'A Collaborative Team Player',
                      speed: const Duration(milliseconds: 90),
                    ),
                  ],
                  pause: const Duration(milliseconds: 1200),
                  repeatForever: true,
                ),
              ),
            ),
          const SizedBox(height: 32),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 900),
            opacity: _showIntro ? 1.0 : 0.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * 0.6),
              child: Text(
                '사용자 경험을 최우선으로 생각하며, 안정적이고 확장 가능한 솔루션을 만듭니다.',
                style: introStyle,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          const Spacer(flex: 2),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 900),
            opacity: _showArrow ? 1.0 : 0.0,
            child: ElevatedButton.icon(
              onPressed: () {
                final key = widget.sectionKeys['Profile'];
                if (key?.currentContext != null) {
                  Scrollable.ensureVisible(
                    key!.currentContext!,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              icon: const Icon(Icons.arrow_downward),
              label: const Text('더 알아보기'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                backgroundColor: Colors.transparent,
                shape: const StadiumBorder(),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
