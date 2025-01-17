import 'package:flutter/material.dart';
import '../../../../data/profile_info.dart';
import '../../../widgets/profile_info_item.dart';
import '../../../widgets/section_title.dart';
import '../../../widgets/section_wrapper.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= 800;

    return SectionWrapper(
      child: Column(
        children: [
          const SectionTitle(title: '프로필'),
          const SizedBox(height: 48),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(height: 24),
                  ...profileInfos.map(
                    (info) => ProfileInfoItem(
                      info: info,
                      isMobile: isMobile,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
