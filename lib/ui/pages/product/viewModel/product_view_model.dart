import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/calculation_operations.dart';
import 'package:urun_takip_app/core/utility/util/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/image_and_video_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';

class ProductViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final CategoryModel categoryModel = CategoryModel();
  String totalPrice = '0,00';
  XFile? productImageFile;

  //! BURADA İŞLEMLER REPOSİTORYDEN ÇAĞRILACAK. ŞUANLIK MANAGER SINIFI KULLANILIYOR
  Future<void> getPhotoFromGallery() async {
    XFile? xFile = await ImageAndVideoManager().getPhotoFromGallery();
    if (xFile == null) {
      return;
    }
    productImageFile = xFile;
    notifyListeners();
  }

  //* HESAPLAMA YAPAR VE GERİYE DEĞERİ STRİNG OLARAK DÖNER
  String? calculateNetPrice(String unitPrice, String kdv, String stockPiece) {
    //* eğer gönderilen birimfiyat veya stok adedi boş ise işlem yapma
    if (unitPrice.isEmpty || stockPiece.isEmpty) {
      totalPrice = '0,00';
      notifyListeners();
    } else if (Validation.moneyValueCheck(unitPrice) == null &&
        Validation.generealValidation(stockPiece) == null &&
        (unitPrice.contains(RegExp(',')) || unitPrice.contains(RegExp('.'))) &&
        !unitPrice.contains(RegExp('[a-zA-Z]'))) {
      //* Verilen birim fiyatı  doubleFromString ile noktasız yapıyor ve virgül var ise yerine nokta getiriyor ve double değere dönüştürüyor
      double _unitPrice = double.parse(unitPrice.doubleFromString().replaceAll(',', '.'));
      double _kdv = double.parse(kdv.replaceAll(',', '.'));
      double _stockPiece = double.parse(stockPiece);

      double resultDouble = CalculationOperations.calculateNetPrice(_unitPrice, _stockPiece, _kdv);

      String resultString = CurrencyFormatter.instance().moneyValueCheck(resultDouble.toString().replaceAll('.', ','));

      totalPrice = resultString;
      notifyListeners();
    }
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
