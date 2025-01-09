import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Text(
            '연락하기',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Text(
            '새로운 기회를 찾고 있습니다.\n언제든 연락주세요.',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContactButton(
                context,
                'GitHub',
                Icons.code,
                'https://github.com/devpark435',
              ),
              const SizedBox(width: 16),
              _buildContactButton(
                context,
                'LinkedIn',
                Icons.business_center,
                'https://linkedin.com/in/yourusername',
              ),
              const SizedBox(width: 16),
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
