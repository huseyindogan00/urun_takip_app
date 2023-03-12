import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/utility/util/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/image_and_video_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/constants_model.dart';
import 'package:urun_takip_app/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_icon_button.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/custom_dropdown.dart';
import 'package:urun_takip_app/ui/components/form/custom_text_form_field.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class ProductAddView extends StatefulWidget {
  const ProductAddView({super.key});

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  late final TextEditingController _commentEditController;
  late final TextEditingController _stockCodeEditController;
  late final TextEditingController _stockPieceEditController;
  late final TextEditingController _unitPriceEditController;
  late final TextEditingController _kdvEditController;
  late final TextEditingController _totalPriceEditController;
  late final TextEditingController _photoURLEditController;
  late final TextEditingController _createDateEditController;

  late final GlobalKey<FormState> _formKey;
  late String _selectCategoryName;
  late ProductViewModel _productViewModel;
  // branch

  @override
  void initState() {
    super.initState();
    _commentEditController = TextEditingController();
    _stockCodeEditController = TextEditingController();
    _stockPieceEditController = TextEditingController();
    _unitPriceEditController = TextEditingController();
    // KDV GİBİ sabit değerleri daha sonra uygulama başlarken veritabanından getireceğiz.
    // Ayarlar menüsünden bu gibi sabit değerlere müdahale edilmeyecek
    _kdvEditController = TextEditingController(text: ConstantsModel().kdv.toString().replaceAll('.', ','));
    _totalPriceEditController = TextEditingController();
    _photoURLEditController = TextEditingController();
    _createDateEditController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    _selectCategoryName = categoryAllMap.keys.first.toString();
  }

  @override
  void dispose() {
    _commentEditController.dispose();
    _stockCodeEditController.dispose();
    _stockPieceEditController.dispose();
    _unitPriceEditController.dispose();
    _kdvEditController.dispose();
    _totalPriceEditController.dispose();
    _photoURLEditController.dispose();
    _createDateEditController.dispose();
    _formKey.currentState?.dispose();
    //!sayfada görevini bitirmeden dispose olduğu için hata veriyor
    //_productViewModel.dispose();
    super.dispose();
  }

  final decoration = BoxDecoration(
    borderRadius: CustomSize.customRadius,
    border: Border.all(
      color: Colors.grey,
      width: 2,
    ),
  );

//yeni commit
  @override
  Widget build(BuildContext context) {
    _productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: AppText.urunEkle,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: CustomPadding.paddinDefaultSymmetric,
            child: Column(
              children: [
                CustomCategoryDropdownButton(), //KATEGORİLER
                CustomSize.betweenWidgetSize,
                //* AÇIKLAMA
                CustomTextFormField(
                  controller: _commentEditController,
                  labelText: AppText.aciklama,
                  maxLines: 5,
                  maxLength: 150,
                  validator: (newValue) => Validation.generealValidation(newValue),
                  onSaved: (newValue) => _commentEditController.text = newValue!,
                ),
                CustomSize.betweenWidgetSize,
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      //* STOK KODU
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: _stockCodeEditController,
                        labelText: AppText.stokKodu,
                        validator: (newValue) => Validation.generealValidation(newValue),
                        onSaved: (String? newValue) => _stockCodeEditController.text = newValue!,
                      ),
                    ),
                    CustomSize.spacerDefaultFlex,
                    Expanded(
                      flex: 4,
                      //* STOK ADEDİ
                      child: CustomTextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: _stockPieceEditController,
                        labelText: AppText.stokAdedi,
                        onChanged: (value) {
                          _productViewModel.calculateNetPrice(
                              _unitPriceEditController.text, _kdvEditController.text, _stockPieceEditController.text);
                        },
                        validator: (newValue) => Validation.generealValidation(newValue),
                        onSaved: (newValue) => _stockPieceEditController.text = newValue!,
                      ),
                    ),
                  ],
                ),
                CustomSize.betweenWidgetSize,
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      //* BİRİM FİYATI
                      child: CustomTextFormField(
                        maxLines: 1,
                        controller: _unitPriceEditController,
                        labelText: AppText.birimFiyat,
                        suffix: Image.asset(ConstImage.iconLiraBlackPath, width: 20),
                        validator: (newValue) => Validation.moneyValueCheck(newValue),
                        onChanged: (String? value) {
                          _unitPriceEditController.text = CurrencyFormatter.instance().moneyValueCheck(value);
                          _unitPriceEditController.selection =
                              TextSelection.fromPosition(TextPosition(offset: _unitPriceEditController.text.length));
                          _productViewModel.calculateNetPrice(
                              _unitPriceEditController.text, _kdvEditController.text, _stockPieceEditController.text);
                        },
                        onSaved: (String? newValue) {},
                      ),
                    ),
                    CustomSize.spacerDefaultFlex,
                    Expanded(
                      flex: 4,
                      //* KDV
                      child: CustomTextFormField(
                        suffix: Image.asset(ConstImage.iconLiraBlackPath, width: 20),
                        readOnly: true,
                        controller: _kdvEditController,
                        labelText: AppText.kdv,
                        onSaved: (newValue) {},
                      ),
                    ),
                  ],
                ),
                CustomSize.betweenWidgetSize,
                //* TOPLAM TUTAR
                Consumer<ProductViewModel>(
                  builder: (_, model, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _totalPriceEditController.text = model.totalPrice;
                    });

                    return CustomTextFormField(
                      controller: _totalPriceEditController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      suffix: Image.asset(
                        ConstImage.iconLiraBlackPath,
                        width: 20,
                      ),
                      labelText: AppText.netFiyat,
                      onSaved: (newValue) {},
                    );
                  },
                ),
                CustomSize.betweenWidgetSize,
                //* FOTOĞRAFIN ALINDIĞI WİDGET
                Stack(
                  children: [
                    _buildViewPhoto(context),
                    _buildSelectProductPhoto(context),
                    //_buildInfoText(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer<ProductViewModel> _buildViewPhoto(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, model, child) {
        return model.productImageFile == null
            ? child!
            : SizedBox(
                width: CustomSize.kWidth(context),
                child: Image(
                  fit: BoxFit.cover,
                  image: FileImage(File(model.productImageFile!.path)),
                ),
              );
      },
      child: SizedBox(
        width: CustomSize.kWidth(context),
        child: Image(
          image: AssetImage(ConstImage.defaultImagePlaceHolder),
        ),
      ),
    );
  }

  Widget _buildSelectProductPhoto(BuildContext context) {
    return Positioned(
      right: 20,
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.99),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: 200,
                child: Column(
                  children: [
                    CustomElevatedIconButton(
                      onPressed: () async {
                        await _productViewModel.getPhotoFromGallery();
                        if (mounted) Navigator.pop(context);
                      },
                      icon: const Icon(Icons.image),
                      label: 'Galeriden Seç',
                      radius: 0,
                      height: 50,
                      width: CustomSize.kWidth(context),
                    ),
                    const SizedBox(height: 15),
                    CustomElevatedIconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.camera),
                      label: 'Fotoğraf Çek',
                      radius: 0,
                      height: 50,
                      width: CustomSize.kWidth(context),
                    )
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.image_search_rounded,
          size: 50,
          shadows: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
      ),
    );
  }

  Positioned _buildInfoText(BuildContext context) {
    return Positioned(
      left: 60,
      bottom: CustomSize.kWidth(context) * 0.2,
      child: Text(
        'Görsel eklemek için büyütece dokunun',
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
