// ignore_for_file: unnecessary_this

import 'package:urun_takip_app/data/models/base_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';

extension StringExtension on String {
  /// String değeri double.parse ile kullanılacak duruma getiriyor.
  /// noktaları siliyor
  String doubleFromString() {
    String newValue = '';
    List<String> value = this.split('');

    do {
      value.remove('.');
    } while (value.contains('.'));

    for (var number in value) {
      newValue += number;
    }

    return newValue;
  }

  double convertFromStringToDouble() {
    List<String> valueList = this.split('');
    String value = '';

    while (valueList.contains('.')) {
      valueList.remove('.');
    }
    for (var element in valueList) {
      value += element;
    }
    return double.parse(value.replaceAll(',', '.'));
  }

  /// Verilen fotoğraf adres yolunda fotoğraf ismini id ile değiştirir
  String createPhotoName(String id) {
    return id + this.substring(this.lastIndexOf('.'));
  }
}
