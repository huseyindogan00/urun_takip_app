// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class WorkModel implements BaseModel {
  @override
  String? id; // SATIŞ ID
  String companyName; // FİRMA ADI
  ProductModel productModel; // ÜRÜN
  double productPiece; // ÜRÜN ADEDİ
  double totalPrice; // TOPLAM TUTAR
  dynamic orderDate; // SATIŞ TARİHİ
  WorkModel({
    this.id,
    required this.companyName,
    required this.productModel,
    required this.productPiece,
    required this.totalPrice,
    required this.orderDate,
  });

  WorkModel copyWith({
    String? id,
    String? companyName,
    ProductModel? productModel,
    double? productPiece,
    double? totalPrice,
    dynamic? orderDate,
  }) {
    return WorkModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      productModel: productModel ?? this.productModel,
      productPiece: productPiece ?? this.productPiece,
      totalPrice: totalPrice ?? this.totalPrice,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'productModel': productModel.toMap(),
      'productPiece': productPiece,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
    };
  }

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      id: map['id'] != null ? map['id'] as String : null,
      companyName: map['companyName'] as String,
      productModel:
          ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      productPiece: map['productPiece'] as double,
      totalPrice: map['totalPrice'] as double,
      orderDate: map['orderDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkModel.fromJson(String source) =>
      WorkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkModel(id: $id, companyName: $companyName, productModel: $productModel, productPiece: $productPiece, totalPrice: $totalPrice, orderDate: $orderDate)';
  }

  @override
  bool operator ==(covariant WorkModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.productModel == productModel &&
        other.productPiece == productPiece &&
        other.totalPrice == totalPrice &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        productModel.hashCode ^
        productPiece.hashCode ^
        totalPrice.hashCode ^
        orderDate.hashCode;
  }
}
