import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';

abstract class DbBase {
  Future<ResultMessageModel?> add(BaseModel model);
  Future<bool?> update(BaseModel model);
  Future<bool?> delete(BaseModel productId);
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName);
  //Future<List<BaseModel>> fetchProductByCategory(String categoryName);
}
