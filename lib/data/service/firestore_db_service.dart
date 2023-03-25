import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class FirestoreDbService extends DbBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
    ProductModel? _productModel = model is ProductModel ? model : null;

    if (_productModel != null) {
      await _firebaseFirestore
          .collection(DbCollectionName.products.name)
          .doc(_productModel.id)
          .set(_productModel.toMap());
      return true;
    }
    return false;
  }

  @override
  Future<bool> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Stream<List<ProductModel>> fetchProductAll() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = _firebaseFirestore.collection('products').snapshots();

    Stream<List<ProductModel>> modelList =
        snapshot.map((event) => event.docs.map((e) => ProductModel.fromMap(e.data())).toList());

    return modelList;
  }
}

enum DbCollectionName { products, categories, tokens, works }
