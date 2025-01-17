import 'package:flutter/material.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';
import 'package:portfolio_web/presentation/widgets/section_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildContactButton(
                context,
                'GitHub',
                Icons.code,
                'https://github.com/devpark435',
              ),
              _buildContactButton(
                context,
                'LinkedIn',
                Icons.business_center,
                'https://linkedin.com/in/yourusername',
              ),
              _buildContactButton(
                context,
                'Email',
                Icons.email,
                'mailto:your.email@example.com',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context,
    String label,
    IconData icon,
    String url,
  ) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
    );
  }
}
