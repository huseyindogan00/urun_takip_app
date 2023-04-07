import 'package:get_it/get_it.dart';
import 'package:urun_takip_app/core/utility/util/manager/uuid_manager.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/data/repository/repository.dart';
import 'package:urun_takip_app/data/service/firebase_storage_service.dart';
import 'package:urun_takip_app/data/service/product_db_service.dart';
import 'package:urun_takip_app/data/service/work_firestore_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ProductRepository());
  locator.registerLazySingleton(() => CategoryRepository());
  locator.registerLazySingleton(() => FirebaseStorageServise());
  locator.registerLazySingleton(() => ProductDBService());
  locator.registerLazySingleton(() => WorkDBService());
  locator.registerLazySingleton(() => UuidManager());
}
