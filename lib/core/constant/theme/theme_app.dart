import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/theme/custom_style_theme.dart';

class ThemeApp {
  static final ThemeData myThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 26, 26, 26), // ARKA PLAN RENGİ
    primaryColorLight: const Color(0xffe8e3e3),
    primaryColorDark: const Color(0xff544545),
    canvasColor: const Color(0xfffafafa),
    scaffoldBackgroundColor: const Color(0xfffafafa),
    cardColor: const Color(0xffffffff),
    dividerColor: const Color(0x1f000000),
    highlightColor: Colors.transparent, // SPLASH COLOR RENGİ
    splashColor: const Color(0x66c8c8c8),
    unselectedWidgetColor: const Color(0x8a000000),
    disabledColor: const Color(0x61000000),
    secondaryHeaderColor: const Color(0xfff4f1f1),
    dialogBackgroundColor: const Color(0xffffffff),
    indicatorColor: const Color(0xff8d7272),
    hintColor: const Color(0x8a000000),
    textTheme: CustomStyleTheme.textTheme,
    buttonTheme: CustomStyleTheme.buttonThemeData,
    inputDecorationTheme: CustomStyleTheme.inputDecorationTheme,
    iconTheme: CustomStyleTheme.iconThemeData,
    primaryIconTheme: CustomStyleTheme.primaryIconTheme,
    tabBarTheme: CustomStyleTheme.tabBarThemeData,
    chipTheme: CustomStyleTheme.chipThemeData,
    checkboxTheme: CustomStyleTheme.checkbocThemeData,
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
    colorScheme: CustomStyleTheme.colorScheme,
    textSelectionTheme: CustomStyleTheme.textSelectionThemeData,
  );
}
