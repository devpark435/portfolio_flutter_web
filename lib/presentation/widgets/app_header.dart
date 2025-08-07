import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/widgets/theme_toggle_button.dart';

class AppHeader extends ConsumerWidget {
  final Map<String, GlobalKey> sectionKeys;

  const AppHeader({super.key, required this.sectionKeys});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollProgress = ref.watch(scrollProvider);
    final theme = Theme.of(context);
    final isScrolled = scrollProgress > 0.05;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: isScrolled
            ? theme.scaffoldBackgroundColor.withOpacity(0.85)
            : Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Portfolio',
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (MediaQuery.of(context).size.width > 800)
            Row(
              children: [
                ...sectionKeys.keys.map((title) {
                  return _HeaderButton(
                    title: title,
                    onPressed: () {
                      final key = sectionKeys[title];
                      if (key?.currentContext != null) {
                        Scrollable.ensureVisible(
                          key!.currentContext!,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  );
                }),
                const SizedBox(width: 24),
                const ThemeToggleButton(),
              ],
            ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const _HeaderButton({required this.title, required this.onPressed});

  @override
  State<_HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<_HeaderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: _isHovered
                ? theme.colorScheme.primary
                : theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
