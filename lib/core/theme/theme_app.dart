import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData themeData = ThemeData.light().copyWith(
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.red),
      displayMedium: TextStyle(color: Colors.red),
    ),
  );
}
