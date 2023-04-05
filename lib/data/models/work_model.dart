// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

class WorkModel implements BaseModel {
  @override
  String? id; //iş ID
  String companyName; // FİRMA ADI
  ProductModel productModel; // ÜRÜN
  double productPiece; // ÜRÜN ADEDİ
  double totalPrice; // TOPLAM TUTAR
  bool isCargoStatus; // KARGO DURUMU
  String? cargoAddress; // KARGO ADRESİ
  dynamic orderDate; // SATIŞ TARİHİ
}
