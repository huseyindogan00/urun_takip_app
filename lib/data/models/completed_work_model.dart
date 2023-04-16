// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base/base_work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class CompletedWorkModel implements BaseWorkModel {
  @override
  String? id;

  @override
  String? personID;

  @override
  String? companyName; // FİRMA ADI

  @override
  ProductModel productModel; // ÜRÜN

  @override
  double KDV;

  @override
  double totalPrice; // TOPLAM NET TUTAR

  @override
  String businessCase; // İŞ DURUMU

  @override
  String shippingPlace; // KARGO YERİ - ŞEHİR İÇİ/DIŞI

  @override
  dynamic workDate; // OLUŞTURULMA ZAMANI
  CompletedWorkModel({
    this.id,
    this.personID,
    this.companyName,
    required this.productModel,
    required this.KDV,
    required this.totalPrice,
    required this.businessCase,
    required this.shippingPlace,
    required this.workDate,
  });

  CompletedWorkModel copyWith({
    String? id,
    String? personID,
    String? companyName,
    ProductModel? productModel,
    double? KDV,
    double? totalPrice,
    String? businessCase,
    String? shippingPlace,
    dynamic? workDate,
  }) {
    return CompletedWorkModel(
      id: id ?? this.id,
      personID: personID ?? this.personID,
      companyName: companyName ?? this.companyName,
      productModel: productModel ?? this.productModel,
      KDV: KDV ?? this.KDV,
      totalPrice: totalPrice ?? this.totalPrice,
      businessCase: businessCase ?? this.businessCase,
      shippingPlace: shippingPlace ?? this.shippingPlace,
      workDate: workDate ?? this.workDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personID': personID,
      'companyName': companyName,
      'productModel': productModel.toMap(),
      'KDV': KDV,
      'totalPrice': totalPrice,
      'businessCase': businessCase,
      'shippingPlace': shippingPlace,
      'workDate': workDate,
    };
  }

  factory CompletedWorkModel.fromMap(Map<String, dynamic> map) {
    return CompletedWorkModel(
      id: map['id'] != null ? map['id'] as String : null,
      personID: map['personID'] != null ? map['personID'] as String : null,
      companyName: map['companyName'] != null ? map['companyName'] as String : null,
      productModel: ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      KDV: map['KDV'] as double,
      totalPrice: map['totalPrice'] as double,
      businessCase: map['businessCase'] as String,
      shippingPlace: map['shippingPlace'] as String,
      workDate: map['workDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompletedWorkModel.fromJson(String source) =>
      CompletedWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompletedWorkModel(id: $id, personID: $personID, companyName: $companyName, productModel: $productModel, KDV: $KDV, totalPrice: $totalPrice, businessCase: $businessCase, shippingPlace: $shippingPlace, workDate: $workDate)';
  }

  @override
  bool operator ==(covariant CompletedWorkModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personID == personID &&
        other.companyName == companyName &&
        other.productModel == productModel &&
        other.KDV == KDV &&
        other.totalPrice == totalPrice &&
        other.businessCase == businessCase &&
        other.shippingPlace == shippingPlace &&
        other.workDate == workDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personID.hashCode ^
        companyName.hashCode ^
        productModel.hashCode ^
        KDV.hashCode ^
        totalPrice.hashCode ^
        businessCase.hashCode ^
        shippingPlace.hashCode ^
        workDate.hashCode;
  }
}
