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

  Future<List<ProductModel>> fetchProductAll(String categoryName) async {
    List<ProductModel> _productList = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('products').where('category.categoryName', isEqualTo: categoryName).get();

    for (var element in snapshot.docs) {
      _productList.add(ProductModel.fromMap(element.data()));
    }

    return _productList;
  }
}

enum DbCollectionName { products, categories, tokens, works }
