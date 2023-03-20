import 'package:flutter/material.dart';

class HomeCardContainer extends StatelessWidget {
  HomeCardContainer(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color,
      required this.height,
      required this.width,
      this.borderRadius,
      required this.iconPath});
  final double? borderRadius;
  final Color color;
  final double width;
  final double height;
  final String title;
  final VoidCallback onTap;
  String iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 0),
            ),
            boxShadow: const [
              BoxShadow(blurRadius: 10, blurStyle: BlurStyle.normal),
            ]),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(iconPath),
            Text(title),
          ],
        )),
      ),
    );
  }
}
