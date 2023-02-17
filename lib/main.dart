import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constants/strings/cons_app_text.dart';
import 'package:urun_takip_app/core/theme/theme_app.dart';
import 'package:urun_takip_app/ui/pages/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstAppText.materialTitle,
      theme: ThemeApp.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            ConstAppText.materialTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: const HomePage(),
      ),
    );
  }
}
