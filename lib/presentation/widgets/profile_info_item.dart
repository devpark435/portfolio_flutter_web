import 'package:flutter/material.dart';
import '../../domain/models/profile_info.dart';

class ProfileInfoItem extends StatelessWidget {
  final ProfileInfo info;
  final bool isMobile;

  const ProfileInfoItem({
    super.key,
    required this.info,
    required this.isMobile,
  });

  IconData _getIcon() {
    switch (info.label) {
      case '이름':
        return Icons.person;
      case '생년월일':
        return Icons.calendar_today;
      case '위치':
        return Icons.location_on;
      case '연락처':
        return Icons.phone;
      case '이메일':
        return Icons.email;
      case '학력':
        return Icons.school;
      case '관심 분야':
        return Icons.lightbulb;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileLayout(context);
    }
    return _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getIcon(),
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 4),
                ...info.values.map(
                  (value) => Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final textColor = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 좌우 정렬
        children: [
          SizedBox(
            // 왼쪽 영역
            width: 300, // 고정 너비
            child: Row(
              children: [
                Icon(
                  _getIcon(),
                  color: textColor,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 4),
                    ...info.values.map((value) => Text(
                          value,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
