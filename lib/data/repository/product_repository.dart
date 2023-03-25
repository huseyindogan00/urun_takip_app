// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/service/firebase_storage_service.dart';
import 'package:urun_takip_app/data/service/firestore_db_service.dart';

class ProductRepository extends DbBase {
  final FirestoreDbService _firestoreDbService = FirestoreDbService();
  final FirebaseStorageServise _firebaseStorageServise = FirebaseStorageServise();
  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<BaseModel>> fetchModel() {
    // TODO: implement fetchModel
    throw UnimplementedError();
  }

  @override
  Future<bool> addModel(BaseModel model) async {
    String? _photoURL;
    ProductModel? _productModel = (model is ProductModel) ? model : null;
    if (_productModel != null) {
      _photoURL = await _firebaseStorageServise.uploadFile(_productModel);
      _productModel.photoURL = _photoURL;
      return await _firestoreDbService.addModel(_productModel);
    } else {
      return false;
    }
  }

  @override
  Future<bool> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Stream<List<ProductModel>> fetchProductAll() {
    return _firestoreDbService.fetchProductAll();
  }
}
