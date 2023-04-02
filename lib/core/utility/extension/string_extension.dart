// ignore_for_file: unnecessary_this

extension StringExtension on String {
  /// TR para birimini String tipden double tipe çevirir
  /// 1.023,12 => 1023.12
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

  /// Double değerin ondalık değerini virgül ile ayırır ve String olarak geri döner
  /// 1023.12 => 1023,12
  String convertFromDoubleToString() {
    List<String> valueList;
    String value = '';

    // ondalıklı bir sayıysa
    if (this.contains('.')) {
      valueList = this.replaceAll('.', ',').split(''); // 1023,12

      // eğer virgülden sonraki rakam bir ise 0 ekle
      if (valueList.length - 1 - valueList.indexOf(',') == 1) {
        valueList.insert(valueList.length, '0');
      }
    } else {
      valueList = this.split('');
      valueList.insert(valueList.length, ',00');
    }

    for (var element in valueList) {
      value += element;
    }

    return value;
  }

  /// Verilen fotoğraf adres yolunda fotoğraf ismini id ile değiştirir
  String createPhotoName(String id) {
    return id + this.substring(this.lastIndexOf('.'));
  }
}
