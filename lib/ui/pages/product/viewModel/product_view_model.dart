import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';
import 'package:urun_takip_app/models/product_model.dart';

class ProductViewModel extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();

  String? _selectCategoryName;
  List<String> categorySubName = [];

  String? get selectCategoryName => _selectCategoryName;

  set selectCategoryName(String? value) {
    _selectCategoryName = value;
    notifyListeners();
  }

  CategoryModel categoryModel = CategoryModel();

  void getCategorySubTitle(String title) {
    categorySubName = categoryAllMap[title]!;
    notifyListeners();
  }

  List<String> fetchCategoryNameList() {
    return _categoryRepository.fetchCategoryNameList();
  }
}
