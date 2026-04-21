import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class ScrollRevealWidget extends ConsumerStatefulWidget {
  final Widget child;
  final Duration delay;

  const ScrollRevealWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  ConsumerState<ScrollRevealWidget> createState() => _ScrollRevealWidgetState();
}

class _ScrollRevealWidgetState extends ConsumerState<ScrollRevealWidget> {
  final _key = GlobalKey();
  AnimationController? _ctrl;
  bool _hasRevealed = false;
  bool _ctrlReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_hasRevealed || !mounted || !_ctrlReady) return;
    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final screenH = MediaQuery.of(context).size.height;
    if (box.localToGlobal(Offset.zero).dy < screenH * 0.92) {
      _hasRevealed = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl?.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<double>(scrollPixelsProvider, (_, __) => _check());

    return Animate(
      key: _key,
      autoPlay: false,
      onInit: (controller) {
        _ctrl = controller;
        _ctrlReady = true;
        WidgetsBinding.instance.addPostFrameCallback((_) => _check());
      },
      effects: [
        FadeEffect(duration: 550.ms, curve: Curves.easeOut),
        MoveEffect(
          begin: const Offset(0, 28),
          end: Offset.zero,
          duration: 550.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: widget.child,
    );
  }
}
