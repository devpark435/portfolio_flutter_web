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
          description:
              '식목일은 (식)단, (목)표, (일)일 운동량 의 줄임말로 운동과 식단에 관심이 많은 현대인들을 위해 간편한 기능을 담은 어플입니다.',
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
          period: '2024.06 - 2024.07',
          teamSize: 'iOS 4인, Back-end 2인 팀프로젝트',
          metrics: [
            '앱스토어 라이프 사이클 차트인(최고 50위)',
            'Google, Apple 소셜 로그인 구현',
            '커스텀 캘린더, 일기 작성 페이지 제작',
            'API 요청 코드 제작, 관리',
            'Custom UI 제작',
            'UserNotifications, FCM 을 활용한 푸쉬 알림 제작',
            '목표 관리 페이지 제작',
            '회원 정보 페이지 제작',
          ],
          githubUrl: 'https://github.com/devpark435/Sikmogil'),
      Project(
        id: '2',
        title: 'Copro',
        description: '프로젝트 앱버그 구인 서비스 어플리케이션',
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
        period: '2023/10/22',
        teamSize: 'iOS 3인, Back-end 2인 팀프로젝트',
        metrics: [
          'Firebase를 활용한 실시간 데이터베이스 구현',
          'RestPullAPI를 활용한 서버 통신',
          '유저 간 실시간 채팅 기능 구현',
          '프로젝트 매칭 시스템 개발',
        ],
        githubUrl: 'https://github.com/Nangman-Archive/CoPro_iOS',
      ),
      Project(
        id: '3',
        title: 'Twelve Cinema',
        description: 'TheMovie DB API를 활용한 영화 정보를 보여주는 영화 예매 어플리케이션',
        technologies: ['UIKit', 'StoryBoard', 'RestPullAPI'],
        period: '2024/04/22 ~ 2024/04/28',
        teamSize: 'iOS 4인 팀프로젝트',
        metrics: [
          'TheMovie DB API 연동 및 데이터 처리',
          '영화 예매 시스템 구현',
          '영화 정보 상세 페이지 개발',
          '사용자 리뷰 시스템 구현',
        ],
        githubUrl: 'https://github.com/devpark435/CinemaApp',
      ),
      Project(
        id: '4',
        title: 'ZIKIZA',
        description: 'Google Solution Challenge 출품작 UN 지속가능한 목표를 주제로한 프로젝트',
        technologies: [
          'Flutter',
          'Dart',
          'Bloc',
          'Cubit',
          'RestPullAPI',
          'GoogleMapAPI'
        ],
        period: '2023/02/15 ~ 2023/04/01',
        teamSize: 'Flutter 2인, Back-end 1인 팀프로젝트',
        metrics: [
          'Google Maps API를 활용한 위치 기반 서비스',
          'UN SDGs 목표 달성을 위한 솔루션 개발',
          'SNS 연동 로그인 구현',
          '인앱 결제 시스템 구현',
          '환경 캠패인 크롤링 구현',
          '실시간 데이터 시각화 구현',
          'Flutter를 활용한 크로스 플랫폼 개발',
        ],
        githubUrl:
            'https://github.com/GDG-on-Campus-SKHU/98developers-flutter-app',
      ),
      Project(
        id: '5',
        title: 'Catch Country',
        description: 'Enhance cultural awareness through quizzes',
        technologies: ['Flutter', 'Dart', 'RestPullAPI'],
        period: '2023/05/29 ~ 2023/05/30',
        teamSize: 'Flutter 1인, Back-end 2인 팀프로젝트',
        metrics: [
          'GDSC 연합 해커톤 2등 수상',
          '국가별 퀴즈 시스템 구현',
          '문화 인식 향상을 위한 교육적 콘텐츠',
          '인터랙티브 UI/UX 디자인',
          '실시간 점수 시스템',
        ],
        githubUrl: 'https://github.com/devpark435/catchCountry_flutter_app',
      ),
      Project(
        id: '6',
        title: 'PetMily',
        description: '반려동물을 관심 급증에 따른 반려동물을 키우는 정신사람들을 위한 커뮤니티 플랫폼',
        technologies: ['Flutter', 'Dart', 'RestPullAPI'],
        period: '2023/04/15 ~ 2023/06/15',
        teamSize: 'Flutter 3인, Back-end 2인 팀프로젝트',
        metrics: [
          '반려동물 커뮤니티 기능 구현',
          'Flutter를 활용한 UI 디자인',
          '사용자 간 정보 공유 시스템',
          '반려동물 관리 기능 개발',
        ],
        githubUrl: 'https://github.com/Pluteers/petmily-flutter-app',
      ),
    ];
  }
}
