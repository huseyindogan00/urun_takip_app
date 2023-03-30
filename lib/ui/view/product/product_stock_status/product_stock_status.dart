import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
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
              child: FutureBuilder<List<BaseModel>>(
                future: _productViewModel
                    .fetchProductByCategory(context.watch<ProductViewModel>().selectFilterCategoryName!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                    return _buildProgress();
                  } else {
                    List<ProductModel> _productModel = snapshot.data as List<ProductModel>;
                    if (_productModel.isEmpty) {
                      return _buildProductEmpty(context);
                    } else {
                      return _buildListProduct(_productModel, context);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildProgress() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey.shade300,
      ),
    );
  }

  Center _buildProductEmpty(BuildContext context) {
    return Center(
      child: Text(
        'Ürün Listesi Boş',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade200),
      ),
    );
  }

  ListView _buildListProduct(List<ProductModel> _productModel, BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _productModel.length,
      itemBuilder: (_, index) {
        return Dismissible(
            key: ValueKey(index),
            background: Container(
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  size: 64,
                )),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              bool? result = await const PlatformSensitiveAlertDialog(
                content: 'Silmek istediğinizden emin misiniz?',
                title: 'Uyarı!',
                doneButtonTitle: 'Evet',
                cancelButtonTitle: 'İptal',
              ).show(context);

              if (result != null && result) {
                await _productViewModel.delete(_productModel[index].id!);
                setState(() {});
              }
              return result;
            },
            child: ProductStockWidget(productModel: _productModel[index]));
      },
    );
  }
}
