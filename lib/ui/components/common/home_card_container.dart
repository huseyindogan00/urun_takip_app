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
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage(iconPath),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
