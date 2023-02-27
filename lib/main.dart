import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/strings/const_appbar_text.dart';
import 'package:urun_takip_app/core/constant/theme/theme_app.dart';
import 'package:urun_takip_app/ui/pages/splash/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstAppbarText.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.myThemeData,
      home: const SplashView(),
    );
  }
}
