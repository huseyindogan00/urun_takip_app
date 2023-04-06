// ignore_for_file: unnecessary_this

class CurrencyFormatter {
  CurrencyFormatter._private();

  static final CurrencyFormatter _instance = CurrencyFormatter._private();

  factory CurrencyFormatter.instance() {
    return _instance;
  }

  /// Kullanıcıdan alınan String tipindeki TR para biriminin nokta ve virgüllerini
  /// ayırarak tekrar hesaplar ve String tipinde değeri döndürür.
  ///
  /// Örneğin:
  ///
  /// String value = '123456'
  /// var result = moneyValueCheck(value);
  /// result -> 123.456
  /// -------------------------
  /// String value = '123456,12'
  /// var result = moneyValueCheck(value);
  /// result -> 123.456,12
  /// -------------------------
  /// String value = '12345,6'
  /// var result = moneyValueCheck(value);
  /// result -> 12.345,6
  String moneyValueCheck(String? moneyValue) {
    String newValue = '';
    List<String> moneyValueList;

    if (moneyValue != null && moneyValue.isNotEmpty) {
      moneyValueList = moneyValue.split('');

      if (moneyValueList.contains(',')) {
        if (moneyValueList.indexOf(',') == moneyValueList.lastIndexOf(',')) {
          //* virgülden sonra kaç basamaklı olacağı belirleniyor - default '2'
          while ((moneyValueList.length - moneyValueList.indexOf(',')) > 3) {
            moneyValueList.removeLast();
          }
          newValue = _currencyFormatFromListString(moneyValueList);
        } else {
          //* birden fazla virgül yazıldığında
          moneyValueList.removeLast();
          for (var element in moneyValueList) {
            newValue += element;
          }
        }
      } else {
        newValue = _currencyFormatFromListString(moneyValueList);
      }
    }

    return newValue;
  }

  //* Verilen String listesindeki sayıları 3'erli gruplara ayırarak
  //* kaç tane nokta koyulacağını tespit ediyor
  String _currencyFormatFromListString(List<String> valueList) {
    int moneyCount = 0;
    String newValue = '';

    //* sadece rakam olarak uzunluk alınıyor
    for (var element in valueList) {
      if (element == ',') break;
      if (element.contains(RegExp(r'[0-9]'))) {
        moneyCount++;
      }
    }

    switch (moneyCount) {
      case 4:
      case 5:
      case 6:
        newValue = _changePoints(valueList, 1);
        break;
      case 7:
      case 8:
      case 9:
        newValue = _changePoints(valueList, 2);
        break;
      case 10:
      case 11:
      case 12:
        newValue = _changePoints(valueList, 3);
        break;
      case 13:
      case 14:
      case 15:
        newValue = _changePoints(valueList, 4);
        break;
      case 16:
      case 17:
      case 18:
        newValue = _changePoints(valueList, 5);
        break;
      default:
        newValue = _changePoints(valueList, 0);
        break;
    }
    return newValue;
  }

  //* VERİLEN LİSTENİN İÇİNDEN NOKTAYI SİLER VE
  //* KAÇTANE NOKTA KONULACAKSA TEKRAR HESAPLAYIP YERİNE KOYAR
  String _changePoints(List<String> moneySplit, int commaCount) {
    String _newValue = '';
    int commaIndexValue = 0;

    List<String> valueList = moneySplit.reversed.toList();
    do {
      valueList.remove('.');
    } while (valueList.contains('.')); //1180,0  -- 0,081.115.61

    if (valueList.contains(',')) {
      var commaIndex = valueList.indexOf(',');
      if (commaIndex == 0) commaIndexValue = 1;
      if (commaIndex == 1) commaIndexValue = 2;
      if (commaIndex == 2) commaIndexValue = 3;
    }

    if (valueList.length > 3) {
      for (var i = 3 + commaIndexValue, k = 0; k < commaCount; i = i + 4, k++) {
        valueList.insert(i, '.');
      }
      for (var number in valueList.reversed) {
        _newValue += number;
      }
    } else {
      for (var number in valueList.reversed) {
        _newValue += number;
      }
    }

    return _newValue;
  }
}
