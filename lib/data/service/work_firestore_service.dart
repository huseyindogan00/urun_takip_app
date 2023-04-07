import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';

class WorkDBService implements DbBase {
  @override
  Future<bool?> add(BaseModel model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool?> delete(String productId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<bool?> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
