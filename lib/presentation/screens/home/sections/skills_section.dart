import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200
        ? 3
        : width > 800
            ? 2
            : 1;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 64,
        horizontal: width > 800 ? 32 : 16,
      ),
      child: Column(
        children: [
          const SectionTitle(title: "기술 스택"),
          const SizedBox(height: 48),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: width > 800 ? 1.2 : 1.0,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSkillCard(
                context,
                'Flutter Development',
                ['Flutter/Dart', 'Riverpod', 'Cubit'],
              ),
              _buildSkillCard(
                context,
                'iOS Development',
                [
                  'Swift',
                  'UIKit',
                  'SwiftUI',
                  'AutoLayout',
                  'Combine',
                  'RxSwift'
                ],
              ),
              _buildSkillCard(
                context,
                'Backend Services',
                ['Firebase', 'Supabase', 'Spring'],
              ),
              _buildSkillCard(
                context,
                'Development Tools',
                ['Git/GitHub', 'Figma', 'Slack'],
              ),
              _buildSkillCard(
                context,
                'Architecture & Design Patterns',
                [
                  'MVC',
                  'MVVM',
                  'Clean Architecture',
                  'Repository Pattern',
                  'Singleton Pattern',
                  'Observer Pattern'
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(
      BuildContext context, String title, List<String> skills) {
    IconData getTitleIcon() {
      switch (title) {
        case 'Flutter Development':
          return Icons.flutter_dash;
        case 'iOS Development':
          return Icons.phone_iphone;
        case 'Backend Services':
          return Icons.cloud;
        case 'Development Tools':
          return Icons.code;
        case 'Architecture & Design Patterns':
          return Icons.architecture;
        default:
          return Icons.code;
      }
    }

    final backgroundColor = Theme.of(context).cardColor;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      elevation: 4,
      color: backgroundColor,
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Icon(
                    getTitleIcon(),
                    color: primaryColor,
                    size: 24,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...skills.map((skill) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
