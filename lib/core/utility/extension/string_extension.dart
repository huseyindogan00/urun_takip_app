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
}
