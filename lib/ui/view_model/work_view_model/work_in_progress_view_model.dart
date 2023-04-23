import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/repository/product_repository.dart';
import 'package:urun_takip_app/ui/view_model/base_view_model.dart';

class WorkInProgressViewModel extends ChangeNotifier implements IBaseViewModel {
  final _repository = locator<ProductRepository>();

  @override
  Future<ResultMessageModel?> add(BaseModel model) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool?> delete(BaseModel product) async {
    bool result = await _repository.delete(product);

    print('silme işlemi sonucu $result');
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) async {
    return await _repository.fetchAll(collectionName);
  }

  @override
  Future<bool?> update(BaseModel model) async {
    await _repository.update(model);
  }

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Future<bool?> showDialogCustom(BuildContext context, String content, String title, String doneButtonTitle) {
    // TODO: implement showDialogCustom
    throw UnimplementedError();
  }
}
