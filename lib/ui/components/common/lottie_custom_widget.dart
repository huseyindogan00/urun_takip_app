import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieCustomWidget extends StatelessWidget {
  LottieCustomWidget(
      {super.key,
      required this.path,
      this.controller,
      this.fit,
      this.height,
      this.keyLottie,
      this.width});

  String path;
  Animation<double>? controller;
  Key? keyLottie;
  double? width;
  double? height;
  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      key: keyLottie,
      'assets/lottie/$path',
      fit: fit,
      controller: controller,
      width: width,
      height: height,
    );
  }
}
