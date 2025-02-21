import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

class ProjectRepository {
  Future<List<Project>> getProjects() async {
    return [
      Project(
          id: '1',
          title: '식목일(식단, 목표, 일일운동량)',
          summary: '운동과 식단 관리를 위한 올인원 헬스케어 플랫폼',
          keyFeatures: [
            '소셜 로그인 및 회원 관리',
            '커스텀 캘린더를 통한 일정 관리',
            '운동 및 식단 기록 시스템',
            '목표 설정 및 달성 트래킹',
            '푸시 알림 서비스'
          ],
          background: '''
건강에 대한 관심이 높아지는 현대 사회에서, 운동과 식단을 통합적으로 관리할 수 있는 
플랫폼의 필요성을 인식하고 개발을 시작했습니다. 특히 직관적인 UI/UX를 통해 
사용자들이 쉽게 건강 관리를 할 수 있도록 하는 것에 중점을 두었습니다.
''',
          meaning: '''
iOS 앱 개발에서 MVVM 아키텍처와 RxSwift를 활용한 반응형 프로그래밍을 
실제 프로젝트에 적용해볼 수 있었습니다. 또한 팀 프로젝트에서 iOS 파트 리더로서 
코드 리뷰와 기술 스택 결정을 주도하며 협업 능력을 향상시켰습니다.
''',
          description: '''
식목일은 식단, 목표, 일일 운동량을 한 번에 관리할 수 있는 헬스케어 앱입니다.
사용자 친화적인 UI와 다양한 기능을 통해 효율적인 건강 관리를 지원합니다.
''',
          technologies: [
            'Swift',
            'UIKit',
            'Alamofire',
            'Snapkit',
            'Then',
            'MVVM',
            'RxSwift',
            'Combine',
            'OAuth 2.0',
            'RestPullAPI'
          ],
          challenges: [
            'RxSwift를 활용한 복잡한 상태 관리 구현',
            '커스텀 캘린더 UI 구현 시 성능 최적화',
            '다양한 API 연동 및 데이터 동기화',
          ],
          improvements: [
            '데이터 캐싱 및 오프라인 모드 지원',
            '소셜 기능 강화',
            '운동 통계 분석 기능 추가',
          ],
          period: '2024.06 - 2024.07',
          teamSize: 'iOS 4인, Back-end 2인 팀프로젝트',
          githubUrl: 'https://github.com/devpark435/Sikmogil'),
      Project(
          id: '2',
          title: 'Copro',
          summary: '개발자들을 위한 프로젝트 버그 리포트 및 협업 플랫폼',
          keyFeatures: ['실시간 버그 리포트 시스템', '개발자 매칭 기능', '실시간 채팅', '프로젝트 관리 도구'],
          background: '''
프로젝트 진행 중 발생하는 버그를 효율적으로 관리하고, 개발자들 간의 
협업을 촉진할 수 있는 플랫폼의 필요성을 느껴 개발을 시작했습니다.
''',
          meaning: '''
Firebase를 활용한 실시간 데이터베이스 구현과 채팅 시스템 개발을 통해 
실시간 애플리케이션 개발 경험을 쌓았습니다. 또한 OAuth 인증과 
RESTful API 통신에 대한 실무 경험을 쌓을 수 있었습니다.
''',
          description: '개발자들이 프로젝트의 버그를 효율적으로 관리하고 협업할 수 있는 플랫폼입니다.',
          technologies: [
            'Swift',
            'UIKit',
            'Alamofire',
            'Snapkit',
            'Then',
            'Firebase Cloud Message',
            'OAuth 2.0',
            'RestPullAPI'
          ],
          challenges: [
            '실시간 데이터 동기화 구현',
            '복잡한 매칭 알고리즘 개발',
            'Firebase 성능 최적화',
          ],
          improvements: [
            '프로젝트 분석 대시보드 추가',
            '코드 리뷰 기능 통합',
            '알림 시스템 개선',
          ],
          period: '2023/10/22',
          teamSize: 'iOS 3인, Back-end 2인 팀프로젝트',
          githubUrl: 'https://github.com/Nangman-Archive/CoPro_iOS'),
      Project(
          id: '3',
          title: 'Twelve Cinema',
          summary: 'TheMovie DB API를 활용한 영화 정보 및 예매 시스템',
          keyFeatures: ['영화 정보 검색 및 조회', '예매 시스템', '사용자 리뷰 기능', '개인화된 추천 시스템'],
          background: '''
영화 정보를 쉽게 찾아보고 예매할 수 있는 통합 플랫폼을 만들고자 했습니다.
TheMovie DB API를 활용하여 풍부한 영화 정보를 제공하고, 
사용자 친화적인 예매 시스템을 구현하고자 했습니다.
''',
          meaning: '''
외부 API 연동과 데이터 처리, UI 구현 등 iOS 앱 개발의 
기본적인 요소들을 실습해볼 수 있었습니다. 특히 StoryBoard를 
활용한 UI 개발과 MVC 패턴 적용을 경험했습니다.
''',
          description: 'TheMovie DB API를 활용하여 영화 정보를 제공하고 예매할 수 있는 앱입니다.',
          technologies: ['UIKit', 'StoryBoard', 'RestPullAPI'],
          challenges: [
            'API 데이터 모델링 및 처리',
            '예매 시스템 로직 구현',
            '사용자 리뷰 시스템 설계',
          ],
          improvements: [
            '결제 시스템 연동',
            '추천 알고리즘 고도화',
            '성능 최적화',
          ],
          period: '2024/04/22 ~ 2024/04/28',
          teamSize: 'iOS 4인 팀프로젝트',
          githubUrl: 'https://github.com/NBCampArchive/CinemaApp'),
      Project(
        id: '4',
        title: 'ZIKIZA',
        summary: 'UN 지속가능한 개발 목표(SDGs)를 위한 환경 캠페인 플랫폼',
        keyFeatures: [
          '위치 기반 환경 캠페인 참여',
          '실시간 환경 데이터 시각화',
          '인앱 결제를 통한 캠페인 후원',
          'SNS 연동 및 공유 기능',
        ],
        background: '''
Google Solution Challenge에서 UN SDGs 중 '기후변화 대응'을 주제로 선정하여,
일반 시민들이 쉽게 환경 보호 활동에 참여할 수 있는 플랫폼의 필요성을 인식하고 개발을 시작했습니다.
''',
        meaning: '''
본 프로젝트를 통해 Flutter를 활용한 크로스 플랫폼 개발 경험을 쌓았으며,
특히 Google Maps API와 실시간 데이터 처리에 대한 기술적 역량을 향상시켰습니다.
또한 팀 프로젝트에서 Flutter 개발 파트 리더로서 코드 리뷰와 아키텍처 설계를 주도했습니다.
''',
        description: '''
ZIKIZA는 환경 보호 활동을 게이미피케이션화하여 사용자들의 참여를 유도하는 플랫폼입니다.
위치 기반 서비스를 통해 주변의 환경 캠페인을 확인하고 참여할 수 있으며,
실시간으로 환경 데이터를 시각화하여 제공합니다.
''',
        technologies: [
          'Flutter',
          'Dart',
          'Bloc',
          'Cubit',
          'RestPullAPI',
          'GoogleMapAPI'
        ],
        challenges: [
          '실시간 위치 기반 서비스 구현 시 성능 최적화 문제 해결',
          '다양한 환경 데이터 시각화를 위한 커스텀 위젯 개발',
          '크로스 플랫폼에서의 일관된 사용자 경험 제공',
        ],
        improvements: [
          '오프라인 캐싱 기능 추가 필요',
          '환경 데이터 분석 기능 강화',
          '커뮤니티 기능 확장',
        ],
        period: '2023/02/15 ~ 2023/04/01',
        teamSize: 'Flutter 2인, Back-end 1인 팀프로젝트',
        githubUrl:
            'https://github.com/GDG-on-Campus-SKHU/98developers-flutter-app',
      ),
      Project(
          id: '5',
          title: 'Catch Country',
          summary: '국가별 퀴즈를 통한 문화 인식 향상 교육 플랫폼',
          keyFeatures: [
            '국가별 퀴즈 시스템',
            '실시간 점수 시스템',
            '교육적 콘텐츠 제공',
            '인터랙티브 UI/UX'
          ],
          background: '''
GDSC 연합 해커톤에서 세계 문화에 대한 이해를 높이기 위한 
교육용 게임 플랫폼을 기획하게 되었습니다.
''',
          meaning: '''
Flutter를 활용한 크로스 플랫폼 개발과 실시간 점수 시스템 구현을 통해 
게임 개발 경험을 쌓았습니다. 해커톤에서 2등 수상을 통해 프로젝트의 
가치를 인정받았습니다.
''',
          description: '퀴즈를 통해 다양한 국가의 문화를 재미있게 배울 수 있는 교육용 게임입니다.',
          technologies: ['Flutter', 'Dart', 'RestPullAPI'],
          challenges: [
            '퀴즈 시스템 설계',
            '실시간 점수 처리',
            '교육적 요소와 게임적 요소의 균형',
          ],
          improvements: [
            '다국어 지원',
            '콘텐츠 다양화',
            '멀티플레이어 모드',
          ],
          period: '2023/05/29 ~ 2023/05/30',
          teamSize: 'Flutter 1인, Back-end 2인 팀프로젝트',
          githubUrl: 'https://github.com/devpark435/catchCountry_flutter_app'),
      Project(
          id: '6',
          title: 'PetMily',
          summary: '반려동물 보호자를 위한 종합 커뮤니티 플랫폼',
          keyFeatures: ['반려동물 프로필 관리', '커뮤니티 기능', '정보 공유 시스템', '반려동물 케어 가이드'],
          background: '''
증가하는 반려동물 가구 수에 맞춰, 반려동물 보호자들이 정보를 공유하고 
소통할 수 있는 커뮤니티 플랫폼의 필요성을 느껴 개발을 시작했습니다.
''',
          meaning: '''
Flutter를 활용한 첫 커뮤니티 플랫폼 개발 경험이었으며, 
사용자 인터랙션이 많은 앱 개발을 통해 상태 관리와 
데이터 핸들링 능력을 향상시켰습니다.
''',
          description: '반려동물 보호자들을 위한 종합 커뮤니티 플랫폼입니다.',
          technologies: ['Flutter', 'Dart', 'RestPullAPI'],
          challenges: [
            '복잡한 커뮤니티 기능 구현',
            '데이터 구조 설계',
            '사용자 경험 최적화',
          ],
          improvements: [
            '전문가 상담 기능',
            '병원/용품 정보 연동',
            '반려동물 건강 관리 기능',
          ],
          period: '2023/04/15 ~ 2023/06/15',
          teamSize: 'Flutter 3인, Back-end 2인 팀프로젝트',
          githubUrl: 'https://github.com/Pluteers/petmily-flutter-app'),
    ];
  }
}
