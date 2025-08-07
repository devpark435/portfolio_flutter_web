import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  const SectionWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double horizontalPadding;
        double verticalPadding;

        if (width > 1200) {
          horizontalPadding = 120;
          verticalPadding = 100;
        } else if (width > 800) {
          horizontalPadding = 60;
          verticalPadding = 80;
        } else {
          horizontalPadding = 24;
          verticalPadding = 60;
        }

        return Animate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 600), curve: Curves.easeOut),
            SlideEffect(
              begin: Offset(0, 0.1),
              end: Offset.zero,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOut,
            ),
          ],
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200), // 최대 너비 제한
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
