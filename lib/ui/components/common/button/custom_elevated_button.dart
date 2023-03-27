import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/ui/view_model/product_view_model/product_view_model.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.radius = 10,
      required this.height,
      this.width,
      this.isConfirm = true,
      this.buttonStyle,
      this.isCircularProgressIndicator = false});

  final Function onPressed;
  final String text;
  double radius;
  final double height;
  double? width;
  bool isConfirm;
  final ButtonStyle? buttonStyle;
  bool isCircularProgressIndicator;

  @override
  Widget build(BuildContext context) {
    width ??= CustomSize.kWidth(context);
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: buttonStyle ??
            ElevatedButton.styleFrom(
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
        child: context.watch<ProductViewModel>().viewState == ProductViewState.BUSY && isCircularProgressIndicator
            ? CircularProgressIndicator(color: Colors.grey.shade300)
            : Text(
                text,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
