// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class WorkModel implements BaseModel {
  @override
  String? id; //iş ID
  String? personID;
  String? companyName; // FİRMA ADI
  ProductModel productModel; // ÜRÜN
  double productPiece; // ÜRÜN ADEDİ
  double KDV;
  double totalPrice; // TOPLAM TUTAR
  String shippingPlace; // GÖNDERİM YERİ
  String businessCase; // İŞ DURUMU

  dynamic workDate; // İŞ TARİHİ
  WorkModel({
    this.id,
    this.personID,
    this.companyName,
    required this.productModel,
    required this.productPiece,
    required this.KDV,
    required this.totalPrice,
    required this.shippingPlace,
    required this.businessCase,
    required this.workDate,
  });

  WorkModel copyWith({
    String? id,
    String? personID,
    String? companyName,
    ProductModel? productModel,
    double? productPiece,
    double? KDV,
    double? totalPrice,
    String? shippingPlace,
    String? businessCase,
    dynamic? workDate,
  }) {
    return WorkModel(
      id: id ?? this.id,
      personID: personID ?? this.personID,
      companyName: companyName ?? this.companyName,
      productModel: productModel ?? this.productModel,
      productPiece: productPiece ?? this.productPiece,
      KDV: KDV ?? this.KDV,
      totalPrice: totalPrice ?? this.totalPrice,
      shippingPlace: shippingPlace ?? this.shippingPlace,
      businessCase: businessCase ?? this.businessCase,
      workDate: workDate ?? this.workDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personID': personID,
      'companyName': companyName,
      'productModel': productModel.toMap(),
      'productPiece': productPiece,
      'KDV': KDV,
      'totalPrice': totalPrice,
      'shippingPlace': shippingPlace,
      'businessCase': businessCase,
      'workDate': workDate,
    };
  }

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'] != null ? map['id'] as String : null,
      personID: map['personID'] != null ? map['personID'] as String : null,
      companyName: map['companyName'] != null ? map['companyName'] as String : null,
      productModel: ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      productPiece: map['productPiece'] as double,
      KDV: map['KDV'] as double,
      totalPrice: map['totalPrice'] as double,
      shippingPlace: map['shippingPlace'] as String,
      businessCase: map['businessCase'] as String,
      workDate: map['workDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkModel.fromJson(String source) => WorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkModel(id: $id, personID: $personID, companyName: $companyName, productModel: $productModel, productPiece: $productPiece, KDV: $KDV, totalPrice: $totalPrice, shippingPlace: $shippingPlace, businessCase: $businessCase, workDate: $workDate)';
  }

  @override
  bool operator ==(covariant WorkModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personID == personID &&
        other.companyName == companyName &&
        other.productModel == productModel &&
        other.productPiece == productPiece &&
        other.KDV == KDV &&
        other.totalPrice == totalPrice &&
        other.shippingPlace == shippingPlace &&
        other.businessCase == businessCase &&
        other.workDate == workDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personID.hashCode ^
        companyName.hashCode ^
        productModel.hashCode ^
        productPiece.hashCode ^
        KDV.hashCode ^
        totalPrice.hashCode ^
        shippingPlace.hashCode ^
        businessCase.hashCode ^
        workDate.hashCode;
  }
}

enum ShippingPlace { UPSTATE, LOCAL }

enum BusinessCase { COMPLATED, CONTINUES }
