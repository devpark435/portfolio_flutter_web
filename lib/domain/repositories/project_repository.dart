import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';
import '../models/troubleshooting.dart';

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
        responsibilities: [
          'iOS 개발 팀 리더로서 프로젝트 관리 및 코드 리뷰 진행',
          'MVVM 아키텍처 설계 및 RxSwift, Combine을 활용한 반응형 프로그래밍 구현',
          '식단 관리 및 운동 기록 커스텀 그래프 제작',
          'API 인증 및 OAuth 2.0 로그인 시스템 구현',
          '커스텀 캘린더 UI 컴포넌트 개발 및 성능 최적화'
        ],
        troubleshooting: [
          Troubleshooting(
              issue: 'RxSwift Observable 메모리 누수',
              context:
                  '여러 화면을 오가며 Observable 구독 시 메모리 누수가 발생하여 앱 성능이 저하되는 문제 발생',
              solution:
                  'DisposeBag을 활용한 구독 생명주기 관리와 weak self 패턴을 적용하여 순환 참조 방지. ViewModel의 구독 관리 로직을 개선하여 화면 전환 시 자동 해제되도록 구현',
              learning: '반응형 프로그래밍에서 메모리 관리의 중요성과 구독 생명주기 관리 방법에 대한 이해도 향상'),
          Troubleshooting(
              issue: '커스텀 캘린더 스크롤 성능 저하',
              context: '일정이 많은 월별 캘린더 뷰에서 스크롤 시 프레임 드랍이 발생하고 UI가 버벅이는 현상 발생',
              solution:
                  '셀 재사용 메커니즘 최적화 및 일정 데이터 lazy loading 구현. 불필요한 레이아웃 계산을 줄이고 렌더링 로직을 메인 스레드와 백그라운드 스레드로 적절히 분리',
              learning: 'UICollectionView 성능 최적화 기법과 효율적인 리소스 관리의 중요성 습득'),
          Troubleshooting(
              issue: 'AccessToken 재발행 무한 호출 오류',
              context: '앱 사용중 토큰 기한 만료로 인한 토큰 재발행 API가 화면 이동 중 무한으로 호출되는 상황 발생',
              solution:
                  'Alamofire의 Interceptor 기능을 활용하여 API 호출 흐름을 중앙 관리. 토큰 만료 시 단일 재발행 로직으로 통합하고 재발행 중 추가 요청을 큐에 저장하여 처리함으로써 중복 호출 문제 해결. 토큰 상태에 따른 요청 처리 흐름을 체계화하여 안정성 확보.',
              learning:
                  'API 인증 흐름의 중앙화된 관리 방법과 비동기 요청의 적절한 제어 전략에 대한 이해를 높임. 특히 인증 토큰의 라이프사이클 관리와 실패한 요청의 복구 메커니즘 설계 능력을 향상시킴.')
        ],
        improvements: [
          '데이터 캐싱 및 오프라인 모드 지원',
          '소셜 기능 강화',
          '운동 통계 분석 기능 추가',
        ],
        period: '2024.06.01 ~ 2024.07.03',
        teamSize: 'iOS 4인, Back-end 2인',
        githubUrl: 'https://github.com/devpark435/Sikmogil',
        imageUrl: 'images/sikmogil.png',
      ),
      Project(
          id: '2',
          title: 'Copro',
          summary: '사이드 프로젝트 팀원 매칭 및 개발자 네트워킹 플랫폼',
          keyFeatures: [
            '카드 스와이프 방식의 개발자 매칭 시스템',
            'GitHub 프로필 연동 및 코드 확인 기능',
            '프로젝트 모집 게시판',
            '실시간 개발자 간 채팅 시스템'
          ],
          background: '''
사이드 프로젝트를 진행하려 할 때 적합한 팀원을 찾기 어려운 문제점에 착안했습니다.
소개팅 앱의 UX에서 영감을 받아, 개발자들이 서로의 기술 스택과 포트폴리오를 
직관적으로 확인하고 관심사가 맞는 팀원을 쉽게 찾을 수 있는 플랫폼을 구상했습니다.
''',
          meaning: '''
Firebase를 활용한 실시간 채팅 시스템과 데이터베이스 구현을 통해 
실시간 애플리케이션 개발 경험을 쌓았습니다. 또한 GitHub API 연동과
카드 스와이프 인터페이스 구현을 통해 복잡한 사용자 경험을 구현하는 
역량을 키울 수 있었습니다.
''',
          description: '개발자들이 사이드 프로젝트 팀원을 효과적으로 찾고 소통할 수 있는 매칭 플랫폼입니다.',
          technologies: [
            'Swift',
            'UIKit',
            'Alamofire',
            'Snapkit',
            'Then',
            'Firebase Realtime Database',
            'GitHub API',
            'FCM(Firebase Cloud Messaging)',
            'OAuth 2.0'
          ],
          challenges: [
            '카드 스와이프 인터페이스 구현 및 애니메이션 최적화',
            'GitHub API 연동 및 프로필 데이터 처리',
            '실시간 채팅 시스템 구현',
            '사용자 매칭 알고리즘 개발'
          ],
          responsibilities: [
            '카드 스와이프 인터페이스 설계 및 개발',
            'GitHub API 연동 및 개발자 프로필 조회 기능 구현',
            'Firebase 기반 실시간 채팅 시스템 개발',
            '게시글 작성 등 게시판 형태 커뮤니티 개발',
            'OAuth 2.0 로그인 시스템 구현',
            '사용자 인증 및 프로필 관리 기능 개발'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: '카드 스와이프 애니메이션 성능 이슈',
                context: '다수의 개발자 카드를 로드하고 스와이프할 때 메모리 사용량 증가와 UI 랙 현상 발생',
                solution:
                    '이미지 캐싱 시스템 구현 및 카드 재사용 메커니즘 도입. 비동기 로딩 방식으로 변경하고 카드 애니메이션 로직 최적화를 통해 부드러운 UX 구현',
                learning:
                    '대량의 이미지와 데이터를 다루는 리스트 인터페이스에서의 메모리 관리와 렌더링 최적화 기법 습득'),
            Troubleshooting(
                issue: '실시간 채팅 메시지 동기화 오류',
                context:
                    '네트워크 상태 변화 시 메시지 전송 실패와 순서 꼬임 현상 발생, 특히 불안정한 연결에서 메시지 유실 문제 심각',
                solution:
                    'Firebase 오프라인 지원 기능 활성화 및 메시지 큐잉 시스템 구현. 메시지 상태 추적 메커니즘과 재전송 로직으로 안정성 향상',
                learning: '실시간 메시징 시스템의 신뢰성 있는 구현 방법과 불안정한 네트워크 환경 대응 전략 습득')
          ],
          improvements: [
            '개발자 추천 알고리즘 고도화',
            '프로젝트 진행 관리 대시보드 추가',
            '멘토-멘티 매칭 시스템 도입',
            '기술 트렌드 기반 매칭 기능 개발'
          ],
          period: '2023.10.22 ~ 2024.02.10',
          teamSize: 'iOS 3인, Back-end 2인',
          githubUrl: 'https://github.com/Nangman-Archive/CoPro_iOS',
          imageUrl: 'images/copro.png'),
      Project(
          id: '3',
          title: '오늘의 날씨',
          summary: 'openweathermap API를 활용하여 날씨 예보 및 미세먼지 측정 어플리케이션',
          keyFeatures: [
            '미세먼지 농도를 시각적 효과로 표현하는 에니메이션',
            '날씨 전환 시 화면 전체가 변화하는 배경 애니메이션',
            '날씨에 어울리는 옷차림과 음식을 추천',
            '화면 전환간 자연스러운 UI 배치 에니메이션'
          ],
          background: '''
부트캠프 팀 프로젝트로 진행하면서, 대부분의 날씨 앱이 단조롭고 딱딱한 UI를 가지고 있다는 
점에 주목했습니다. 날씨 정보는 매일 확인하는 정보임에도 불구하고 시각적 즐거움이 
부족하다고 느꼈습니다. 이에 애니메이션과 시각적 요소를 풍부하게 활용한 귀여운 
날씨 앱을 만들어 사용자 경험을 향상시키고자 했습니다.
''',
          meaning: '''
이 프로젝트를 통해 OpenWeatherMap API를 활용한 외부 데이터 처리와 
복잡한 애니메이션 구현 능력을 향상시킬 수 있었습니다. 특히 날씨 상태에 따라 
동적으로 변화하는 UI/UX를 구현하면서 Swift 애니메이션 시스템에 대한 깊은 
이해를 얻었습니다. 또한 날씨, 미세먼지 등 다양한 환경 데이터를 시각적으로 
효과적으로 표현하는 디자인 능력을 키울 수 있었습니다.
''',
          description: '''기존에 칙칙한 날씨 앱을 떠나 에니메이션에 중점을 둔 날씨 앱 입니다.''',
          technologies: [
            'Swift',
            'UIKit',
            'Alamofire',
            'Snapkit',
            'Then',
          ],
          challenges: [
            '날씨에 따른 배경 및 UI 변경',
            '미세 먼지 농도에 따른 에니메이션 조정',
            '지역 변경에 따른 동기화 작업'
          ],
          responsibilities: [
            'UI/UX 디자인 및 애니메이션 시스템 개발',
            'OpenWeatherMap API 연동 및 데이터 처리',
            '날씨 상태별 애니메이션 효과 구현',
            '미세먼지 데이터 시각화 컴포넌트 개발'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: '날씨 상태에 따른 동적 UI 렌더링 문제',
                context: '날씨 변화에 따라 배경 이미지와 UI 요소들이 자연스럽게 전환되지 않고 깜빡임 현상 발생',
                solution:
                    'UIView 애니메이션 처리 최적화 및 이미지 프리로딩 기법 적용. 전환 효과용 커스텀 트랜지션 클래스 구현으로 자연스러운 UI 변화 구현',
                learning: 'iOS에서 동적 테마 전환과 부드러운 UI 애니메이션 구현 기법 습득'),
            Troubleshooting(
                issue: '미세먼지 데이터 시각화 성능 저하',
                context:
                    '실시간 미세먼지 데이터를 그래프로 표현할 때 CPU 사용량이 급증하고 애니메이션이 버벅이는 현상 발생',
                solution:
                    '그래픽 렌더링 로직 최적화 및 Core Animation 레이어 캐싱 적용. 복잡한 그래프 컴포넌트 재설계로 렌더링 효율성 향상',
                learning: 'iOS의 그래픽 렌더링 파이프라인과 효율적인 애니메이션 처리 방법에 대한 이해 심화'),
            Troubleshooting(
                issue: '위치 변경 시 날씨 데이터 동기화 지연',
                context: '사용자가 지역을 변경할 때 날씨 정보와 UI가 즉시 업데이트되지 않아 일관성 문제 발생',
                solution:
                    '위치 업데이트 이벤트 핸들링 개선 및 API 요청 최적화. 로컬 캐싱 전략 도입으로 이전 검색 지역 데이터 빠르게 복원',
                learning: '사용자 입력에 즉각적으로 반응하는 반응형 앱 설계 방법과 데이터 동기화 전략 습득')
          ],
          improvements: ['improvements'],
          period: '2024.05.14 ~ 2024.05.25',
          teamSize: 'iOS 3인',
          githubUrl: 'https://github.com/NBCampArchive/Today-s_weather',
          imageUrl: 'images/weather.png'),
      Project(
          id: '4',
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
          responsibilities: [
            'TheMovie DB API 연동 및 데이터 모델링',
            '예매 시스템 플로우 설계 및 구현',
            'StoryBoard 기반 화면 전환 및 네비게이션 구현',
            'MapKit을 활용한 주변 영화관 검색 기능 구현',
            '주변 영화관까지 대중교통 차량 도보 경로 및 시간 구현'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: 'API 응답 데이터 파싱 오류',
                context:
                    'TheMovie DB API에서 받아온 복잡한 JSON 구조를 처리하는 과정에서 특정 영화 정보가 누락되거나 잘못 표시되는 문제 발생',
                solution:
                    '견고한 데이터 모델 설계 및 옵셔널 체이닝을 활용한 안전한 파싱 로직 구현. 예외 케이스에 대한 처리 강화 및 데이터 검증 단계 추가',
                learning:
                    '외부 API 응답 처리 시 안정성과 오류 내성을 고려한 모델링 방법과 JSON 파싱 기법 습득'),
            Troubleshooting(
                issue: '예매 시스템 동시성 문제',
                context: '다수 사용자가 동시에 같은 좌석을 예매하려 할 때 중복 예매 현상 발생',
                solution:
                    '좌석 예약 상태 실시간 업데이트 메커니즘 구현 및 서버 통신 최적화. 낙관적 잠금과 충돌 해결 로직 적용으로 사용자 경험 개선',
                learning: '동시성 제어와 분산 시스템에서의 데이터 일관성 유지 방법에 대한 이해 향상'),
            Troubleshooting(
                issue: '스토리보드 기반 UI 확장성 한계',
                context: '앱 규모가 커지면서 스토리보드 기반 UI 관리의 어려움과 Git 충돌 문제 발생',
                solution:
                    '스토리보드를 기능별로 분리하고 XIB 파일 활용. 코드 기반 UI 컴포넌트 도입으로 재사용성 향상 및 모듈화 설계 적용',
                learning:
                    '대규모 iOS 프로젝트에서의 효율적인 UI 관리 전략과 팀 협업을 위한 코드 구조화 방법 습득')
          ],
          improvements: [
            '결제 시스템 연동',
            '추천 알고리즘 고도화',
            '성능 최적화',
          ],
          period: '2024.04.22 ~ 2024.04.28',
          teamSize: 'iOS 4인',
          githubUrl: 'https://github.com/NBCampArchive/CinemaApp',
          imageUrl: 'images/twelvecinema.png'),
      Project(
          id: '5',
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
ZIKIZA는 미라클 챌린지와 같은 서비스에 영향을 받아 환경 보호 활동을 챌린지화 하여 사용자들의 참여를 유도하는 플랫폼입니다.
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
          responsibilities: [
            'Flutter 개발 팀 리더로서 아키텍처 설계 및 코드 리뷰',
            'Bloc 패턴을 활용한 상태 관리 시스템 구현',
            '챌린지 조회 및 신청 시스템 구현',
            '카메라를 통한 미션 인증 기능 구현',
            'BootPay 결제 시스템 연동 및 구현'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: 'Google Maps 렌더링 성능 저하',
                context:
                    '다수의 캠페인 마커와 환경 데이터 레이어가 로드될 때 지도 렌더링 속도 저하 및 프레임 드랍 발생',
                solution:
                    '마커 클러스터링 기법 도입 및 뷰포트 기반 데이터 로딩 구현. 지도 타일 캐싱 및 애셋 최적화로 초기 로딩 속도 향상',
                learning: '모바일 환경에서 지도 기반 애플리케이션의 성능 최적화 전략과 사용자 경험 향상 기법 습득'),
            Troubleshooting(
                issue: 'Flutter 인앱결제 구현을 위한 개발자 계정 제약 문제',
                context:
                    'Flutter 앱에 결제 기능을 도입하려 했으나, 공식 인앱결제 구현에 필요한 개발자 계정 제약과 복잡한 승인 과정으로 개발 일정 지연 위기 발생',
                solution:
                    'PG사 대행 결제 서비스인 BootPay를 도입하여 개발자 계정 없이도 안정적인 결제 시스템 구현. 결제 프로세스를 간소화하고 다양한 결제 수단을 지원하는 통합 솔루션 적용',
                learning:
                    '모바일 앱의 결제 시스템 설계 시 플랫폼별 정책 제약을 고려한 대체 솔루션 도입 전략과 제3자 결제 서비스 연동 아키텍처 구현 방법 습득'),
            Troubleshooting(
                issue: 'Bloc 패턴 사용 시 상태 관리 복잡성',
                context:
                    '앱 규모 확장에 따라 상태 관리 로직이 복잡해지면서 예상치 못한 UI 업데이트 문제 및 디버깅 어려움 발생',
                solution:
                    'Bloc 아키텍처 재설계 및 상태 관리 단순화. 명확한 이벤트-상태 모델링과 단방향 데이터 흐름 적용으로 예측 가능한 상태 변화 구현',
                learning:
                    '대규모 Flutter 애플리케이션에서의 효과적인 상태 관리 전략과 Bloc 패턴의 실전적 활용 방법 습득')
          ],
          improvements: [
            '오프라인 캐싱 기능 추가 필요',
            '환경 데이터 분석 기능 강화',
            '커뮤니티 기능 확장',
          ],
          period: '2023.02.15 ~ 2023.04.01',
          teamSize: 'Flutter 2인, Back-end 1인',
          githubUrl:
              'https://github.com/GDG-on-Campus-SKHU/98developers-flutter-app',
          imageUrl: 'images/zikiza.png',
          demoUrl: 'https://www.youtube.com/watch?v=yYz4czlmn0Q'),
      Project(
          id: '6',
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
          responsibilities: [
            '전체 앱 개발 및 24시간 내 프로토타입 구현 주도',
            '퀴즈 시스템 설계 및 게임 로직 개발',
            'Lottie를 활용한 에니메이션 퀴즈 개발',
            '실시간 점수 계산 및 랭킹 시스템 개발',
            '인터랙티브 UI/UX 디자인 및 구현'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: '퀴즈 데이터 로딩 속도 저하',
                context: '다양한 국가 정보와 이미지 자료를 포함한 퀴즈 데이터 로딩 시 지연 현상 발생',
                solution:
                    '퀴즈 데이터 프리로딩 및 점진적 로딩 전략 구현. 이미지 최적화 및 압축 기법 적용으로 초기 로딩 시간 단축',
                learning: '모바일 게임에서 콘텐츠 로딩 최적화와 사용자 대기 시간 최소화 전략 습득'),
            Troubleshooting(
                issue: '실시간 점수 동기화 오류',
                context: '다수 플레이어 참여 시 점수 업데이트 지연 및 불일치 문제 발생',
                solution:
                    '효율적인 상태 관리 패턴 도입 및 실시간 데이터 동기화 메커니즘 개선. 낙관적 UI 업데이트와 백그라운드 동기화 전략 적용',
                learning: '실시간 점수 시스템 구현 시 데이터 일관성과 사용자 경험 균형에 대한 이해 심화'),
          ],
          improvements: [
            '다국어 지원',
            '콘텐츠 다양화',
            '멀티플레이어 모드',
          ],
          period: '2023.05.29 ~ 2023.05.30',
          teamSize: 'Flutter 1인, Back-end 2인',
          githubUrl: 'https://github.com/devpark435/catchCountry_flutter_app'),
      Project(
          id: '7',
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
          responsibilities: [
            '반려동물 프로필 관리 및 사진 갤러리 기능 개발',
            '커뮤니티 게시판 및 댓글 시스템 구현',
            '이미지 업로드 및 처리 시스템 개발',
            '콘텐츠 필터링 및 신고 기능 구현',
            '반응형 UI 설계 및 다양한 디바이스 지원'
          ],
          troubleshooting: [
            Troubleshooting(
                issue: '이미지 업로드 및 캐싱 성능 문제',
                context:
                    '반려동물 사진 갤러리 기능에서 대용량 이미지 업로드 및 표시 시 메모리 사용량 급증과 UI 응답성 저하 발생',
                solution:
                    '이미지 업로드 전 최적화 로직 구현 및 효율적인 캐싱 전략 적용. 전용 이미지 로더 개발로 메모리 사용량 관리 및 점진적 로딩 구현',
                learning: '모바일 환경에서 효율적인 이미지 처리와 메모리 관리 기법 습득'),
            Troubleshooting(
                issue: '커뮤니티 콘텐츠 필터링 및 적절성 검증',
                context: '사용자 생성 콘텐츠 증가에 따른 부적절한 콘텐츠 관리와 검색 기능 최적화 문제 발생',
                solution:
                    '텍스트 필터링 알고리즘 구현 및 사용자 신고 시스템 개발. 효율적인 콘텐츠 인덱싱과 검색 최적화로 관련 정보 접근성 향상',
                learning: '사용자 생성 콘텐츠 플랫폼에서의 콘텐츠 관리 전략과 검색 기능 설계 방법론 이해'),
            Troubleshooting(
                issue: '다양한 기기에서의 UI 일관성 유지',
                context: '다양한 화면 크기와 비율을 가진 기기에서 복잡한 커뮤니티 UI 레이아웃이 깨지는 문제 발생',
                solution:
                    '반응형 UI 아키텍처 구현 및 DevicePreview 도구 활용한 크로스 디바이스 테스팅. 화면 크기별 레이아웃 최적화 및 UI 컴포넌트 모듈화',
                learning:
                    'Flutter에서 다양한 디바이스를 지원하는 확장성 있는 UI 설계 방법과 적응형 레이아웃 구현 기법 습득')
          ],
          improvements: [
            '전문가 상담 기능',
            '병원/용품 정보 연동',
            '반려동물 건강 관리 기능',
          ],
          period: '2023.04.15 ~ 2023.06.15',
          teamSize: 'Flutter 3인, Back-end 2인',
          githubUrl: 'https://github.com/Pluteers/petmily-flutter-app'),
    ];
  }
}
