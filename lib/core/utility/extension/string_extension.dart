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

  /* /// double tipten para birimine çevir
  String convertFromDoubleToTurkeyCurrency() {
    String newValue = '';
    //int length = this.lastIndexOf('.');
    List<String> value = this.replaceAll('.', ',').split('');
    for (var element in value) {
      newValue += element;
    }
    return newValue;
  } */

  /// Verilen fotoğraf adres yolunda fotoğraf ismini id ile değiştirir
  String createPhotoName(String id) {
    return id + this.substring(this.lastIndexOf('.'));
  }
}
