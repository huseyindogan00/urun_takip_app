import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Future<bool> saveModel(BaseModel model) {
    // TODO: implement saveModel
    throw UnimplementedError();
  }

  @override
  Future<bool> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
