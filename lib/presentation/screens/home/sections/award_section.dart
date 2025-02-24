import 'package:flutter/material.dart';

import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SectionWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width > 800
                ? 42.0 // 데스크톱일 때 패딩
                : 20.0 // 모바일일 때 패딩
            ),
        child: Column(
          children: [
            const SectionTitle(title: '수상 경력'),
            const SizedBox(height: 48),
            Card(
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildAwardItem(
                    context,
                    title: '스파르타 내일배움캠프',
                    date: 'July 5, 2024',
                    award: '우수상',
                  ),
                  _buildAwardItem(
                    context,
                    title: 'GDSC 연합 해커톤',
                    date: 'May 19, 2023',
                    award: '3등',
                  ),
                  _buildAwardItem(
                    context,
                    title: 'GDSC SKHU 해커톤',
                    date: 'January 27, 2023',
                    award: '인기상',
                  ),
                  _buildAwardItem(
                    context,
                    title: 'GDSC 미니 프로젝트',
                    date: 'January 13, 2023',
                    award: '2등',
                  ),
                  _buildAwardItem(
                    context,
                    title: '성공회 대학교 교내 경진 대회',
                    date: 'April 14, 2019',
                    award: '장려상',
                  ),
                  // ... 다른 수상 내역
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardItem(
    BuildContext context, {
    required String title,
    required String date,
    required String award,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_events, color: primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getAwardColor(award).withAlpha(50),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              award,
              style: theme.textTheme.titleMedium?.copyWith(
                color: _getAwardColor(award),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getAwardColor(String award) {
    // 수상 등급에 따른 색상 지정
    switch (award) {
      case '1등':
      case '금상':
      case '대상':
      case '우수상':
      case '인기상':
        return Colors.amber;
      case '2등':
      case '은상':
        return Colors.blueGrey;
      case '3등':
      case '동상':
      case '장려상':
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}
