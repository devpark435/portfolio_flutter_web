import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class CustomCursor extends ConsumerWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursorState = ref.watch(cursorProvider);
    final theme = Theme.of(context);

    return Positioned(
      left: cursorState.position.dx - 16,
      top: cursorState.position.dy - 16,
      child: IgnorePointer(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: cursorState.isHovering
                  ? theme.colorScheme.primary.withOpacity(0.8)
                  : theme.colorScheme.primary.withOpacity(0.5),
              width: 2,
            ),
            color: cursorState.isHovering
                ? theme.colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: cursorState.isHovering ? 0 : 4,
              height: cursorState.isHovering ? 0 : 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
