class CalculationOperations {
  ///
  /// KDV dahil fiyatı hesaplar (KDV ondalık olarak)
  static double calculateNetPrice(double unitPrice, double stockPiece, double kdv) {
    double result = (unitPrice * stockPiece) + ((unitPrice * stockPiece) * kdv);
    return result;
  }

  /// MATRAH fiyatı hesaplar
  static double calculateBasePrice(double unitPrice, double stockPiece) {
    double result = unitPrice * stockPiece;
    return result;
  }
}
