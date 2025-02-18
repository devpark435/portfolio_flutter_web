import 'package:flutter/material.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';
import 'package:portfolio_web/presentation/widgets/section_wrapper.dart';
import 'package:portfolio_web/presentation/widgets/contact_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '연락하기'),
          const SizedBox(height: 24),
          Text(
            '새로운 기회를 찾고 있습니다.\n언제든 연락주세요.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ContactButton(
                label: 'GitHub',
                icon: Icons.code,
                url: 'https://github.com/devpark435',
              ),
              ContactButton(
                label: 'LinkedIn',
                icon: Icons.business_center,
                url: 'https://linkedin.com/in/yourusername',
              ),
              ContactButton(
                label: 'Email',
                icon: Icons.email,
                url: 'mailto:your.email@example.com',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
