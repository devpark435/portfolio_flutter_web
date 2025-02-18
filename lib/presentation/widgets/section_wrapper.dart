import 'package:flutter/material.dart';

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

    return Container(
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
    );
  }
}
