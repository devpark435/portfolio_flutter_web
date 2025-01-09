import 'package:flutter/material.dart';
import 'package:portfolio_web/presentation/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 64,
        horizontal: width > 800 ? 32 : 16,
      ),
      child: Column(
        children: [
          const SectionTitle(title: '활동 경험'),
          const SizedBox(height: 48),
          _buildExperienceTimeline(context),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildExperienceItem(
              context,
              title: '대학교 프로그래밍 동아리',
              role: '프론트엔드 개발 팀장',
              period: '2023.03 - 현재',
              description: [
                '동아리 웹사이트 개발 및 유지보수',
                '신입 회원 대상 Flutter/React 교육 진행',
                '팀 프로젝트 3개 리드',
              ],
            ),
            _buildExperienceItem(
              context,
              title: '프리랜서 외주 프로젝트',
              role: '프론트엔드 개발자',
              period: '2023.06 - 2023.08',
              description: [
                '로컬 카페 웹사이트 제작',
                'Flutter Web 활용한 반응형 디자인 구현',
                '주문 관리 시스템 개발',
              ],
            ),
            _buildExperienceItem(
              context,
              title: '교내 해커톤 참가',
              role: '풀스택 개발자',
              period: '2023.09',
              description: [
                'AI 기반 학습 플랫폼 개발',
                'Flutter와 Firebase 활용',
                '우수상 수상',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context, {
    required String title,
    required String role,
    required String period,
    required List<String> description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Text(
                  period,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...description.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(item)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
