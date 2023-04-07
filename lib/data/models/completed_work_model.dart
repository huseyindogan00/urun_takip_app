// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base/work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class CompletedWorkModel implements WorkBaseModel {
  @override
  String? id;

  @override
  String? personID;

  @override
  String? companyName; // FİRMA ADI

  @override
  ProductModel productModel; // ÜRÜN

  @override
  double productPiece; // ÜRÜN ADEDİ

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
    required this.KDV,
    required this.businessCase,
    this.companyName,
    this.id,
    this.personID,
    required this.productModel,
    required this.productPiece,
    required this.shippingPlace,
    required this.totalPrice,
    required this.workDate,
  });

  CompletedWorkModel copyWith({
    double? KDV,
    String? businessCase,
    String? companyName,
    String? id,
    String? personID,
    ProductModel? productModel,
    double? productPiece,
    String? shippingPlace,
    double? totalPrice,
    dynamic? workDate,
  }) {
    return CompletedWorkModel(
      KDV: KDV ?? this.KDV,
      businessCase: businessCase ?? this.businessCase,
      companyName: companyName ?? this.companyName,
      id: id ?? this.id,
      personID: personID ?? this.personID,
      productModel: productModel ?? this.productModel,
      productPiece: productPiece ?? this.productPiece,
      shippingPlace: shippingPlace ?? this.shippingPlace,
      totalPrice: totalPrice ?? this.totalPrice,
      workDate: workDate ?? this.workDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'KDV': KDV,
      'businessCase': businessCase,
      'companyName': companyName,
      'id': id,
      'personID': personID,
      'productModel': productModel.toMap(),
      'productPiece': productPiece,
      'shippingPlace': shippingPlace,
      'totalPrice': totalPrice,
      'workDate': workDate,
    };
  }

  factory CompletedWorkModel.fromMap(Map<String, dynamic> map) {
    return CompletedWorkModel(
      KDV: map['KDV'] as double,
      businessCase: map['businessCase'] as String,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      personID: map['personID'] != null ? map['personID'] as String : null,
      productModel:
          ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      productPiece: map['productPiece'] as double,
      shippingPlace: map['shippingPlace'] as String,
      totalPrice: map['totalPrice'] as double,
      workDate: map['workDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompletedWorkModel.fromJson(String source) =>
      CompletedWorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompletedWorkModel(KDV: $KDV, businessCase: $businessCase, companyName: $companyName, id: $id, personID: $personID, productModel: $productModel, productPiece: $productPiece, shippingPlace: $shippingPlace, totalPrice: $totalPrice, workDate: $workDate)';
  }

  @override
  bool operator ==(covariant CompletedWorkModel other) {
    if (identical(this, other)) return true;

    return other.KDV == KDV &&
        other.businessCase == businessCase &&
        other.companyName == companyName &&
        other.id == id &&
        other.personID == personID &&
        other.productModel == productModel &&
        other.productPiece == productPiece &&
        other.shippingPlace == shippingPlace &&
        other.totalPrice == totalPrice &&
        other.workDate == workDate;
  }

  @override
  int get hashCode {
    return KDV.hashCode ^
        businessCase.hashCode ^
        companyName.hashCode ^
        id.hashCode ^
        personID.hashCode ^
        productModel.hashCode ^
        productPiece.hashCode ^
        shippingPlace.hashCode ^
        totalPrice.hashCode ^
        workDate.hashCode;
  }
}
