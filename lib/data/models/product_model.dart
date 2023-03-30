// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/category_model.dart';

class ProductModel implements BaseModel {
  @override
  String? id; // ÜRÜN ID
  String title; // AÇIKLAMA
  CategoryModel
      category; // Kategorisi Map<String,List<String>> formatında olacak. category['saat'][0] şeklinde alınacak
  String? stockCode; // STOK KODU
  double stockPiece; // STOK ADEDİ
  double unitPrice; // BİRİM FİYAT
  double kdv; // KDV
  double totalPrice; // TOPLAM TUTAR
  String? photoURL; // FOTOĞRAF URL ADRESİ
  String? photoPath;
  dynamic createDate; // OLUŞTURMA TARİHİ
  ProductModel({
    this.id,
    required this.title,
    required this.category,
    this.stockCode,
    required this.stockPiece,
    required this.unitPrice,
    required this.kdv,
    required this.totalPrice,
    this.photoURL,
    this.photoPath,
    required this.createDate,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    //? category,
    String? stockCode,
    double? stockPiece,
    double? unitPrice,
    double? kdv,
    double? totalPrice,
    String? photoURL,
    String? photoPath,
    dynamic createDate,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      stockCode: stockCode ?? this.stockCode,
      stockPiece: stockPiece ?? this.stockPiece,
      unitPrice: unitPrice ?? this.unitPrice,
      kdv: kdv ?? this.kdv,
      totalPrice: totalPrice ?? this.totalPrice,
      photoURL: photoURL ?? this.photoURL,
      photoPath: photoPath ?? this.photoPath,
      createDate: createDate ?? this.createDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category.toMap(),
      'stockCode': stockCode,
      'stockPiece': stockPiece,
      'unitPrice': unitPrice,
      'kdv': kdv,
      'totalPrice': totalPrice,
      'photoURL': photoURL,
      'photoPath': photoPath,
      'createDate': createDate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      category: CategoryModel.fromMap(map['category'] as Map<String, dynamic>),
      stockCode: map['stockCode'] != null ? map['stockCode'] as String : null,
      stockPiece: map['stockPiece'] as double,
      unitPrice: map['unitPrice'] as double,
      kdv: map['kdv'] as double,
      totalPrice: map['totalPrice'] as double,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      photoPath: map['photoPath'] != null ? map['photoPath'] as String : null,
      createDate: map['createDate'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, category: $category, stockCode: $stockCode, stockPiece: $stockPiece, unitPrice: $unitPrice, kdv: $kdv, totalPrice: $totalPrice, photoURL: $photoURL, photoPath: $photoPath, createDate: $createDate)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.category == category &&
        other.stockCode == stockCode &&
        other.stockPiece == stockPiece &&
        other.unitPrice == unitPrice &&
        other.kdv == kdv &&
        other.totalPrice == totalPrice &&
        other.photoURL == photoURL &&
        other.photoPath == photoPath &&
        other.createDate == createDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        category.hashCode ^
        stockCode.hashCode ^
        stockPiece.hashCode ^
        unitPrice.hashCode ^
        kdv.hashCode ^
        totalPrice.hashCode ^
        photoURL.hashCode ^
        photoPath.hashCode ^
        createDate.hashCode;
  }
}
