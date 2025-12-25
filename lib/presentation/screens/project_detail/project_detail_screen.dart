import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/config/providers/providers.dart';
import '../../../domain/models/project.dart';
import '../../../domain/models/troubleshooting.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
            child: Text('Error: $err',
                style: const TextStyle(color: Colors.white))),
      ),
      data: (projects) {
        final project = projects.firstWhere((p) => p.id == projectId);

        return Scaffold(
          backgroundColor: const Color(0xFF121212), // 다크 테마 배경
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context, project),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSection(context, project),
                      const SizedBox(height: 32),
                      _buildActionButtons(context, project),
                      const SizedBox(height: 40),
                      _buildTechStack(context, project),
                      const SizedBox(height: 48),
                      _buildSectionTitle(context, '프로젝트 개요'),
                      _buildDescriptionText(context, project.summary),
                      const SizedBox(height: 24),
                      _buildInfoGrid(context, project),
                      const SizedBox(height: 48),
                      if (project.background.isNotEmpty) ...[
                        _buildSectionTitle(context, '개발 배경'),
                        _buildDescriptionText(context, project.background),
                        const SizedBox(height: 48),
                      ],
                      if (project.keyFeatures.isNotEmpty) ...[
                        _buildSectionTitle(context, '주요 기능'),
                        _buildFeatureList(context, project.keyFeatures),
                        const SizedBox(height: 48),
                      ],
                      if (project.troubleshooting.isNotEmpty) ...[
                        _buildSectionTitle(context, 'Troubleshooting'),
                        _buildTroubleshootingList(
                            context, project.troubleshooting),
                        const SizedBox(height: 48),
                      ],
                      if (project.releaseLogs != null &&
                          project.releaseLogs!.isNotEmpty) ...[
                        _buildSectionTitle(context, '릴리즈 노트'),
                        _buildReleaseLogs(context, project.releaseLogs!),
                        const SizedBox(height: 48),
                      ],
                      // 하단 여백
                      const SizedBox(height: 60),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.05, end: 0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Project project) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: const Color(0xFF121212),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (project.imageUrl != null)
              Hero(
                tag: 'project_image_${project.id}',
                child: Image.asset(
                  'assets/${project.imageUrl!}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[900]),
                ),
              ),
            // 그라데이션 오버레이 (텍스트 가독성 및 자연스러운 전환)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    const Color(0xFF121212).withOpacity(0.8),
                    const Color(0xFF121212),
                  ],
                  stops: const [0.0, 0.4, 0.85, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.period,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.teamSize,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, Project project) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (project.deployUrl != null)
          _buildPillButton(
            context,
            label: '배포 링크',
            icon: Icons.rocket_launch,
            url: project.deployUrl!,
            isPrimary: true,
          ),
        if (project.demoUrl != null)
          _buildPillButton(
            context,
            label: '라이브 데모',
            icon: Icons.play_circle_outline,
            url: project.demoUrl!,
            isPrimary: project.deployUrl == null,
          ),
        if (project.githubUrl != null)
          _buildPillButton(
            context,
            label: '소스 코드',
            icon: Icons.code,
            url: project.githubUrl!,
            isPrimary: false,
          ),
      ],
    );
  }

  Widget _buildPillButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String url,
    bool isPrimary = false,
  }) {
    final primaryColor = Theme.of(context).primaryColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) await launchUrl(uri);
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isPrimary ? primaryColor : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: isPrimary
                ? null
                : Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary ? Colors.white : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechStack(BuildContext context, Project project) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: project.technologies.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tech,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[300],
        fontSize: 16,
        height: 1.7,
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context, Project project) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          if (project.responsibilities.isNotEmpty)
            _buildInfoRow('담당 업무', project.responsibilities.join('\n')),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList(BuildContext context, List<String> features) {
    return Column(
      children: features.map((feature) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 중앙 정렬
            children: [
              Icon(
                Icons.auto_awesome, // 체크 아이콘보다 조금 더 풍부한 느낌
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTroubleshootingList(
      BuildContext context, List<Troubleshooting> items) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(color: Colors.white.withOpacity(0.1), width: 2)),
      ),
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.issue,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTsDetail('상황', item.context),
                const SizedBox(height: 16),
                _buildTsDetail('해결', item.solution, isHighlight: true),
                const SizedBox(height: 16),
                _buildTsDetail('배운점', item.learning),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTsDetail(String label, String content,
      {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isHighlight ? const Color(0xFF64B5F6) : Colors.grey[500],
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildReleaseLogs(BuildContext context, List<ReleaseLog> logs) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(color: Colors.white.withOpacity(0.1), width: 2)),
      ),
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        children: logs.map((log) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'v${log.version}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      log.date,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...log.changes.map((change) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                              style: TextStyle(color: Colors.grey)),
                          Expanded(
                            child: Text(
                              change,
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
