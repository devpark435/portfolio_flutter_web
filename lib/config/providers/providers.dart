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
