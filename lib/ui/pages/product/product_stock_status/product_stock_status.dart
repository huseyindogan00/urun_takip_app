import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';

class ProductStockStatusView extends StatelessWidget {
  const ProductStockStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(title: AppText.urunStokDurumu),
      body: Column(
        children: [
          TextField(),
          /* ListView.builder(itemBuilder: (context, index) {
          
        },itemCount: ,) */
        ],
      ),
    );
  }
}
