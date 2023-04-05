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
  double stockPiece; // STOK ADEDİ----------
  double unitPrice; // BİRİM FİYAT
  double kdv; // KDV-----------
  double totalPrice; // TOPLAM TUTAR---------
  String? photoURL; // FOTOĞRAF URL ADRESİ
  String? photoPath;
  dynamic createDate; // OLUŞTURMA TARİHİ--------
}
