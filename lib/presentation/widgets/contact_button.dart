import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;

  const ContactButton({
    super.key,
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
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
