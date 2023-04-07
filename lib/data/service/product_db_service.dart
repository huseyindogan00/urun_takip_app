import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class ProductDBService extends DbBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool?> delete(String productId) async {
    await _firebaseFirestore
        .collection(DBCollectionName.products.name)
        .doc(productId)
        .delete();
    return true;
  }

  @override
  Future<bool> add(BaseModel model) async {
    if (model is ProductModel) {
      await _firebaseFirestore
          .collection(DBCollectionName.products.name)
          .doc(model.id)
          .set(model.toMap());
      return true;
    }
    return false;
  }

  @override
  Future<bool> update(BaseModel model) async {
    if (model is ProductModel) {
      await _firebaseFirestore
          .collection(DBCollectionName.products.name)
          .doc(model.id)
          .update(model.toMap());
      return true;
    }
    return false;
  }

  Future<List<BaseModel>> fetchProductByCategory(String categoryName) async {
    List<ProductModel> _productList = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(DBCollectionName.products.name)
        .where('category.categoryName', isEqualTo: categoryName)
        .get();

    for (var element in snapshot.docs) {
      _productList.add(ProductModel.fromMap(element.data()));
    }

    return _productList;
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) async {
    List<ProductModel> _productModel = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(collectionName.name)
        .orderBy(DBFilterName.stockEntryDate.name, descending: true)
        .get();
    for (var element in snapshot.docs) {
      _productModel.add(ProductModel.fromMap(element.data()));
    }
    return _productModel;
  }
}
