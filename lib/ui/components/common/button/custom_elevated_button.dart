import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.radius = 10,
    required this.height,
    this.width,
    this.isConfirm = true,
  });

  final Function onPressed;
  final String text;
  double radius;
  final double height;
  double? width;
  bool isConfirm;

  @override
  Widget build(BuildContext context) {
    width ??= CustomSize.kWidth(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isConfirm
              ? Theme.of(context).buttonTheme.colorScheme!.primary
              : Theme.of(context).buttonTheme.colorScheme!.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        onPressed: () async => onPressed(),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
