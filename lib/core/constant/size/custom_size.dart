import 'package:flutter/material.dart';

class CustomSize {
  static double kWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double kHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double appbarHeight = 70;
}
