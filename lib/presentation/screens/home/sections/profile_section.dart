import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

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
          Text(
            '프로필',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 48),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/profile.jpg'), // 프로필 이미지 추가
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(context, '이름', '홍길동'),
                  _buildInfoRow(context, '나이', '25'),
                  _buildInfoRow(context, '성별', '남성'),
                  _buildInfoRow(context, '학력', '한국대학교 컴퓨터공학과'),
                  _buildInfoRow(
                      context, '관심 분야', 'Flutter, Web Development, AI'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
