import 'package:flutter/foundation.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';

class DoWorkViewModel extends ChangeNotifier {
  String _selectBusinessCase = BusinessCaseText.completed;

  String get selectBusinessCase => _selectBusinessCase;

  set selectBusinessCase(String value) {
    _selectBusinessCase = value;
  }

  String _selectShippingPlace = ShippingPlaceText.local;

  String get selectShippingPlace => _selectShippingPlace;

  set selectShippingPlace(String value) {
    _selectShippingPlace = value;
  }

  String _totalPiece = '0,00';

  String get totalPiece => _totalPiece;

  set totalPiece(String value) {
    _totalPiece = value;
  }

  String _kdv = '';

  String get kdv => _kdv;

  set kdv(String value) {
    _kdv = value;
  }
}
