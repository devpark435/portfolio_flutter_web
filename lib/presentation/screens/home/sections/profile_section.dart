import 'dart:html' as html;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/profile_info.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ProfileSection extends ConsumerWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '저를 소개합니다'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            return isWide
                ? _buildWideLayout(context, ref)
                : _buildNarrowLayout(context, ref);
          }),
        ],
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildProfileIntro(context, ref)),
        const SizedBox(width: 48),
        Expanded(flex: 3, child: _buildProfileDetails(context)),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildProfileIntro(context, ref),
        const SizedBox(height: 48),
        _buildProfileDetails(context),
      ],
    );
  }

  Widget _buildProfileIntro(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.asset(
              'assets/images/profile.jpg',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ).animate().fadeIn(duration: 800.ms).saturate(),
        ),
        const SizedBox(height: 24),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '박현렬',
              textStyle: theme.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              speed: const Duration(milliseconds: 150),
            ),
          ],
          totalRepeatCount: 1,
        ),
        const SizedBox(height: 16),
        Text(
          profileBio,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 32),
        _buildSocialAndResumeButtons(context, ref),
      ],
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        color: theme.cardColor.withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: profileDetails.map((info) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    info.label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color:
                          theme.textTheme.titleSmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    info.values.join('\n'),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildSocialAndResumeButtons(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ...socialLinks.entries.map((entry) {
          return IconButton(
            icon: FaIcon(entry.key == 'github'
                ? FontAwesomeIcons.github
                : FontAwesomeIcons.rss),
            onPressed: () => launchUrl(Uri.parse(entry.value)),
            tooltip: entry.key,
          );
        }),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {
            // PDF 파일 다운로드 (웹 전용)
            html.AnchorElement(href: 'assets/assets/docs/portfolio.pdf')
              ..setAttribute('download', 'portfolio_parkhyunryeol.pdf')
              ..click();
          },
          icon: const Icon(Icons.download),
          label: const Text('이력서 다운로드'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ],
    );
  }
}
