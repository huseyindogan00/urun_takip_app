import 'package:urun_takip_app/data/models/base_model.dart';

abstract class DbBase {
  Future<bool?> addModel(BaseModel model);
  Future<bool?> update(BaseModel model);
  Future<bool?> delete(String productId);
  Future<List<BaseModel>> fetchProductByCategory(String categoryName);
  Future<List<BaseModel>> fetchProductAll();
}
