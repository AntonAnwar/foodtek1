import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Inter',
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100,
    primary: Color(0xFF25AE4B),
    secondary:Colors.white,

  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black26),
    bodySmall: TextStyle(color: Colors.grey.shade400),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
  ),
);
