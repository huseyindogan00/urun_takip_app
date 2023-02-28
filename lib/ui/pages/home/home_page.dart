import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/colors/const_application_colors.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/ui/components/common/home_card_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          _buildLogo(flex: 2),
          //_buildCustomDivider(),
          _buildRowFirst(flex: 2),
          _buildRowSecond(flex: 2),
          const Spacer(flex: 1),
        ],
      ),
    ));
  }

  Expanded _buildRowSecond({required int flex}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOrderHistoryContainer(),
          _buildSettingsContainer(),
        ],
      ),
    );
  }

  Expanded _buildRowFirst({required int flex}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStockStatusContainer(),
          _buildAddProductContainer(),
        ],
      ),
    );
  }

  Widget _buildLogo({required int flex}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(ConstImage.logoPath),
        ),
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

  Widget _buildStockStatusContainer() {
    return HomeCardContainer(
      iconPath: ConstImage.iconStockStatusPath,
      onTap: () {
        print('Stok Durumu tıklandı');
      },
      title: 'Stok Durumu',
      color: ConstApplicationColors.homeStockStatusContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  Widget _buildAddProductContainer() {
    return HomeCardContainer(
      iconPath: ConstImage.iconAddProductPath,
      onTap: () {
        print('Ürün Ekle tıklandı');
      },
      title: 'Ürün Ekle',
      color: ConstApplicationColors.homeAddProductContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  Widget _buildOrderHistoryContainer() {
    return HomeCardContainer(
      iconPath: ConstImage.iconOrderHistoryPath,
      onTap: () {
        print('Stok geçmişi tıklandı');
      },
      title: 'Stok Geçmişi',
      color: ConstApplicationColors.homeOrderHistoryContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }

  Widget _buildSettingsContainer() {
    return HomeCardContainer(
      iconPath: ConstImage.iconSettingsPath,
      onTap: () {
        print('Ayarlar');
      },
      title: 'Ayarlar',
      color: ConstApplicationColors.homeSettingsContainerColor,
      height: 150,
      width: 150,
      borderRadius: 20,
    );
  }
}
