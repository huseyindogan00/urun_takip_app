import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/uuid_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_button.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_icon_button.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/custom_dropdown.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
import 'package:urun_takip_app/ui/components/form/custom_text_form_field.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';
import 'package:urun_takip_app/ui/widget/image_view_widget.dart';

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
  late final TextEditingController _photoPathEditController;
  late final TextEditingController _createDateEditController;
  late final ScrollController _scrollController;

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
    _kdvEditController = TextEditingController(text: '18');
    _totalPriceEditController = TextEditingController();
    _photoPathEditController = TextEditingController();
    _createDateEditController = TextEditingController();

    _scrollController = ScrollController();
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
    _photoPathEditController.dispose();
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
        controller: _scrollController,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: CustomPadding.paddinDefaultSymmetric,
            child: Column(
              children: [
                //KATEGORİLER
                CustomCategoryDropdownButton(),
                CustomSize.betweenWidgetSize,
                //* AÇIKLAMA
                _buildComment(),
                CustomSize.betweenWidgetSize,
                Row(
                  children: [
                    //* STOK KODU
                    _buildStockCode(),
                    CustomSize.spacerDefaultFlex,
                    //* KDV
                    _buildKDV(),
                  ],
                ),
                CustomSize.betweenWidgetSize,
                Row(
                  children: [
                    //* BİRİM FİYATI
                    _buildUnitPrice(),
                    CustomSize.spacerDefaultFlex,
                    //* STOK ADEDİ
                    _buildStockPiece(),
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
                      onSaved: (newValue) {
                        _totalPriceEditController.text = newValue!;
                      },
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
                ),
                CustomSize.betweenWidgetSize,
                // ÜRÜN EKLEME
                _buildAddProduct(context),
                CustomSize.betweenWidgetSize,
                // EKLEME İPTAL
                _buildCancel(context),
                CustomSize.betweenWidgetSize,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildStockCode() {
    return Expanded(
      flex: 5,
      child: CustomTextFormField(
        maxLines: 1,
        controller: _stockCodeEditController,
        labelText: AppText.stokKodu,
        validator: (newValue) => Validation.generealValidation(newValue),
        onSaved: (String? newValue) => _stockCodeEditController.text = newValue ?? '',
      ),
    );
  }

  CustomTextFormField _buildComment() {
    return CustomTextFormField(
      controller: _commentEditController,
      labelText: AppText.aciklama,
      maxLines: 5,
      maxLength: 150,
      validator: (newValue) => Validation.generealValidation(newValue),
      onSaved: (newValue) => _commentEditController.text = newValue ?? '',
    );
  }

  Expanded _buildStockPiece() {
    return Expanded(
      flex: 3,
      child: CustomTextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _stockPieceEditController,
        labelText: AppText.stokAdedi,
        onChanged: (value) {
          // PROVIDER İLE NET TUTAR DEĞERİNİ GÜNCELLİYOR
          _productViewModel.calculateNetPrice(
              _unitPriceEditController.text, _kdvEditController.text, _stockPieceEditController.text);
        },
        validator: (newValue) => Validation.generealValidation(newValue),
        onSaved: (newValue) => _stockPieceEditController.text = newValue ?? '',
      ),
    );
  }

  Expanded _buildUnitPrice() {
    return Expanded(
      flex: 5,
      child: CustomTextFormField(
        maxLines: 1,
        controller: _unitPriceEditController,
        labelText: AppText.birimFiyat,
        suffix: Image.asset(ConstImage.iconLiraBlackPath, width: 20),
        validator: (newValue) => Validation.moneyValueCheck(newValue),
        onChanged: (String? value) {
          _unitPriceEditController.text = CurrencyFormatter.instance().moneyValueCheck(value);
          //imleci satır sonuna getirme
          _unitPriceEditController.selection =
              TextSelection.fromPosition(TextPosition(offset: _unitPriceEditController.text.length));
          // PROVIDER İLE NET TUTAR DEĞERİNİ GÜNCELLİYOR
          _productViewModel.calculateNetPrice(
              _unitPriceEditController.text, _kdvEditController.text, _stockPieceEditController.text);
        },
        onSaved: (String? newValue) => _unitPriceEditController.text = newValue ?? '',
      ),
    );
  }

  Expanded _buildKDV() {
    return Expanded(
      flex: 3,
      child: CustomTextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        prefix: const Text('% '),
        controller: _kdvEditController,
        labelText: AppText.kdv,
        validator: Validation.generealValidation,
        onSaved: (newValue) => _kdvEditController.text = newValue ?? '',
      ),
    );
  }

  CustomElevatedButton _buildCancel(BuildContext context) {
    return CustomElevatedButton(
      text: 'İptal',
      isConfirm: false,
      onPressed: () {
        Navigator.pop(context);
      },
      height: 50,
    );
  }

  Consumer<ProductViewModel> _buildViewPhoto(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, model, child) {
        return model.productImageFilePath == null
            ? child!
            : SizedBox(
                width: CustomSize.kWidth(context),
                child: Hero(
                  tag: 'product_image',
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        if (model.productImageFilePath != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewWidget(imagePath: model.productImageFilePath!.path),
                            ),
                          );
                        }
                      },
                      child: Image(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(model.productImageFilePath!.path),
                        ),
                      ),
                    ),
                  ),
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
                      icon: const Icon(Icons.image),
                      label: 'Galeriden Seç',
                      radius: 0,
                      height: 50,
                      width: CustomSize.kWidth(context),
                      onPressed: _getPhotoFromGallery,
                    ),
                    const SizedBox(height: 15),
                    CustomElevatedIconButton(
                      icon: const Icon(Icons.camera),
                      label: 'Fotoğraf Çek',
                      radius: 0,
                      height: 50,
                      width: CustomSize.kWidth(context),
                      onPressed: _getPhotoFromCamera,
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

  CustomElevatedButton _buildAddProduct(BuildContext context) {
    return CustomElevatedButton(
      text: 'Ürün Ekle',
      onPressed: () async {
        if (_productViewModel.categoryModel.categoryName == null ||
            _productViewModel.categoryModel.categorySubName == null) {
          await const PlatformSensitiveAlertDialog(
                  content: 'Kategori seçiniz', title: 'Uyarı!', doneButtonTitle: 'tamam')
              .show(context);
        } else {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            ProductModel productModel = ProductModel(
              id: UuidManager().randomId(),
              stockCode: _stockCodeEditController.text,
              title: _commentEditController.text,
              category: _productViewModel.categoryModel,
              stockPiece: _stockPieceEditController.text.convertFromStringToDouble(),
              unitPrice: _unitPriceEditController.text.convertFromStringToDouble(),
              kdv: _kdvEditController.text.convertFromStringToDouble(),
              totalPrice: _totalPriceEditController.text.convertFromStringToDouble(),
              photoPath: _productViewModel.productImageFilePath?.path,
              createDate: DateTime.now(),
            );
            await _productViewModel.addProductModel(productModel);
            if (mounted) Navigator.pop(context);
          }
        }
      },
      height: 50,
    );
  }

  void _getPhotoFromGallery() async {
    bool? result = await _productViewModel.getPhotoFromGallery(context);
    if (mounted && (result == null || result)) {
      double end = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(end, duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
      Navigator.pop(context);
    }
  }

  void _getPhotoFromCamera() async {
    bool? result = await _productViewModel.getPhotoFromCamera(context);
    if (mounted && (result == null || result)) {
      double end = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(end, duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
      Navigator.pop(context);
    }
  }

  // RESİM EKLENMEDİĞİ ZAMAN ÜZERİNDE BİLGİ AMAÇLI TEXT YAZDIRMA
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
