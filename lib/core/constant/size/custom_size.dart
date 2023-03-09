import 'package:flutter/material.dart';

class CustomSize {
  /// Ekran genişliğini geriye döner
  static double kWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Ekran yüksekliğini geriye döner.
  static double kHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const double appbarHeight = 65;

  static const customRadius = BorderRadius.all(Radius.circular(10));
}
