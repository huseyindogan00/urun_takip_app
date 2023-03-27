class CalculationOperations {
  ///
  /// Bu methot sadece hesaplama işlemlerini yapar. Verilen değerlere göre net fiyatı hesaplar.
  static double calculateNetPrice(double unitPrice, double stockPiece, double kdv) {
    double result = (unitPrice * stockPiece) + ((unitPrice * stockPiece) * kdv);
    return result;
  }
}
