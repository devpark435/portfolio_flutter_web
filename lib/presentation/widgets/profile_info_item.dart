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

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), // 좌우 패딩 추가로 화면 가장자리와 간격 확보
      child: Row(
        // Column 대신 Row 사용
        children: [
          Expanded(
            // 텍스트들이 전체 너비를 사용하도록
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 모든 텍스트 좌측 정렬
              children: [
                Text(
                  info.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 8),
                ...info.values.map(
                  (value) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              info.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: info.values
                  .map((value) => Text(
                        value,
                        style: Theme.of(context).textTheme.titleMedium,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
