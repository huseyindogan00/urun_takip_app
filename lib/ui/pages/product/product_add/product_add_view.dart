import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/custom_dropdown.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({super.key});

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  late final TextEditingController _commentEditController;
  late final TextEditingController _stockodeEditController;
  late final TextEditingController _stockPieceEditController;
  late final TextEditingController _unitPriceEditController;
  late final TextEditingController _kdvEditController;
  late final TextEditingController _totalPriceEditController;
  late final TextEditingController _photoURLEditController;
  late final TextEditingController _createDateEditController;

  late final formKey;
  late String _selectCategoryName;

  @override
  void initState() {
    super.initState();
    _commentEditController = TextEditingController();
    _stockodeEditController = TextEditingController();
    _stockPieceEditController = TextEditingController();
    _unitPriceEditController = TextEditingController();
    _kdvEditController = TextEditingController();
    _totalPriceEditController = TextEditingController();
    _photoURLEditController = TextEditingController();
    _createDateEditController = TextEditingController();

    formKey = GlobalKey<FormState>();
    _selectCategoryName = categoryAllMap.keys.first.toString();
  }

  @override
  void dispose() {
    _commentEditController.dispose();
    _stockodeEditController.dispose();
    _stockPieceEditController.dispose();
    _unitPriceEditController.dispose();
    _kdvEditController.dispose();
    _totalPriceEditController.dispose();
    _photoURLEditController.dispose();
    _createDateEditController.dispose();

    super.dispose();
  }

  final decoration = BoxDecoration(
    borderRadius: CustomSize.customRadius,
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
        title: AppText.urunEkle,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: CustomPadding.paddinDefaultSymmetric,
          child: Column(
            children: [
              CustomCategoryDropdownButton(),
              TextFormField(
                maxLines: 5,
                maxLength: 150,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: CustomPadding.paddingTextFormField,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 18),
                  label: const Text(AppText.aciklama),
                  focusedBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: CustomPadding.paddingTextFormField,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 18),
                        label: const Text(AppText.stokKodu),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'stok adedi',
                        labelText: 'stok',
                        alignLabelWithHint: true,
                        contentPadding: CustomPadding.paddingTextFormField,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 18),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
