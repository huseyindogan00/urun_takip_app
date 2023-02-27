import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieCustomWidget extends StatelessWidget {
  LottieCustomWidget({super.key, required this.path});

  String path;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/$path',
      animate: true,
      fit: BoxFit.cover,
    );
  }
}
