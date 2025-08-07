import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/presentation/widgets/section_wrapper.dart';
import 'package:portfolio_web/presentation/widgets/contact_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.surface.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Got a project?',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '새로운 기회를 찾고 있습니다. 함께 멋진 프로젝트를 만들어봐요!\n아래 편한 방법으로 연락주시면 빠르게 답변드리겠습니다.',
              style: theme.textTheme.titleMedium?.copyWith(
                height: 1.6,
                color: theme.textTheme.titleMedium?.color?.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                textStyle: theme.textTheme.titleLarge,
              ),
              child: const Text('devpark435@gmail.com'),
            ),
            const SizedBox(height: 32),
            Text(
              'Or find me on social media',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                ContactButton(
                  label: 'GitHub',
                  icon: Icons.code,
                  url: 'https://github.com/epreep',
                ),
                ContactButton(
                  label: 'LinkedIn',
                  icon: Icons.business_center,
                  url:
                      'https://www.linkedin.com/in/%ED%98%84%EB%A0%AC%EB%B0%95/',
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms).moveY(begin: 50),
    );
  }
}
