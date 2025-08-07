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
import 'package:portfolio_web/presentation/widgets/theme_toggle_button.dart';

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
    _scrollController.addListener(() {
      final scrollNotifier = ref.read(scrollProvider.notifier);
      scrollNotifier.updateScroll(_scrollController.position.pixels /
          _scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollProgress = ref.watch(scrollProvider);

    return Scaffold(
      endDrawer: MediaQuery.of(context).size.width <= 800
          ? _buildMobileDrawer(context)
          : null,
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
                    child: HeroSection(sectionKeys: _sectionKeys)),
                SliverToBoxAdapter(
                  key: _sectionKeys['Profile'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const ProfileSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Experience'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
                    child: const ExperienceSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Awards'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const AwardsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Projects'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
                    child: const ProjectsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Skills'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const SkillsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: _sectionKeys['Contact'],
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
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
                final key = _sectionKeys[title];
                if (key?.currentContext != null) {
                  Scrollable.ensureVisible(
                    key!.currentContext!,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
                Navigator.of(context).pop(); // Close the drawer
              },
            );
          }),
        ],
      ),
    );
  }
}
