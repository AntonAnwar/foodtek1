import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/core/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'theme_mode';

  ThemeCubit() : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);

    switch (theme) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      case 'system':
      default:
        emit(ThemeMode.system);
        break;
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.dark
          ? 'dark'
          : 'system',
    );
  }

  void setLightMode() {
    emit(ThemeMode.light);
    _saveTheme(ThemeMode.light);
  }

  void setDarkMode() {
    emit(ThemeMode.dark);
    _saveTheme(ThemeMode.dark);
  }

  void setSystemMode() {
    emit(ThemeMode.system);
    _saveTheme(ThemeMode.system);
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);
    await _saveTheme(newMode);
  }
}




// class ThemeCubit extends Cubit<ThemeMode> {
//   ThemeCubit() : super(ThemeMode.system);
//
//   void setLightMode() => emit(ThemeMode.light);
//
//   void setDarkMode() => emit(ThemeMode.dark);
//
//   void setSystemMode() => emit(ThemeMode.system);
//
//   Future<void> toggleTheme() async {
//     if (state == ThemeMode.light) {
//       emit(ThemeMode.dark);
//     } else {
//       emit(ThemeMode.light);
//     }
//   }

  // changeTheme(){
  //   ThemeMode isDark = state;
  //   SharedPreferencesHelper().savePrefBool(key: "isDark", value: isDark);
  //   emit(isDark);
  // }

  // getTheme() async {
  //   bool isDark = await SharedPreferencesHelper().getPrefBool(
  //       key: "isDark", defaultValue: false);
  //   emit(isDark);
  // }
//}