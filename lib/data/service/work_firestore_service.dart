import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';

class WorkDBService implements DbBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ResultMessageModel?> add(BaseModel model, {BuildContext? context}) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool?> delete(BaseModel product) async {
    if (product is WorkInProgressModel) {
      await _firebaseFirestore.collection(DBCollectionName.worksInProgress.name).doc(product.id).delete();
      return true;
    } else if (product is CompletedWorkModel) {
      await _firebaseFirestore.collection(DBCollectionName.completedWorks.name).doc(product.id).delete();
      return true;
    }
    return false;
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) async {
    List<WorkInProgressModel>? _workInProgressModel;
    List<CompletedWorkModel>? _completedWorkModel;
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(collectionName.name)
        .orderBy(
            collectionName == DBCollectionName.products ? DBFilterName.stockEntryDate.name : DBFilterName.workDate.name,
            descending: true)
        .get();
    if (collectionName == DBCollectionName.worksInProgress) {
      _workInProgressModel = [];
      for (var element in snapshot.docs) {
        _workInProgressModel.add(WorkInProgressModel.fromMap(element.data()));
      }
    } else if (collectionName == DBCollectionName.completedWorks) {
      _completedWorkModel = [];
      for (var element in snapshot.docs) {
        _completedWorkModel.add(CompletedWorkModel.fromMap(element.data()));
      }
    } else {
      return [];
    }
    // ignore: prefer_if_null_operators
    return _workInProgressModel != null
        ? _workInProgressModel
        // ignore: prefer_if_null_operators
        : _completedWorkModel != null
            ? _completedWorkModel
            : [];
  }

  @override
  Future<bool?> update(BaseModel model) async {
    if (model is CompletedWorkModel) {
      await _firebaseFirestore.collection(DBCollectionName.worksInProgress.name).doc(model.id).set(model.toMap());
      return true;
    } else if (model is WorkInProgressModel) {
      await _firebaseFirestore.collection(DBCollectionName.completedWorks.name).doc(model.id).set(model.toMap());
      return true;
    }
  }
}
