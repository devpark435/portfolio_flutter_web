import 'package:flutter/material.dart';
import '../../domain/models/experience.dart';

class ExperienceCard extends StatefulWidget {
  final Experience experience;
  final bool isMobile;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isMobile,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard>
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

  Color _getExperienceColor() {
    // 3가지 타입으로 구분
    switch (widget.experience.type) {
      case 'work':
        return const Color(0xFF4285F4); // 회사 경력: 파란색
      case 'freelance':
        return const Color(0xFF34A853); // 프리랜서: 초록색
      case 'activity':
        return const Color(0xFF6C63FF); // 활동 경험: 보라색
      default:
        return const Color(0xFF4285F4); // 기본값: 파란색
    }
  }

  String _getExperienceType() {
    // 3가지 타입으로 구분
    switch (widget.experience.type) {
      case 'work':
        return '회사 경력';
      case 'freelance':
        return '프리랜서';
      case 'activity':
        return '활동 경험';
      default:
        return '경력';
    }
  }

  IconData _getExperienceIcon() {
    // 3가지 타입으로 구분
    switch (widget.experience.type) {
      case 'work':
        return Icons.work; // 회사 경력: 일 아이콘
      case 'freelance':
        return Icons.computer; // 프리랜서: 컴퓨터 아이콘
      case 'activity':
        return Icons.groups; // 활동 경험: 그룹 아이콘
      default:
        return Icons.work; // 기본값: 일 아이콘
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = _getExperienceColor();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 헤더 섹션
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getExperienceIcon(),
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
                                widget.experience.title,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: categoryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.experience.period,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.textTheme.bodySmall?.color
                                      ?.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 경력 타입 배지 추가
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: categoryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            _getExperienceType(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 설명 리스트
                    ...widget.experience.description.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                margin: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: categoryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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
