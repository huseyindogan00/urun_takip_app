import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/core/utility/util/calc/calculation_operations.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/repository/repository.dart';

class DoWorkViewModel extends ChangeNotifier implements DbBase {
  final ProductRepository _productRepository = locator<ProductRepository>();

  // MEVCUT PRODUCTTIN KOPYASI
  ProductModel? availableProductModel;
  // İŞLEM YAPILAN PRODUCT
  ProductModel? processedProductModel;
  // İŞ OLARAK YAPILAN PRODUCT
  ProductModel? doWorkProductModel;
  // İŞ OLARAK YAPILAN WORKMODEL
  late BaseWorkModel workModel;

  // SEÇİLEN ÜRÜN ADEDİ
  int _selectProductPiece = 0;
  int get productPiece => _selectProductPiece;
  set productPiece(int value) => _selectProductPiece = value;

  // YAPILAN İŞ ADEDİ
  int _numberOfWorkDone = 0;
  int get numberOfWorkDone => _numberOfWorkDone;
  set numberOfWorkDone(int value) => _numberOfWorkDone = value;

  // TOPLAM TUTAR
  /// calculate methodu çalıştırıldıktan sonra yeni toplam tutarı tutar
  double newProductTotalPrice = 0;

  /// Mevcuttaki ProductModelin stoğundan verilen stok miktarı çıkartılır ve
  /// yeni oluşturulan WorkModele ProductModel nesnesi oluşturularak atanır
  void calculate(BuildContext context, String doWorkPiece, String kdv) async {
    double _availableProductStockPiece = availableProductModel!.stockPiece;
    double _unitPrice = availableProductModel!.unitPrice;
    double _doWorkPiece = double.parse(doWorkPiece);
    double _kdv = double.parse(kdv) / 100;

    newProductTotalPrice = CalculationOperations.calculateNetPrice(_unitPrice, _doWorkPiece, _kdv);
    double newMatrahPrice = CalculationOperations.calculateBasePrice(_unitPrice, _doWorkPiece);

    doWorkProductModel = ProductModel(
      id: availableProductModel!.id,
      stockCode: availableProductModel!.stockCode,
      title: availableProductModel!.title,
      category: availableProductModel!.category,
      stockPiece: _doWorkPiece,
      unitPrice: _unitPrice,
      basePrice: newMatrahPrice,
      stockEntryDate: availableProductModel!.stockEntryDate,
      photoPath: availableProductModel!.photoPath ?? '',
      photoURL: availableProductModel!.photoURL ?? '',
    );

    processedProductModel!.stockPiece = _availableProductStockPiece - _doWorkPiece;
    processedProductModel!.basePrice =
        CalculationOperations.calculateBasePrice(processedProductModel!.unitPrice, processedProductModel!.stockPiece);
  }

  @override
  Future<ResultMessageModel?> add(BaseModel model) async {
    bool result = false;

    ResultMessageModel resultMessageModel = await _productRepository.add(model);
    if (resultMessageModel.isSuccessful) {
      result = await _productRepository.update(processedProductModel!);
    }
    if (result) {
      resultMessageModel.message = '${resultMessageModel.message} ve mevcut ürün güncellendi';
    }
    return resultMessageModel;
  }

  @override
  Future<bool?> delete(BaseModel productId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName collectionName) {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<bool?> update(BaseModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
