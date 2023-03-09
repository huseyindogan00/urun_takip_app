import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbarWidget({super.key, required this.title});
  String title;
  double imageWidth = 80;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        Image.asset(
          ConstImage.logoPath,
          width: imageWidth,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size(double.infinity, CustomSize.appbarHeight);
  }
}
