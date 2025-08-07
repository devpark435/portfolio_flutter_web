import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:simple_animations/simple_animations.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Stack(
        children: [
          PlasmaBackground(),
          HeroContent(),
        ],
      ),
    );
  }
}

class PlasmaBackground extends StatelessWidget {
  const PlasmaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 15),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF2C3E50),
                Color(0xFF34495E),
                Color(0xFF2C3E50),
              ],
              stops: [0.0, value, 1.0],
            ),
          ),
        );
      },
    );
  }
}

class HeroContent extends StatefulWidget {
  const HeroContent({super.key});

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
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _showSubtitle = true);
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showIntro = true);
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) setState(() => _showArrow = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final bool isWideScreen = width > 800;

    final titleStyle = isWideScreen
        ? textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        : textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          );

    final subtitleStyle = isWideScreen
        ? textTheme.headlineMedium
            ?.copyWith(color: Theme.of(context).primaryColor)
        : textTheme.headlineSmall
            ?.copyWith(color: Theme.of(context).primaryColor);

    final introStyle = isWideScreen
        ? textTheme.titleLarge?.copyWith(color: Colors.white70)
        : textTheme.titleMedium?.copyWith(color: Colors.white70);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Text('박현렬', style: titleStyle),
          const SizedBox(height: 24),
          if (_showSubtitle)
            SizedBox(
              height: isWideScreen ? 60 : 40,
              child: DefaultTextStyle(
                style: subtitleStyle!,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'A Creative iOS Developer',
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'A Proactive Problem Solver',
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'A Collaborative Team Player',
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  pause: const Duration(milliseconds: 1000),
                  repeatForever: true,
                ),
              ),
            ),
          const SizedBox(height: 32),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
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
            duration: const Duration(milliseconds: 800),
            opacity: _showArrow ? 1.0 : 0.0,
            child: const _BouncingArrow(),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();

  @override
  _BouncingArrowState createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Scroll Down',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ],
          ),
        );
      },
    );
  }
}
