import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/colors/const_application_colors.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/ui/components/common/home_card_container.dart';
import 'package:urun_takip_app/ui/pages/product/product_add/product_add_view.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          _buildLogo(flex: 3, context: context),
          //_buildCustomDivider(),
          _buildRowFirst(flex: 2, context: context),
          _buildRowSecond(flex: 2, context: context),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildLogo({required int flex, required BuildContext context}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Image.asset(ConstImage.logoPath),
        ),
      ),
    );
  }

  Expanded _buildRowFirst({required BuildContext context, required int flex}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStockStatusContainer(context),
          _buildAddProductContainer(context),
        ],
      ),
    );
  }

  Expanded _buildRowSecond({required BuildContext context, required int flex}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOrderHistoryContainer(context),
          _buildSettingsContainer(context),
        ],
      ),
    );
  }

  Container _buildCustomDivider() {
    return Container(
      height: 5,
      width: 200,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: ConstApplicationColors.homeBackgroundColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  // STOK DURUMU
  Widget _buildStockStatusContainer(BuildContext context) {
    return HomeCardContainer(
      iconPath: ConstImage.iconStockStatusPath,
      onTap: () {
        print('Stok Durumu tıklandı');
      },
      title: AppText.stokDurumu,
      color: ConstApplicationColors.homeStockStatusContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  // ÜRÜN EKLE
  Widget _buildAddProductContainer(BuildContext context) {
    return HomeCardContainer(
      iconPath: ConstImage.iconAddProductPath,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => ProductViewModel(),
              child: const ProductAddView(),
            ),
          ),
        );
      },
      title: AppText.urunEkle,
      color: ConstApplicationColors.homeAddProductContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  // SİPARİŞ GEÇMİŞİ
  Widget _buildOrderHistoryContainer(
    BuildContext context,
  ) {
    return HomeCardContainer(
      iconPath: ConstImage.iconOrderHistoryPath,
      onTap: () {
        print('Stok geçmişi tıklandı');
      },
      title: AppText.stokGecmisi,
      color: ConstApplicationColors.homeOrderHistoryContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  // AYARLAR
  Widget _buildSettingsContainer(
    BuildContext context,
  ) {
    return HomeCardContainer(
      iconPath: ConstImage.iconSettingsPath,
      onTap: () {
        print('Ayarlar');
      },
      title: AppText.ayarlar,
      color: ConstApplicationColors.homeSettingsContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }
}
