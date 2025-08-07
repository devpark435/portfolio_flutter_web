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
import 'package:portfolio_web/presentation/widgets/custom_cursor.dart';
import 'package:portfolio_web/presentation/widgets/theme_toggle_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollProvider.notifier);
    final scrollNotifier = ScrollController();

    scrollNotifier.addListener(() {
      scrollController.updateScroll(scrollNotifier.position.pixels /
          scrollNotifier.position.maxScrollExtent);
    });
    final scrollProgress = ref.watch(scrollProvider);

    return Scaffold(
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          ref.read(cursorProvider.notifier).updatePosition(event.position);
        },
        child: Stack(
          children: [
            CustomScrollView(
              controller: scrollNotifier,
              slivers: [
                const SliverToBoxAdapter(child: HeroSection()),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const ProfileSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
                    child: const ExperienceSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const AwardsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
                    child: const ProjectsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const SkillsSection(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface.withAlpha(50),
                    child: const ContactSection(),
                  ),
                ),
              ],
            ),
            if (scrollProgress > 0)
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
            const Positioned(
              top: 20,
              right: 20,
              child: ThemeToggleButton(),
            ),
            const CustomCursor(),
          ],
        ),
      ),
    );
  }
}
