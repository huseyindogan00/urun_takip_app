class Validation {
  /// inputun boş olup olmadığını kontrol eder, boş değilse `null` döndürür.
  static String? generalValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen bir değer giriniz';
    }
    return null;
  }

  /// Girilen miktarın ondalık olarak ayrımını yapar, verilen değer doğruysa `null` döner.
  /// Değerin içinde sayı ile nokta ve virgülün olup olmadığını kontrol eder.
  /// Farklı bir karakter varsa uyarı mesajı döner.
  static String? moneyValueCheck(String? moneyValue) {
    if (moneyValue == null || moneyValue.isEmpty) {
      return 'Lütfen birim fiyatı giriniz';
    } else if (!moneyValue.contains(RegExp(r'[0-9]')) && !moneyValue.contains(RegExp('.,')) ||
        moneyValue.contains(RegExp('[a-zA-Z]'))) {
      return 'ondalıklı giriniz';
    }
    return null;
  }
}
