import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';
import 'package:urun_takip_app/ui/widget/product_stock_widget.dart';

class ProductStockStatusView extends StatefulWidget {
  const ProductStockStatusView({super.key});

  @override
  State<ProductStockStatusView> createState() => _ProductStockStatusViewState();
}

class _ProductStockStatusViewState extends State<ProductStockStatusView> {
  late ProductViewModel _productViewModel;
  late final _controller;

  @override
  void initState() {
    super.initState();
    _productViewModel = ProductViewModel();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(title: AppText.urunStokDurumu),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Color.fromARGB(255, 85, 85, 85),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: _productViewModel.fetchProductAll(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey.shade300,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ProductStockWidget(productModel: snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
