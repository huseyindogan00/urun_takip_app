import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/calculation_operations.dart';
import 'package:urun_takip_app/core/utility/util/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/image_and_video_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/repository/product_repository.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
import 'package:urun_takip_app/data/models/category_model.dart';

class ProductViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = locator<CategoryRepository>();
  final ProductRepository _productRepository = locator<ProductRepository>();
  late CategoryModel categoryModel = CategoryModel();

  String totalPrice = '0,00';
  XFile? productImageFilePath;

  static List<ProductModel> productList = [];

  Stream<List<ProductModel>> fetchProductAll() {
    return _productRepository.fetchProductAll();
  }

  //! BURADA İŞLEMLER REPOSİTORYDEN ÇAĞRILACAK. ŞUANLIK MANAGER SINIFI KULLANILIYOR
  Future<bool?> getPhotoFromGallery(BuildContext context) async {
    try {
      XFile? xFile = await ImageAndVideoManager().getPhotoFromGallery();
      if (xFile == null) {
        return false;
      }
      productImageFilePath = xFile;

      notifyListeners();
    } on PlatformException catch (error) {
      bool? result = await PlatformSensitiveAlertDialog(
        content: error.message.toString(),
        title: 'Fotoğraf seçerken hata oluştu',
        doneButtonTitle: 'Tamam',
      ).show(context);
      return result;
    }
    return true;
  }

  //! BURADA İŞLEMLER REPOSİTORYDEN ÇAĞRILACAK. ŞUANLIK MANAGER SINIFI KULLANILIYOR
  Future<bool?> getPhotoFromCamera(BuildContext context) async {
    try {
      XFile? xFile = await ImageAndVideoManager().getPhotoFromCamera();
      if (xFile == null) {
        return false;
      }
      productImageFilePath = xFile;

      notifyListeners();
    } on PlatformException catch (error) {
      bool? result = await PlatformSensitiveAlertDialog(
        content: error.message.toString(),
        title: 'Fotoğraf seçerken hata oluştu',
        doneButtonTitle: 'Tamam',
      ).show(context);
      return result;
    }
    return true;
  }

  //* PRODUCT EKLEME METHODU
  Future<void> addProductModel(ProductModel productModel) async {
    try {
      bool result = await _productRepository.addModel(productModel);
      print('ürün ekleme işlemi -> $result');
    } on Exception catch (e) {
      print(e.toString());
    } finally {}
  }

  //* HESAPLAMA YAPAR VE GERİYE DEĞERİ STRİNG OLARAK DÖNER
  String? calculateNetPrice(String unitPrice, String kdv, String stockPiece) {
    //* eğer gönderilen birimfiyat veya stok adedi boş ise işlem yapma
    if (unitPrice.isEmpty || stockPiece.isEmpty || kdv.isEmpty) {
      totalPrice = '0,00';
      notifyListeners();
    } else if (Validation.moneyValueCheck(unitPrice) == null &&
        Validation.generealValidation(stockPiece) == null &&
        (unitPrice.contains(RegExp(',')) || unitPrice.contains(RegExp('.'))) &&
        !unitPrice.contains(RegExp('[a-zA-Z]'))) {
      //* Verilen birim fiyatı  doubleFromString ile noktasız yapıyor ve virgül var ise yerine nokta getiriyor ve double değere dönüştürüyor
      double _unitPrice = double.parse(unitPrice.doubleFromString().replaceAll(',', '.'));
      double _kdv = double.parse(kdv) / 100;
      double _stockPiece = double.parse(stockPiece);

      double resultDouble = CalculationOperations.calculateNetPrice(_unitPrice, _stockPiece, _kdv);

      String resultString = CurrencyFormatter.instance().moneyValueCheck(resultDouble.toString().replaceAll('.', ','));

      totalPrice = resultString;
      notifyListeners();
    }
    return null;
  }

  //* KATEGORİ LİSTESİNDEKİ BAŞLIKLAR
  String _selectCategoryName = categoryAllMap.keys.first;
  String? get selectCategoryName => _selectCategoryName;
  set selectCategoryName(String? value) {
    _selectCategoryName = value!;
    _selectCategorySubName = null; // ALT KATEGORİ VALUE DEĞERİ NULL YAPILIYOR
    categoryModel.categoryName = value;
    notifyListeners();
  }

  //* KATEGORİ LİSTESİNDE ALT BAŞLIKLAR
  String? _selectCategorySubName;
  String? get selectCategorySubName => _selectCategorySubName;
  set selectCategorySubName(String? value) {
    _selectCategorySubName = value!;
    categoryModel.categorySubName = value;
    notifyListeners();
  }

  //* KATEGORİLERİ VERİTABANINDAN VEYA LOCALDEN GETİRİR
  List<String> fetchCategoryNameList() {
    return _categoryRepository.fetchCategoryNameList();
  }
}
