import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';

abstract class DbBase {
  Future<bool?> add(BaseModel model);
  Future<bool?> update(BaseModel model);
  Future<bool?> delete(String productId);
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName);
  //Future<List<BaseModel>> fetchProductByCategory(String categoryName);
}
