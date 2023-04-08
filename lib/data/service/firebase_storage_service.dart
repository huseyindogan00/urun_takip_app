import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/data/base/storage_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/data/models/person_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';

class FirebaseStorageServise extends StorageBase {
  final _firebaseStorageRef = FirebaseStorage.instance.ref();

  @override
  Future<String?> uploadFile(BaseModel? model) async {
    if (model != null) {
      if (model is ProductModel) {
        try {
          final ref = _firebaseStorageRef
              .child('${model.id!}/productPhoto/${model.photoPath.toString().createPhotoName(model.id.toString())}');

          TaskSnapshot taskSnapshot = await ref.putFile(File(model.photoPath!));

          /*  Reference ref = _firebaseStorage
              .ref()
              .child(model.id!)
              .child('productPhoto')
              .child(model.photoPath.toString().createPhotoName(model.id.toString()));
          TaskSnapshot taskSnapshot = await ref.putFile(File(model.photoPath!)); */
          String url = await taskSnapshot.ref.getDownloadURL();
          return url;
        } catch (e) {
          print(e);
        }
      } else if (model is PersonModel) {
      } else if (model is CompletedWorkModel) {
      } else if (model is WorkInProgressModel) {}
    }
    return null;
  }

  @override
  Future<void> deleteFile(String productID, String fileExtension) async {
    try {
      //var ref = await _firebaseStorage.ref().child('$productId/productPhoto/$productId.jpeg').delete();
      var ref = _firebaseStorageRef.child('$productID/productPhoto/$productID.$fileExtension');

      ref.delete();
    } catch (_) {}
  }
}
