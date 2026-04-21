import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/screens/home/sections/award_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/contact_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/experience_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/hero_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/profile_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/project_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/skills_section.dart';
import 'package:portfolio_web/presentation/widgets/app_header.dart';
import 'package:portfolio_web/presentation/widgets/custom_cursor.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final Map<String, GlobalKey> _sectionKeys = {
    'Profile': GlobalKey(),
    'Experience': GlobalKey(),
    'Awards': GlobalKey(),
    'Projects': GlobalKey(),
    'Skills': GlobalKey(),
    'Contact': GlobalKey(),
  };

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pixels = _scrollController.position.pixels;
    final maxExtent = _scrollController.position.maxScrollExtent;

    ref.read(scrollProvider.notifier).updateScroll(
        maxExtent > 0 ? pixels / maxExtent : 0);
    ref.read(scrollPixelsProvider.notifier).state = pixels;
    _updateActiveSection();
  }

  void _updateActiveSection() {
    if (!mounted) return;
    String active = _sectionKeys.keys.first;
    const threshold = 120.0; // header height + buffer

    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final dy = box.localToGlobal(Offset.zero).dy;
      if (dy <= threshold) active = entry.key;
    }

    final current = ref.read(activeSectionProvider);
    if (current != active) {
      ref.read(activeSectionProvider.notifier).state = active;
    }
  }

  void _scrollToSection(String name) {
    final key = _sectionKeys[name];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollProgress = ref.watch(scrollProvider);
    final activeSection = ref.watch(activeSectionProvider);
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      endDrawer: !isWide ? _buildMobileDrawer(context) : null,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          ref.read(cursorProvider.notifier).updatePosition(event.position);
        },
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: HeroSection(sectionKeys: _sectionKeys),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Profile'],
                  child: _SectionBg(
                    blob: _BlobVariant.topRight,
                    child: const ProfileSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Experience'],
                  child: _SectionBg(
                    alternate: true,
                    child: const ExperienceSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Awards'],
                  child: _SectionBg(
                    blob: _BlobVariant.bottomLeft,
                    child: const AwardsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Projects'],
                  child: _SectionBg(
                    alternate: true,
                    blob: _BlobVariant.topRight,
                    child: const ProjectsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Skills'],
                  child: _SectionBg(
                    blob: _BlobVariant.center,
                    child: const SkillsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Contact'],
                  child: _SectionBg(
                    alternate: true,
                    child: const ContactSection(),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppHeader(sectionKeys: _sectionKeys),
            ),
            if (scrollProgress > 0 && scrollProgress < 1)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: scrollProgress,
                  backgroundColor: Colors.transparent,
                  minHeight: 2,
                ),
              ),
            // Side section indicator (desktop only)
            if (isWide)
              Positioned(
                right: 24,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _SideIndicator(
                    sections: _sectionKeys.keys.toList(),
                    activeSection: activeSection,
                    onTap: _scrollToSection,
                  ),
                ),
              ),
            const CustomCursor(),
          ],
        ),
      ),
    );
  }

  Drawer _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'Navigation',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ..._sectionKeys.keys.map((title) {
            return ListTile(
              title: Text(title),
              onTap: () {
                _scrollToSection(title);
                Navigator.of(context).pop();
              },
            );
          }),
        ],
      ),
    );
  }
}

// ---------- Section background with optional gradient blob ----------

enum _BlobVariant { topRight, bottomLeft, center }

class _SectionBg extends StatelessWidget {
  final Widget child;
  final bool alternate;
  final _BlobVariant? blob;

  const _SectionBg({
    required this.child,
    this.alternate = false,
    this.blob,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = alternate
        ? theme.colorScheme.surface.withOpacity(0.6)
        : theme.colorScheme.surface;

    return Container(
      color: bg,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (blob != null && isDark) _buildBlob(context, blob!),
          child,
        ],
      ),
    );
  }

  Widget _buildBlob(BuildContext context, _BlobVariant variant) {
    final primary = Theme.of(context).colorScheme.primary;
    AlignmentGeometry align;
    switch (variant) {
      case _BlobVariant.topRight:
        align = Alignment.topRight;
        break;
      case _BlobVariant.bottomLeft:
        align = Alignment.bottomLeft;
        break;
      case _BlobVariant.center:
        align = Alignment.center;
        break;
    }
    return Positioned.fill(
      child: Align(
        alignment: align,
        child: IgnorePointer(
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primary.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Side section indicator ----------

class _SideIndicator extends StatelessWidget {
  final List<String> sections;
  final String activeSection;
  final void Function(String) onTap;

  const _SideIndicator({
    required this.sections,
    required this.activeSection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: sections.map((title) {
        final isActive = activeSection == title;
        return Tooltip(
          message: title,
          preferBelow: false,
          child: GestureDetector(
            onTap: () => onTap(title),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOut,
                  width: isActive ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isActive
                        ? primary
                        : primary.withOpacity(0.28),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
