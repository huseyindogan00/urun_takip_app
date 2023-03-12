import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      required this.radius,
      required this.height,
      required this.width});

  final Function onPressed;
  final Icon icon;
  final String label;
  final double radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius)))),
        onPressed: () async => onPressed(),
        icon: icon,
        label: Text(label),
      ),
    );
  }
}
