import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/colors/const_application_colors.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/ui/components/common/home_card_container.dart';
import 'package:urun_takip_app/ui/view/product/product_add_view.dart';
import 'package:urun_takip_app/ui/view/product/product_stock_status_view.dart';
import 'package:urun_takip_app/ui/view/work/completed_work_view.dart';
import 'package:urun_takip_app/ui/view/work/work_in_progress_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  double containerHeight = 130;
  double containerWidth = 135;
  double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            _buildLogo(flex: 4, context: context),
            //_buildCustomDivider(),
            _buildRowFirst(flex: 3, context: context),
            _buildRowSecond(flex: 3, context: context),
            _buildRowThird(flex: 3, context: context),
            const Spacer(flex: 1),
          ],
        ),
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
          _buildCompletedWorksContainer(context),
          _buildWorksInProgressContainer(context),
        ],
      ),
    );
  }

  Widget _buildRowThird({required int flex, required BuildContext context}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //_buildWorkHistoryContainer(context),
          _buildSettingsContainer(context),
        ],
      ),
    );
  }

  _buildCompletedWorksContainer(BuildContext context) {
    return HomeCardContainer(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompletedWorkView(),
            ));
      },
      title: AppText.tamamlananIsler,
      color: ConstApplicationColors.homeCompletedWorksContainerColor,
      height: containerHeight,
      width: containerWidth,
      iconPath: ConstImage.completedworkPath,
      borderRadius: borderRadius,
    );
  }

  _buildWorksInProgressContainer(BuildContext context) {
    return HomeCardContainer(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkInProgressView(),
            ));
      },
      title: AppText.devamEdenIsler,
      color: ConstApplicationColors.homeWorksInProgressContainerColor,
      height: containerHeight,
      width: containerWidth,
      iconPath: ConstImage.workinprogressPath,
      borderRadius: borderRadius,
    );
  }

  /* Container _buildCustomDivider() {
    return Container(
      height: 5,
      width: 200,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: ConstApplicationColors.homeBackgroundColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  } */

  //* STOK DURUMU
  Widget _buildStockStatusContainer(BuildContext context) {
    return HomeCardContainer(
      iconPath: ConstImage.iconStockStatusPath,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductStockStatusView(),
            ));
      },
      title: AppText.stokDurumu,
      color: ConstApplicationColors.homeStockStatusContainerColor,
      height: containerHeight,
      width: containerWidth,
      borderRadius: borderRadius,
    );
  }

  //* ÜRÜN EKLE
  Widget _buildAddProductContainer(BuildContext context) {
    return HomeCardContainer(
      iconPath: ConstImage.iconAddProductPath,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductAddView(),
          ),
        );
      },
      title: AppText.urunEkle,
      color: ConstApplicationColors.homeAddProductContainerColor,
      height: containerHeight,
      width: containerWidth,
      borderRadius: borderRadius,
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
      height: containerHeight,
      width: containerWidth,
      borderRadius: borderRadius,
    );
  }
}
