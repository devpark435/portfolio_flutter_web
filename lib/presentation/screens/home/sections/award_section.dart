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
            Column(
              children: [
                _buildAwardItem(
                  context,
                  title: '스파르타 내일배움캠프',
                  date: 'July 5, 2024',
                  award: '우수상',
                ),
                const SizedBox(height: 16),
                _buildAwardItem(
                  context,
                  title: 'GDSC 연합 해커톤',
                  date: 'May 19, 2023',
                  award: '3등',
                ),
                const SizedBox(height: 16),
                _buildAwardItem(
                  context,
                  title: 'GDSC SKHU 해커톤',
                  date: 'January 27, 2023',
                  award: '인기상',
                ),
                const SizedBox(height: 16),
                _buildAwardItem(
                  context,
                  title: 'GDSC 미니 프로젝트',
                  date: 'January 13, 2023',
                  award: '2등',
                ),
                const SizedBox(height: 16),
                _buildAwardItem(
                  context,
                  title: '성공회 대학교 교내 경진 대회',
                  date: 'April 14, 2019',
                  award: '장려상',
                ),
              ],
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
    return _AwardCard(
      title: title,
      date: date,
      award: award,
    );
  }
}

class _AwardCard extends StatefulWidget {
  final String title;
  final String date;
  final String award;

  const _AwardCard({
    required this.title,
    required this.date,
    required this.award,
  });

  @override
  State<_AwardCard> createState() => _AwardCardState();
}

class _AwardCardState extends State<_AwardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getAwardColor(String award) {
    // 수상 등급에 따른 색상 지정
    switch (award) {
      case '1등':
      case '금상':
      case '대상':
      case '우수상':
      case '인기상':
        return const Color(0xFFFFD700); // Gold
      case '2등':
      case '은상':
        return const Color(0xFFC0C0C0); // Silver
      case '3등':
      case '동상':
      case '장려상':
        return const Color(0xFFCD7F32); // Bronze
      default:
        return const Color(0xFF4285F4); // Blue
    }
  }

  IconData _getAwardIcon(String award) {
    // 수상 등급에 따른 아이콘 지정
    switch (award) {
      case '1등':
      case '금상':
      case '대상':
      case '우수상':
        return Icons.emoji_events;
      case '2등':
      case '은상':
        return Icons.emoji_events;
      case '3등':
      case '동상':
      case '장려상':
        return Icons.emoji_events;
      case '인기상':
        return Icons.favorite;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = _getAwardColor(widget.award);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    categoryColor.withOpacity(0.1),
                    categoryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
                border: Border.all(
                  color: categoryColor.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: categoryColor.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getAwardIcon(widget.award),
                        color: categoryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: categoryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.award,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: categoryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
