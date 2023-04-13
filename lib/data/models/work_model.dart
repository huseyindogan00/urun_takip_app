// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class WorkModel implements BaseWorkModel {
  @override
  double KDV;

  @override
  BusinessCase businessCase;

  @override
  String? companyName;

  @override
  String? id;

  @override
  String? personID;

  @override
  ProductModel productModel;

  @override
  double productPiece;

  @override
  ShippingPlace shippingPlace;

  @override
  double totalPrice;

  @override
  dynamic workDate;
  WorkModel({
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

  WorkModel copyWith({
    double? KDV,
    BusinessCase? businessCase,
    String? companyName,
    String? id,
    String? personID,
    ProductModel? productModel,
    double? productPiece,
    ShippingPlace? shippingPlace,
    double? totalPrice,
    dynamic? workDate,
  }) {
    return WorkModel(
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

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      KDV: map['KDV'] as double,
      businessCase: map['businessCase'] as BusinessCase,
      companyName: map['companyName'] != null ? map['companyName'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      personID: map['personID'] != null ? map['personID'] as String : null,
      productModel: ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      productPiece: map['productPiece'] as double,
      shippingPlace: map['shippingPlace'] as ShippingPlace,
      totalPrice: map['totalPrice'] as double,
      workDate: map['workDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkModel.fromJson(String source) => WorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkModel(KDV: $KDV, businessCase: $businessCase, companyName: $companyName, id: $id, personID: $personID, productModel: $productModel, productPiece: $productPiece, shippingPlace: $shippingPlace, totalPrice: $totalPrice, workDate: $workDate)';
  }

  @override
  bool operator ==(covariant WorkModel other) {
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
