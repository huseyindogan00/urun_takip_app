import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';

class ProductDBService extends DbBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool?> delete(BaseModel product) async {
    await _firebaseFirestore.collection(DBCollectionName.products.name).doc(product.id).delete();
    return true;
  }

  @override
  Future<ResultMessageModel> add(BaseModel model) async {
    if (model is ProductModel) {
      await _firebaseFirestore.collection(DBCollectionName.products.name).doc(model.id).set(model.toMap());
      return ResultMessageModel(isSuccessful: true, message: 'Ürün Eklendi');
    }
    return ResultMessageModel(isSuccessful: false);
  }

  @override
  Future<bool> update(BaseModel model) async {
    if (model is ProductModel) {
      await _firebaseFirestore.collection(DBCollectionName.products.name).doc(model.id).update(model.toMap());
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

  Future<ResultMessageModel> stockControl(String stockCode) async {
    QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore
        .collection(DBCollectionName.products.name)
        .where('stockCode', isEqualTo: stockCode)
        .get();
    return result.size > 0
        ? ResultMessageModel(isSuccessful: false, message: 'Stok numarası var')
        : ResultMessageModel(isSuccessful: true, message: 'Stok numarası yok');
  }
}
