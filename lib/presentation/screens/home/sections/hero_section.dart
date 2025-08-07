import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../widgets/contact_button.dart';
import '../../../widgets/section_wrapper.dart';

class HeroSection extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  const HeroSection({super.key, required this.sectionKeys});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          const PlasmaBackground(),
          HeroContent(sectionKeys: sectionKeys),
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
