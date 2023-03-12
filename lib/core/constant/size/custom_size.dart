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

  /// double değeri = 65
  static const double appbarHeight = 65;

  /// SizedBox height değeri = 25
  static const betweenWidgetSize = SizedBox(height: 25);

  /// BorderRadius.all(Radius.circular(10))
  static const customRadius = BorderRadius.all(Radius.circular(10));

  /// Spacer flex default değeri = 1
  static const spacerDefaultFlex = Spacer(flex: 1);
}
