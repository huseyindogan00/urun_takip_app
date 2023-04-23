// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';
import 'package:urun_takip_app/data/service/firebase_storage_service.dart';
import 'package:urun_takip_app/data/service/product_db_service.dart';
import 'package:urun_takip_app/data/service/work_firestore_service.dart';

class ProductRepository extends DbBase {
  final ProductDBService _productDbService = locator<ProductDBService>();
  final WorkDBService _workDbService = locator<WorkDBService>();
  final FirebaseStorageServise _firebaseStorageServise = FirebaseStorageServise();

  late ProductModel? _productModel;
  late CompletedWorkModel? _completedWorkModel;
  late WorkInProgressModel? _workInProgressModel;
  @override
  Future<bool> delete(BaseModel product) async {
    if (product is ProductModel) {
      if (product.photoURL != null) {
        await _firebaseStorageServise.deleteFile(product.id!, product.photoPath!.split('.').last);
      }
      await _productDbService.delete(product);
    } else if (product is WorkInProgressModel) {
      bool? result = await _workDbService.delete(product);
      return result!;
    } else if (product is CompletedWorkModel) {
      bool? result = await _workDbService.delete(product);
      return result!;
    }

    return true;
  }

  @override
  Future<ResultMessageModel> add(BaseModel model) async {
    late String? _photoURL;
    ResultMessageModel resultMessage = ResultMessageModel(isSuccessful: false);

    if (model is ProductModel) {
      _productModel = model;
      resultMessage = await _productDbService.stockControl(_productModel!.stockCode!);
      if (resultMessage.isSuccessful) {
        _photoURL = await _firebaseStorageServise.uploadFile(_productModel);
        _productModel!.photoURL = _photoURL;
        resultMessage = await _productDbService.add(_productModel!);
      }
      return resultMessage;
    } else if (model is CompletedWorkModel) {
      _completedWorkModel = model;
      resultMessage = await _productDbService.add(_completedWorkModel!);
      return resultMessage;
    } else if (model is WorkInProgressModel) {
      _workInProgressModel = model;
      resultMessage = await _productDbService.add(_workInProgressModel!);
      return resultMessage;
    } else {
      resultMessage.isSuccessful = false;
    }
    return resultMessage;
  }

  @override
  Future<bool> update(BaseModel model) async {
    String? _photoURL;
    bool? result;

    if (model is ProductModel) {
      _productModel = model;
      _photoURL = await _firebaseStorageServise.uploadFile(_productModel);
      _productModel!.photoURL = _photoURL ?? '';
      result = await _productDbService.update(_productModel!);
    } else if (model is CompletedWorkModel) {
      _completedWorkModel = model;
      await _workDbService.delete(model);
      result = await _workDbService.update(_completedWorkModel!);
    } else if (model is WorkInProgressModel) {
      _workInProgressModel = model;
      await _workDbService.delete(model);
      result = await _workDbService.update(_workInProgressModel!);
    } else {
      result = false;
    }
    return result!;
  }

  Future<List<BaseModel>> fetchProductByCategory(String categoryName) {
    return _productDbService.fetchProductByCategory(categoryName);
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) async {
    switch (collectionName) {
      case DBCollectionName.products:
        return await _productDbService.fetchAll(collectionName);
      case DBCollectionName.completedWorks:
        return await _workDbService.fetchAll(collectionName);
      case DBCollectionName.worksInProgress:
        return await _workDbService.fetchAll(collectionName);

      default:
    }
    return <BaseModel>[];
  }
}
