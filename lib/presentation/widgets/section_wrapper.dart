import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const SectionWrapper({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
        color: backgroundColor,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 64,
              horizontal: width > 800 ? 32 : 16,
            ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900), // 최대 너비 제한
            child: child,
          ),
        ),
      ),
    );
  }
}
