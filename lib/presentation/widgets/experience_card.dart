import 'package:flutter/material.dart';
import '../../domain/models/experience.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isMobile;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final title = Text(
      experience.title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
    );

    final period = Text(
      experience.period,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey,
          ),
    );

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SizedBox(height: 8),
              period,
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [title, period],
          );
  }

  Widget _buildDescription() {
    return Column(
      children: experience.description
          .map((item) => _buildDescriptionItem(item))
          .toList(),
    );
  }

  Widget _buildDescriptionItem(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(item)),
        ],
      ),
    );
  }
}
