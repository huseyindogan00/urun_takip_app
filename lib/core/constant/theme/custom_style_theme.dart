import 'package:flutter/material.dart';

class CustomStyleTheme {
  // TEXT THEME
  static TextTheme get textTheme => const TextTheme(
        displayMedium: TextStyle(
            fontSize: 28,
            color: Color.fromRGBO(211, 211, 211, 100),
            shadows: [
              Shadow(blurRadius: 2, color: Colors.white),
              Shadow(blurRadius: 4)
            ]),
        displaySmall: TextStyle(fontSize: 15, color: Colors.red),
        titleSmall:
            TextStyle(color: Color.fromARGB(255, 93, 38, 34), fontSize: 17),
        titleMedium: TextStyle(color: Colors.black),
      );

  // INPUT DECORATION THEME
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        helperStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        hintStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        errorStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        errorMaxLines: null,
        isDense: false,
        contentPadding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
        isCollapsed: false,
        prefixStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        suffixStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        counterStyle: const TextStyle(
          color: Color(0xdd000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        filled: true,
        fillColor: Colors.amber.shade200,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff000000),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      );

  // BUTTON THEME
  static ButtonThemeData get buttonThemeData => const ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        minWidth: 88,
        height: 36,
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff000000),
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        alignedDropdown: false,
        buttonColor: Color(0xffe0e0e0),
        disabledColor: Color(0x61000000),
        highlightColor: Color(0x29000000),
        splashColor: Colors.transparent,
        focusColor: Color(0x1f000000),
        hoverColor: Color(0x0a000000),
        colorScheme: ColorScheme(
          primary: Color(0xff453838),
          secondary: Color(0xff8d7272),
          surface: Color(0xffffffff),
          background: Color.fromARGB(255, 129, 118, 118),
          error: Color(0xffd32f2f),
          onPrimary: Color(0xffffffff),
          onSecondary: Color(0xffffffff),
          onSurface: Color(0xff000000),
          onBackground: Color(0xffffffff),
          onError: Color(0xffffffff),
          brightness: Brightness.light,
        ),
      );

  // ICON THEME DATA
  static IconThemeData get iconThemeData => const IconThemeData(
        color: Color(0xdd000000),
        opacity: 1,
        size: 24,
      );
  // ICON THEME DATA
  static IconThemeData get primaryIconTheme => const IconThemeData(
        color: Color(0xffffffff),
        opacity: 1,
        size: 24,
      );

  // CHİP THEME DATA
  static ChipThemeData get chipThemeData => const ChipThemeData(
        backgroundColor: Color(0x1f000000),
        brightness: Brightness.light,
        deleteIconColor: Color(0xde000000),
        disabledColor: Color(0x0c000000),
        labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
        labelStyle: TextStyle(
          color: Color(0xde000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
        secondaryLabelStyle: TextStyle(
          color: Color(0x3d000000),
          fontSize: null,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        secondarySelectedColor: Color(0x3d453838),
        selectedColor: Color(0x3d000000),
        shape: StadiumBorder(
            side: BorderSide(
          color: Color(0xff000000),
          width: 0,
          style: BorderStyle.none,
        )),
      );

  // CHECKBOX THEME DATA
  static CheckboxThemeData get checkbocThemeData => CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return const Color(0xff715b5b);
          }
          return null;
        }),
      );

  // TABBAR THEME DATA
  static TabBarTheme get tabBarThemeData => const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Color(0xffffffff),
        unselectedLabelColor: Color(0xb2ffffff),
      );

  // TEXT SELECTION THEME DATA
  static TextSelectionThemeData get textSelectionThemeData =>
      const TextSelectionThemeData(
        cursorColor: Color(0xff4285f4),
        selectionColor: Color(0xffd1c7c7),
        selectionHandleColor: Color(0xffbaabab),
      );
  // COLOR SCHEME
  static ColorScheme get colorScheme => ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
          4282726456,
          {
            50: Color(0xfff4f1f1),
            100: Color(0xffe8e3e3),
            200: Color(0xffd1c7c7),
            300: Color(0xffbaabab),
            400: Color(0xffa48e8e),
            500: Color(0xff8d7272),
            600: Color(0xff715b5b),
            700: Color(0xff544545),
            800: Color(0xff382e2e),
            900: Color(0xff1c1717)
          },
        ),
      )
          .copyWith(background: const Color(0xffd1c7c7))
          .copyWith(error: const Color(0xffd32f2f))
          .copyWith(secondary: const Color(0xff8d7272));
}
