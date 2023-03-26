// ignore_for_file: unnecessary_this

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

  /// double tipten para birimine çevir
  String convertDoubleToTurkeyCurrency() {
    String newValue = '';
    //int length = this.lastIndexOf('.');
    List<String> value = this.replaceAll('.', ',').split('');
    for (var element in value) {
      newValue += element;
    }
    return newValue;
  }

  /// String tipden double tipe çevir
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
