import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/models/category_model.dart';

class CategoryRepository {
  /// KATEGORİLERİN ANA BAŞLIKLARINI SERVİSTEN VEYA TELEFON HAFIZASINDAN GETİRİR
  List<String> fetchCategoryNameList() {
    List<String> categoryNameList = [];

    categoryNameList = categoryAllMap.keys.toList();

    return categoryNameList;
  }

  /// KATEGORİLERİ VERİLEN ANA BAŞLIK ADINA GÖRE CATEGORY MODEL OLARAK GETİRİR
  List<String> fetchCategoryModel(String categoryName) {
    List<String> _categoryModelList = [];

    for (var key in categoryAllMap.keys) {
      if (key == categoryName) {
        _categoryModelList = categoryAllMap[categoryName]!;
        return _categoryModelList;
      }
    }
    return [];
  }
}
