import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio_web/domain/models/project.dart';
import 'package:portfolio_web/domain/repositories/project_repository.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

// 0.0 ~ 1.0 progress (progress bar용)
final scrollProvider = StateNotifierProvider<ScrollNotifier, double>((ref) {
  return ScrollNotifier();
});

class ScrollNotifier extends StateNotifier<double> {
  ScrollNotifier() : super(0.0);

  void updateScroll(double value) {
    state = value.clamp(0.0, 1.0);
  }
}

// 스크롤 픽셀 절대값 (섹션 가시성 감지용)
final scrollPixelsProvider = StateProvider<double>((ref) => 0.0);

// 현재 활성 섹션
final activeSectionProvider = StateProvider<String>((ref) => '');

final projectsProvider = FutureProvider<List<Project>>((ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  return repository.getProjects();
});

final cursorProvider =
    StateNotifierProvider<CursorNotifier, CursorState>((ref) {
  return CursorNotifier();
});

class CursorState {
  final Offset position;
  final bool isHovering;
  final String? hoverLabel;

  const CursorState({
    this.position = Offset.zero,
    this.isHovering = false,
    this.hoverLabel,
  });
}

class CursorNotifier extends StateNotifier<CursorState> {
  CursorNotifier() : super(const CursorState());

  void updatePosition(Offset newPosition) {
    state = CursorState(
      position: newPosition,
      isHovering: state.isHovering,
      hoverLabel: state.hoverLabel,
    );
  }

  void setHovering(bool isHovering) {
    state = CursorState(
      position: state.position,
      isHovering: isHovering,
      hoverLabel: isHovering ? state.hoverLabel : null,
    );
  }

  void setHoverLabel(String? label) {
    state = CursorState(
      position: state.position,
      isHovering: label != null,
      hoverLabel: label,
    );
  }
}
