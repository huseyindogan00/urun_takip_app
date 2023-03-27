import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/text/const_appbar_text.dart';
import 'package:urun_takip_app/core/constant/theme/theme_app.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/firebase_options.dart';
import 'package:urun_takip_app/ui/view_model/product_view_model/product_view_model.dart';
import 'package:urun_takip_app/ui/pages/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(),
        )
      ],
      child: MaterialApp(
        title: ConstAppbarText.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.myThemeData,
        home: const SplashView(),
      ),
    );
  }
}
