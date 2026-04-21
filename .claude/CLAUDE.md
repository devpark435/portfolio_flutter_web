# Portfolio Flutter Web — CLAUDE.md

## 프로젝트 개요
Flutter Web으로 제작한 개발자 포트폴리오 사이트. 단일 페이지(섹션 스크롤) + 프로젝트 상세 페이지로 구성.

## 기술 스택
- **Flutter Web** / Dart (SDK ≥3.1.5)
- **상태관리**: flutter_riverpod (StateNotifierProvider, FutureProvider)
- **라우팅**: go_router (`/`, `/projects/:id`)
- **폰트**: PretendardVariable (로컬), google_fonts
- **애니메이션**: flutter_animate, simple_animations, animated_text_kit
- **기타**: url_launcher, font_awesome_flutter, timeline_tile, shared_preferences

## 디렉토리 구조
```
lib/
├── config/
│   ├── providers/providers.dart   # 전역 Provider (theme, scroll, cursor, projects)
│   ├── router/router.dart         # GoRouter 설정
│   └── theme/app_theme.dart       # 라이트/다크 테마
├── data/                          # 정적 데이터 (skills, awards, experiences, profile_info)
├── domain/
│   ├── models/                    # Project, Skill, Experience, Award, ProfileInfo, Troubleshooting
│   ├── repositories/              # ProjectRepository
│   └── services/markdown_service.dart
└── presentation/
    ├── screens/
    │   ├── home/sections/         # hero, profile, skills, project, experience, award, contact
    │   └── project_detail/
    └── widgets/                   # skill_card, project_card, custom_cursor, theme_toggle_button
```

## 주요 Provider
| Provider | 역할 |
|---|---|
| `themeModeProvider` | 다크/라이트 토글 (기본: dark) |
| `scrollProvider` | 스크롤 진행률 (0.0~1.0) |
| `cursorProvider` | 커스텀 커서 위치·hover 상태 |
| `projectsProvider` | 프로젝트 목록 (FutureProvider) |

## 개발 명령어
```bash
flutter run -d chrome          # 개발 서버
flutter build web              # 프로덕션 빌드
flutter analyze                # 정적 분석
```

## 작업 시 주의사항
- 콘텐츠 데이터는 `lib/data/` 파일에서 직접 수정
- 섹션 추가 시 `home_screen.dart`의 섹션 목록과 함께 업데이트
- 반응형: 모바일/태블릿/데스크톱 breakpoint를 기존 섹션 패턴에 맞춰 적용
- assets 추가 시 `pubspec.yaml`의 assets 목록에 등록 필요
