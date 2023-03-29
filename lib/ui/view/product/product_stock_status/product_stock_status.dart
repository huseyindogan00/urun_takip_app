import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/dropdown/custom_filter_dropdown_widget.dart';
import 'package:urun_takip_app/ui/view_model/product_view_model/product_view_model.dart';
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
      appBar: CustomAppbarWidget(title: AppText.stokDurumu),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: const Color.fromARGB(255, 85, 85, 85),
        child: Column(
          children: [
            CustomFilterDropdownWidget(),
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: _productViewModel.fetchProductAll(context.watch<ProductViewModel>().selectFilterCategoryName!),
                builder: (context, snapshot) {
                  print('stream stok status tetiklendi');
                  if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey.shade300,
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Ürün Listesi Boş',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade200),
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
