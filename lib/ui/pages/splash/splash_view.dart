import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/strings/const_appbar_text.dart';
import 'package:urun_takip_app/ui/components/common/lottie_custom_widget.dart';
import 'package:urun_takip_app/ui/pages/home/home_page.dart';
import 'package:urun_takip_app/ui/pages/splash/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel _splashViewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _splashViewModel da yapılacak işlemler burada yapılacak. Sayfa yönlendirme vs.
      await Future.delayed(const Duration(seconds: 3));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
      print('callback çalıştı');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build çalıştı');
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            _buildAppName(context),
            _buildLotieAnimation(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() =>
      Expanded(flex: 6, child: Image.asset(ConstImage.logoPath));

  Widget _buildAppName(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(ConstAppbarText.appName,
          style: Theme.of(context).textTheme.displayMedium),
    );
  }

  Widget _buildLotieAnimation() => Expanded(
      flex: 4,
      child: LottieCustomWidget(
        path: 'stock.json',
        fit: BoxFit.contain,
      ));
}
