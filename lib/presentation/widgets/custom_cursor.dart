import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class CustomCursor extends ConsumerStatefulWidget {
  const CustomCursor({super.key});

  @override
  ConsumerState<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends ConsumerState<CustomCursor>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Offset _smoothPos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      final target = ref.read(cursorProvider).position;
      final next = Offset.lerp(_smoothPos, target, 0.12)!;
      if ((next - _smoothPos).distance > 0.3) {
        setState(() => _smoothPos = next);
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cursorProvider);
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final ringSize = state.isHovering ? 52.0 : 32.0;
    final dotSize = state.isHovering ? 0.0 : 4.0;
    final hasLabel = state.hoverLabel != null;

    return Stack(
      children: [
        // Outer ring — lagged trailing position
        Positioned(
          left: _smoothPos.dx - ringSize / 2,
          top: _smoothPos.dy - ringSize / 2,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: ringSize,
              height: ringSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: state.isHovering
                      ? primary.withOpacity(0.9)
                      : primary.withOpacity(0.45),
                  width: 1.5,
                ),
                color: state.isHovering
                    ? primary.withOpacity(0.12)
                    : Colors.transparent,
              ),
              child: hasLabel
                  ? Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: state.isHovering ? 1.0 : 0.0,
                        child: Text(
                          state.hoverLabel!,
                          style: TextStyle(
                            color: primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
        // Inner dot — follows cursor directly
        Positioned(
          left: state.position.dx - dotSize / 2,
          top: state.position.dy - dotSize / 2,
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
