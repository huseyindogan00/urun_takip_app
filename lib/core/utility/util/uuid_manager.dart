import 'package:uuid/uuid.dart';

class UuidManager extends Uuid {
  /// uuid paketini kullanarak random bir id üretir
  String randomId() {
    return v4();
  }
}
