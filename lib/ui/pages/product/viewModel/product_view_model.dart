import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';

class ProductViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();

  // KATEGORİ LİSTESİNDEKİ BAŞLIKLAR
  String _selectCategoryName = categoryAllMap.keys.first;
  String? get selectCategoryName => _selectCategoryName;
  set selectCategoryName(String? value) {
    _selectCategoryName = value!;
    _selectCategorySubName = null; // ALT KATEGORİ VALUE DEĞERİ NULL YAPILIYOR
    categoryModel.categoryName = value;
    notifyListeners();
  }

  // KATEGORİ LİSTESİNDE ALT BAŞLIKLAR
  String? _selectCategorySubName;
  String? get selectCategorySubName => _selectCategorySubName;
  set selectCategorySubName(String? value) {
    _selectCategorySubName = value!;
    categoryModel.categorySubName = value;
    notifyListeners();
  }

  CategoryModel categoryModel = CategoryModel();

  List<String> fetchCategoryNameList() {
    return _categoryRepository.fetchCategoryNameList();
  }
}
