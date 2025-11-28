import 'package:flutter/material.dart';
import 'package:application_about_me/data/services/theme_service.dart';

class ThemeViewModel extends ChangeNotifier {
  final ThemeService _themeService;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeViewModel(this._themeService) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    _themeMode = await _themeService.loadThemeMode();
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode newThemeMode) async {
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();
    await _themeService.saveThemeMode(newThemeMode);
  }
}
