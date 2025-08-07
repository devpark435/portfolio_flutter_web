// lib/config/providers/providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio_web/domain/models/project.dart';
import 'package:portfolio_web/domain/repositories/project_repository.dart';

// SharedPreferences Provider
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Theme Provider
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

// Scroll Provider
final scrollProvider = StateNotifierProvider<ScrollNotifier, double>((ref) {
  return ScrollNotifier();
});

class ScrollNotifier extends StateNotifier<double> {
  ScrollNotifier() : super(0.0);

  void updateScroll(double value) {
    state = value.clamp(0.0, 1.0);
  }
}

// Projects Provider
final projectsProvider = FutureProvider<List<Project>>((ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  return repository.getProjects();
});

// Cursor Provider
final cursorProvider =
    StateNotifierProvider<CursorNotifier, CursorState>((ref) {
  return CursorNotifier();
});

class CursorState {
  final Offset position;
  final bool isHovering;

  CursorState({this.position = Offset.zero, this.isHovering = false});

  CursorState copyWith({Offset? position, bool? isHovering}) {
    return CursorState(
      position: position ?? this.position,
      isHovering: isHovering ?? this.isHovering,
    );
  }
}

class CursorNotifier extends StateNotifier<CursorState> {
  CursorNotifier() : super(CursorState());

  void updatePosition(Offset newPosition) {
    state = state.copyWith(position: newPosition);
  }

  void setHovering(bool isHovering) {
    state = state.copyWith(isHovering: isHovering);
  }
}
