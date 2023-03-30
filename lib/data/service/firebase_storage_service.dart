import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/data/base/storage_base.dart';
import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class FirebaseStorageServise extends StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String?> uploadFile(BaseModel? model) async {
    ProductModel? _productModel = (model is ProductModel) ? model : null;
    try {
      if (_productModel != null) {
        Reference ref = _firebaseStorage
            .ref()
            .child(_productModel.id!)
            .child('productPhoto')
            .child(_productModel.photoPath.toString().createPhotoName(_productModel.id.toString()));

        TaskSnapshot taskSnapshot = await ref.putFile(File(_productModel.photoPath!));
        String url = await taskSnapshot.ref.getDownloadURL();

        return url;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> deleteFile(String productId) async {
    try {
      var ref = await _firebaseStorage.ref().child(productId).child('productPhoto').child('$productId.jpeg').delete();

      return ref;
    } catch (_) {}
  }
}
