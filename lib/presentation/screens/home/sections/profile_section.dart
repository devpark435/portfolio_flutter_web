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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile
                    ? 20.0 // 모바일일 때 패딩
                    : 42.0 // 데스크톱일 때 패딩
                ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: isMobile
                    ? Column(
                        children: profileInfos
                            .map((info) => ProfileInfoItem(
                                  info: info,
                                  isMobile: true,
                                ))
                            .toList(),
                      )
                    : Row(
                        // 2열 구조
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // 왼쪽 열
                            child: Column(
                              children: profileInfos
                                  .take(3)
                                  .map((info) => ProfileInfoItem(
                                        info: info,
                                        isMobile: false,
                                      ))
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            // 오른쪽 열
                            child: Column(
                              children: profileInfos
                                  .skip(3)
                                  .take(3)
                                  .map((info) => ProfileInfoItem(
                                        info: info,
                                        isMobile: false,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
