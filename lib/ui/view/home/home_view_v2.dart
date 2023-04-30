import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/colors/const_application_colors.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/ui/components/common/home_card_container.dart';
import 'package:urun_takip_app/ui/view/product/product_add_view.dart';
import 'package:urun_takip_app/ui/view/product/product_stock_status_view.dart';
import 'package:urun_takip_app/ui/view/work/completed_work_view.dart';
import 'package:urun_takip_app/ui/view/work/work_in_progress_view.dart';

class HomeViewV2 extends StatelessWidget {
  HomeViewV2({super.key});

  double containerHeight = 70;
  double containerWidth = double.infinity;
  double borderRadius = 10;

  double wrapContainerRunSpacing = 40;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: wrapContainerRunSpacing,
              children: [
                _buildLogo(context),
                _buildAddProductContainer(context),
                _buildStockStatusContainer(context),
                _buildCompletedWorksContainer(context),
                _buildWorksInProgressContainer(context),
                _buildSettingsContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Image.asset(ConstImage.logoPath),
      ),
    );
  }

  _buildCompletedWorksContainer(BuildContext context) {
    return HomeCardContainer(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompletedWorkView(),
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

  // DEVAM EDEN İŞLER
  _buildWorksInProgressContainer(BuildContext context) {
    return HomeCardContainer(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkInProgressView(),
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

  // STOK DURUMU
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
