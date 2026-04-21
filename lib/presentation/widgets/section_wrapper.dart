import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class SectionWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const SectionWrapper({super.key, required this.child});

  @override
  ConsumerState<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends ConsumerState<SectionWrapper> {
  final _containerKey = GlobalKey();
  AnimationController? _animController;
  bool _hasAnimated = false;
  bool _controllerReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted || !_controllerReady) return;
    final ctx = _containerKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final screenH = MediaQuery.of(context).size.height;
    if (box.localToGlobal(Offset.zero).dy < screenH * 0.9) {
      _hasAnimated = true;
      _animController?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<double>(scrollPixelsProvider, (_, __) => _checkVisibility());

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        double h, v;
        if (width > 1200) {
          h = 120;
          v = 100;
        } else if (width > 800) {
          h = 60;
          v = 80;
        } else {
          h = 24;
          v = 60;
        }

        return Animate(
          autoPlay: false,
          onInit: (controller) {
            _animController = controller;
            _controllerReady = true;
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _checkVisibility());
          },
          effects: const [
            FadeEffect(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeOut,
            ),
            SlideEffect(
              begin: Offset(0, 0.06),
              end: Offset.zero,
              duration: Duration(milliseconds: 700),
              curve: Curves.easeOut,
            ),
          ],
          child: Container(
            key: _containerKey,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
