import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
            .child(_productModel.photoPath!.substring(_productModel.photoPath!.lastIndexOf('/')));

        ref.putFile(File(_productModel.photoPath!));
        String url = await ref.getDownloadURL();

        return url;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
