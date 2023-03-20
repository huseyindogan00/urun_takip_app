import 'package:urun_takip_app/data/models/base_model.dart';

abstract class StorageBase {
  Future<String?> uploadFile(BaseModel? model);
}
