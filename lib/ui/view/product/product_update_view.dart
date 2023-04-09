import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/validation/validation.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_button.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_icon_button.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
import 'package:urun_takip_app/ui/components/common/dropdown/custom_category_dropdown.dart';
import 'package:urun_takip_app/ui/components/form/custom_text_form_field.dart';
import 'package:urun_takip_app/ui/view_model/product_view_model/product_view_model.dart';
import 'package:urun_takip_app/ui/widget/image_view_widget.dart';

class ProductUpdateView extends StatefulWidget {
  const ProductUpdateView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductUpdateView> createState() => _ProductUpdateViewState();
}

class _ProductUpdateViewState extends State<ProductUpdateView> {
  late final TextEditingController _commentEditController;
  late final TextEditingController _stockCodeEditController;
  late final TextEditingController _stockPieceEditController;
  late final TextEditingController _unitPriceEditController;
  late final TextEditingController _totalPriceEditController;
  late final TextEditingController _photoPathEditController;
  late final TextEditingController _createDateEditController;
  late final ScrollController _scrollController;

  late final GlobalKey<FormState> _formKey;
  late String _selectCategoryName;
  late ProductViewModel _productViewModel;
  late ProductModel _productModel;
  late bool _firstValueTotalPrice;

  @override
  void initState() {
    super.initState();
    _productModel = widget.productModel;
    _firstValueTotalPrice = true;
    _commentEditController = TextEditingController(text: _productModel.title);
    _stockCodeEditController = TextEditingController(text: _productModel.stockCode);
    _stockPieceEditController = TextEditingController(text: _productModel.stockPiece.toInt().toString());
    _unitPriceEditController = TextEditingController(
      text:
          CurrencyFormatter.instance().moneyValueCheck(_productModel.unitPrice.toString().convertFromDoubleToString()),
    );
    // KDV GİBİ sabit değerleri daha sonra uygulama başlarken veritabanından getireceğiz.
    // Ayarlar menüsünden bu gibi sabit değerlere müdahale edilmeyecek
    _totalPriceEditController = TextEditingController();
    _photoPathEditController = TextEditingController(text: _productModel.photoPath);
    //_createDateEditController = TextEditingController(text: _productModel.createDate);

    _scrollController = ScrollController();
    _formKey = GlobalKey<FormState>();

    // SAYFA YÜKLENDİKTEN SONRA ATAMALARI YAP
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      _productViewModel.selectCategoryName = _productModel.category.categoryName!;
      _productViewModel.selectCategorySubName = _productModel.category.categorySubName;
    });
  }

  @override
  void dispose() {
    _commentEditController.dispose();
    _stockCodeEditController.dispose();
    _stockPieceEditController.dispose();
    _unitPriceEditController.dispose();
    _totalPriceEditController.dispose();
    _photoPathEditController.dispose();
    //_createDateEditController.dispose();
    _formKey.currentState?.dispose();
    //!sayfada görevini bitirmeden dispose olduğu için hata veriyor
    //_productViewModel.dispose();
    _productViewModel.productImageFilePath = null;
    _productViewModel.totalPrice = '0,00';
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
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: AppText.urunGuncelle,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Form(
          key: _formKey,
          child: Container(
            color: Theme.of(context).canvasColor,
            padding: CustomPadding.paddinDefaultSymmetric,
            child: Column(
              children: [
                //KATEGORİLER
                CustomCategoryDropdown(),
                CustomSize.betweenWidgetSize,
                //* AÇIKLAMA
                _buildComment(),
                CustomSize.betweenWidgetSize,
                Row(
                  children: [
                    //* STOK KODU
                    _buildStockCode(),
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
                      _totalPriceEditController.text = _firstValueTotalPrice
                          ? CurrencyFormatter.instance()
                              .moneyValueCheck(_productModel.basePrice.toString().convertFromDoubleToString())
                          : model.totalPrice;
                    });
                    return CustomTextFormField(
                      controller: _totalPriceEditController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      suffix: Image.asset(
                        ConstImage.iconLiraBlackPath,
                        width: 20,
                      ),
                      labelText: AppText.matrah,
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
                // ÜRÜN GÜNCELLEME
                _buildUpdateProduct(context),
                CustomSize.betweenWidgetSize,
                // GÜNCELLEME İPTAL
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
        validator: (newValue) => Validation.generalValidation(newValue),
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
      validator: (newValue) => Validation.generalValidation(newValue),
      onSaved: (newValue) => _commentEditController.text = newValue ?? '',
    );
  }

  //* STOK ADEDİ
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
          // sayfa ilk açıldığında veritabınındaki değeri aldıktan sonra burdaki değer false yapılır ve viewmodel üzerinden totalprice alınır
          _firstValueTotalPrice = false;
          // PROVIDER İLE NET TUTAR DEĞERİNİ GÜNCELLİYOR
          _productViewModel.calculateBasePrice(_unitPriceEditController.text, _stockPieceEditController.text);
        },
        validator: (newValue) => Validation.generalValidation(newValue),
        onSaved: (newValue) => _stockPieceEditController.text = newValue ?? '',
      ),
    );
  }

  //* BİRİM FİYAT
  Expanded _buildUnitPrice() {
    return Expanded(
      flex: 5,
      child: CustomTextFormField(
        maxLines: 1,
        controller: _unitPriceEditController,
        labelText: AppText.birimFiyat,
        suffix: Image.asset(ConstImage.iconLiraBlackPath, width: 20),
        validator: (newValue) => Validation.moneyValueValidation(newValue),
        onChanged: (String? value) {
          // sayfa ilk açıldığında veritabınındaki değeri aldıktan sonra burdaki değer false yapılır ve viewmodel üzerinden totalprice alınır
          _firstValueTotalPrice = false;
          // Kullanıcının girdiği değeri TR para birimi formatına çevirir
          _unitPriceEditController.text = CurrencyFormatter.instance().moneyValueCheck(value);
          //imleci satır sonuna getirme
          _unitPriceEditController.selection =
              TextSelection.fromPosition(TextPosition(offset: _unitPriceEditController.text.length));
          // PROVIDER İLE NET TUTAR DEĞERİNİ GÜNCELLİYOR
          _productViewModel.calculateBasePrice(_unitPriceEditController.text, _stockPieceEditController.text);
        },
        onSaved: (String? newValue) => _unitPriceEditController.text = newValue ?? '',
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
      builder: (_, viewModel, child) {
        return (_productModel.photoURL == null || _productModel.photoURL!.isEmpty) &&
                viewModel.productImageFilePath == null
            ? child!
            : SizedBox(
                width: CustomSize.kWidth(context),
                child: Hero(
                  tag: 'product_image',
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        if (_productViewModel.productImageFilePath != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImageViewWidget(imagePath: _productViewModel.productImageFilePath!.path),
                            ),
                          );
                        } else if (_productModel.photoURL != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewWidget(imagePath: _productModel.photoURL!),
                            ),
                          );
                        }
                      },
                      child: viewModel.productImageFilePath != null
                          ? Image(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(viewModel.productImageFilePath!.path),
                              ),
                            )
                          : Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(_productModel.photoURL!),
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
          shadows: [BoxShadow(blurRadius: 2)],
        ),
      ),
    );
  }

  CustomElevatedButton _buildUpdateProduct(BuildContext context) {
    return CustomElevatedButton(
      isCircularProgressIndicator: true,
      text: 'Güncelle',
      height: 50,
      onPressed: () async {
        if (_productViewModel.categoryModel.categoryName == null ||
            _productViewModel.categoryModel.categorySubName == null ||
            _productViewModel.categoryModel.categoryName == 'Tümü') {
          await _productViewModel.showDialogCustom(context, 'Kategori Seçiniz', 'Uyarı', 'Tamam');
        } else {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            ProductModel productModel = ProductModel(
              id: _productModel.id,
              stockCode: _stockCodeEditController.text,
              title: _commentEditController.text,
              category: _productViewModel.categoryModel,
              stockPiece: _stockPieceEditController.text.convertFromStringToDouble(),
              unitPrice: _unitPriceEditController.text.convertFromStringToDouble(),
              basePrice: _totalPriceEditController.text.convertFromStringToDouble(),
              photoPath: _productViewModel.productImageFilePath?.path ?? _productModel.photoPath,
              photoURL: _productModel.photoURL,
              stockEntryDate: DateTime.now(),
            );
            bool? result = await _productViewModel.update(productModel);

            if (mounted) {
              await _productViewModel.showDialogCustom(
                  context, result! ? 'Güncelleme başarılı' : 'Güncelleme başarısız', 'Bilgi', 'Tamam');

              _productViewModel.totalPrice = '0,00';
              if (mounted) Navigator.pop(context);
            }
          }
        }
      },
    );
  }

  void _buildPageClear() {
    _productViewModel.selectCategoryName = 'Tümü';
    _commentEditController.clear();
    _stockCodeEditController.clear();
    _photoPathEditController.clear();
    _stockPieceEditController.clear();
    _totalPriceEditController.clear();
    _productViewModel.productImageFilePath = null;
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
