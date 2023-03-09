import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/custom_dropdown.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({super.key});

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  late final TextEditingController _controller;
  late final formKey;
  late String _selectCategoryName;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    _selectCategoryName = categoryAllMap.keys.first.toString();
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
              CustomDropdownButton(),
              TextFormField(
                maxLines: 5,
                maxLength: 150,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    label: Text(
                      'Açıklama',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
