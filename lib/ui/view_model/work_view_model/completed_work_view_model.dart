import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/repository/repository.dart';

class CompletedWorkViewModel extends ChangeNotifier implements DbBase {
  final _repository = locator<ProductRepository>();
  @override
  Future<ResultMessageModel?> add(BaseModel model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool?> delete(BaseModel product) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) async {
    return await _repository.fetchAll(collectionName);
  }

  @override
  Future<bool?> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}