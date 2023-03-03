import 'package:urun_takip_app/data/repository/category_repository.dart';

class ProductViewModel {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<String> fetchCategoryNameList() {
    return _categoryRepository.fetchCategoryNameList();
  }
}
