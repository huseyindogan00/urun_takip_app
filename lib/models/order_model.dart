import 'dart:convert';
import 'package:urun_takip_app/models/product_model.dart';

class OrderModel {
  String orderId; // SATIŞ ID
  String companyName; // FİRMA ADI
  ProductModel productModel; // ÜRÜN
  double productPiece; // ÜRÜN ADEDİ
  double totalPrice; // TOPLAM TUTAR
  dynamic orderDate; // SATIŞ TARİHİ
  OrderModel({
    required this.orderId,
    required this.companyName,
    required this.productModel,
    required this.productPiece,
    required this.totalPrice,
    required this.orderDate,
  });

  OrderModel copyWith({
    String? orderId,
    String? companyName,
    ProductModel? productModel,
    double? productPiece,
    double? totalPrice,
    dynamic? orderDate,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      companyName: companyName ?? this.companyName,
      productModel: productModel ?? this.productModel,
      productPiece: productPiece ?? this.productPiece,
      totalPrice: totalPrice ?? this.totalPrice,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'companyName': companyName,
      'productModel': productModel.toMap(),
      'productPiece': productPiece,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      companyName: map['companyName'] as String,
      productModel:
          ProductModel.fromMap(map['productModel'] as Map<String, dynamic>),
      productPiece: map['productPiece'] as double,
      totalPrice: map['totalPrice'] as double,
      orderDate: map['orderDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, companyName: $companyName, productModel: $productModel, productPiece: $productPiece, totalPrice: $totalPrice, orderDate: $orderDate)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.companyName == companyName &&
        other.productModel == productModel &&
        other.productPiece == productPiece &&
        other.totalPrice == totalPrice &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        companyName.hashCode ^
        productModel.hashCode ^
        productPiece.hashCode ^
        totalPrice.hashCode ^
        orderDate.hashCode;
  }
}
