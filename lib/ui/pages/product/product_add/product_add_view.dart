import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/custom_dropdown.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({super.key});

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  late final TextEditingController _controller;
  late final _productViewModel;
  late final formKey;
  late String selectCategoryName;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    selectCategoryName = categoryAllMap.keys.first.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final decoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    border: Border.all(
      color: Colors.grey,
      width: 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    print('product add buildi çalıştı');
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Ürün Ekle',
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: CustomPadding.paddinDefaultSymmetric,
          child: Column(
            children: [
              CustomDropdownButton(
                items: categoryAllMap.keys.toList(),
                onChanged: (value) {
                  _productViewModel.selectCategoryName(value);
                },
              ),
              CustomDropdownButton(
                items: categoryAllMap[
                    Provider.of<ProductViewModel>(context).selectCategoryName]!,
                onChanged: (value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
