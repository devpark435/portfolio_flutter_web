import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import 'package:portfolio_web/presentation/screens/home/sections/contact_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/experience_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/profile_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/projects_section.dart';
import 'package:portfolio_web/presentation/screens/home/sections/skills_section.dart';
import 'sections/hero_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollProgress = ref.watch(scrollProvider);

    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                ref.read(scrollProvider.notifier).updateScroll(
                    notification.metrics.pixels /
                        notification.metrics.maxScrollExtent);
              }
              return true;
            },
            child: const CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: HeroSection()),
                SliverToBoxAdapter(child: ProfileSection()),
                SliverToBoxAdapter(child: ExperienceSection()),
                SliverToBoxAdapter(child: ProjectsSection()),
                SliverToBoxAdapter(child: SkillsSection()),
                SliverToBoxAdapter(child: ContactSection()),
              ],
            ),
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
        ],
      ),
    );
  }
}
