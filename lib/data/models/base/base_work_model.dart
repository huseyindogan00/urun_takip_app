// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

abstract class BaseWorkModel implements BaseModel {
  String? personID;
  String? companyName; // FİRMA ADI
  late ProductModel productModel; // ÜRÜN
  //late double productPiece; // ÜRÜN ADEDİ
  late double KDV;
  late double totalPrice; // TOPLAM TUTAR
  late String shippingPlace; // GÖNDERİM YERİ
  late String businessCase; // İŞ DURUMU
  dynamic workDate; // İŞ TARİHİ
}
