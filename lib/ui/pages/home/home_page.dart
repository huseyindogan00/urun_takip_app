import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/ui/components/home_text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Hero(
            tag: 'logo',
            child: Image.asset(
              ConstImage.logoPath,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 100, height: 100, color: Colors.red),
                Container(width: 100, height: 100, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 100, height: 100, color: Colors.amber),
                Container(width: 100, height: 100, color: Colors.purple),
              ],
            ),
          ),
          Spacer(flex: 1)
        ],
      ),
    ));
  }
}
