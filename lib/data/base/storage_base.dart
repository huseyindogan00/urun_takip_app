import 'package:urun_takip_app/data/models/base/base_model.dart';

abstract class StorageBase {
  Future<String?> uploadFile(BaseModel? model);
  Future<void> deleteFile(String productId, String fileExtension);
}
