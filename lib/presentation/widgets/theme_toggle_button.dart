import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode
              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              : Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: [
              // This is the moving circle (thumb)
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              // Icons are positioned in the center of the switch
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    isDarkMode ? Alignment.centerLeft : Alignment.centerRight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: isDarkMode
                      ? Icon(
                          Icons.dark_mode,
                          key: const ValueKey('dark_icon'),
                          color: Colors.yellow[700],
                          size: 20,
                        )
                      : Icon(
                          Icons.light_mode,
                          key: const ValueKey('light_icon'),
                          color: Colors.orange,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
