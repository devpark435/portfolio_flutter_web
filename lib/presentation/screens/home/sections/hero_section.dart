import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../widgets/section_wrapper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textStyle = width > 800
        ? Theme.of(context).textTheme.displaySmall
        : Theme.of(context).textTheme.headlineMedium;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withAlpha(25),
            Theme.of(context).primaryColor.withAlpha(50),
          ],
        ),
      ),
      child: SectionWrapper(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '안녕하세요,',
                  style: textStyle,
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width > 800 ? width * 0.8 : width * 0.9,
                  ),
                  child: DefaultTextStyle(
                    style: textStyle!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '문제 해결에 집중하는 개발자',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '박현렬입니다',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
