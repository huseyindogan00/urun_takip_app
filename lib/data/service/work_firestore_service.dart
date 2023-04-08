import 'package:flutter/src/widgets/framework.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';

class WorkDBService implements DbBase {
  @override
  Future<ResultMessageModel?> add(BaseModel model, {BuildContext? context}) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool?> delete(BaseModel product) {
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
