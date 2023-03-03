import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({super.key});

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  String? firstCategory;
  String? subCategory;
  late CategoryModel _allCategoryModel;
  late final TextEditingController controller;
  late final _productViewModel;
  late final formKey;
  String? selectValue;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    _productViewModel = ProductViewModel();
    //_allCategoryModel.category = categoryAllMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Ürün Ekle',
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.only(left: CustomPadding.paddingTextLeft),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text('Kategori Seçiniz'),
                    ),
                    value: selectValue,
                    isExpanded: true,
                    items: categoryAllMap['Teknoloji Ürünleri']
                        ?.map(_buildDropdownMenuItem)
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectValue = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String menuItem) {
    return DropdownMenuItem(
      value: menuItem,
      child: Text(menuItem),
    );
  }
}
