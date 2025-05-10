import 'package:flutter/material.dart';

ThemeData dartTheme = ThemeData(
  fontFamily: 'Inter',
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey[800],elevation: 0),
  scaffoldBackgroundColor: Colors.grey[800],
  colorScheme: ColorScheme.dark(
    surface: Colors.black54,
    primary: Colors.green[800]!,
    secondary: Colors.black87,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey.shade500
  ),
  textTheme:  ThemeData.dark().textTheme.copyWith(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.grey.shade200),
    bodySmall: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  ),
);
