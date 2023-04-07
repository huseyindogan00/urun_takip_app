import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/init/locator/global_locator.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/calc/calculation_operations.dart';
import 'package:urun_takip_app/core/utility/util/manager/image_and_video_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/core/utility/util/validation/validation.dart';
import 'package:urun_takip_app/data/base/db_base.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/base/work_model.dart';
import 'package:urun_takip_app/data/repository/category_repository.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/data/repository/repository.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
import 'package:urun_takip_app/data/models/category_model.dart';

class ProductViewModel extends ChangeNotifier implements DbBase {
  final CategoryRepository _categoryRepository = locator<CategoryRepository>();
  final ProductRepository _productRepository = locator<ProductRepository>();
  late CategoryModel categoryModel = CategoryModel();
  ProductViewState _viewState = ProductViewState.IDLE;

  get viewState => _viewState;
  set viewState(state) {
    _viewState = state;
    notifyListeners();
  }

  String totalPrice = '0,00';
  XFile? productImageFilePath;
  bool allFetchProduct = false;

  // ******************************************SERVİS KATMANI
  //* STOKTA BULUNAN TÜM ÜRÜNLERİ GETİR
  /// Verilen filtreye göre Kategorinin hepsini yada belirtilen kategoriyi getirir.
  Future<List<BaseModel>> fetchProductByCategory(
      String categoryFilterName) async {
    if (categoryFilterName == 'Tümü') {
      return await fetchAll(DBCollectionName.products);
    } else {
      return await _productRepository
          .fetchProductByCategory(categoryFilterName);
    }
  }

  @override
  Future<List<BaseModel>> fetchAll(DBCollectionName dbCollectionName) async {
    return await _productRepository.fetchAll(dbCollectionName);
  }

  //* PRODUCT   EKLEME METHODU
  @override
  Future<bool?> add(BaseModel model) async {
    bool result = false;
    try {
      viewState = ProductViewState.BUSY;
      result = await _productRepository.add(model);
    } on Exception catch (_) {
      return false;
    } finally {
      viewState = ProductViewState.IDLE;
    }
    return result;
  }

  //* PRODUCT SİLME METHODU
  @override
  Future<bool?> delete(String productId) async {
    await _productRepository.delete(productId);
  }

  //* PRODUCT GÜNCELLEME METHODU
  @override
  Future<bool?> update(BaseModel model) async {
    try {
      viewState = ProductViewState.BUSY;
      return await _productRepository.update(model);
    } catch (_) {
    } finally {
      viewState = ProductViewState.IDLE;
    }
  }

  /// ****************************************************************************************************

  //! BURADA İŞLEMLER REPOSİTORYDEN ÇAĞRILACAK. ŞUANLIK MANAGER SINIFI KULLANILIYOR
  Future<bool?> getPhotoFromGallery(BuildContext context) async {
    try {
      XFile? xFile = await ImageAndVideoManager().getPhotoFromGallery();
      if (xFile == null) {
        return false;
      }
      productImageFilePath = xFile;

      notifyListeners();
    } on PlatformException catch (error) {
      bool? result = await PlatformSensitiveAlertDialog(
        content: error.message.toString(),
        title: 'Fotoğraf seçerken hata oluştu',
        doneButtonTitle: 'Tamam',
      ).show(context);
      return result;
    }
    return true;
  }

  //! BURADA İŞLEMLER REPOSITORYDEN ÇAĞRILACAK. ŞUANLIK MANAGER SINIFI KULLANILIYOR
  Future<bool?> getPhotoFromCamera(BuildContext context) async {
    try {
      XFile? xFile = await ImageAndVideoManager().getPhotoFromCamera();
      if (xFile == null) {
        return false;
      }
      productImageFilePath = xFile;

      notifyListeners();
    } on PlatformException catch (error) {
      bool? result = await PlatformSensitiveAlertDialog(
        content: error.message.toString(),
        title: 'Kameraya bağlanırken hata oluştu',
        doneButtonTitle: 'Tamam',
      ).show(context);
      return result;
    }
    return true;
  }

  //* HESAPLAMA YAPAR VE GERİYE DEĞERİ STRİNG OLARAK DÖNER
  String? calculateBasePrice(String unitPrice, String stockPiece) {
    // eğer gönderilen birimfiyat veya stok adedi boş ise işlem yapmaz
    if (unitPrice.isEmpty || stockPiece.isEmpty) {
      totalPrice = '0,00';
      notifyListeners();
    } else if (Validation.moneyValueValidation(unitPrice) == null &&
        Validation.generalValidation(stockPiece) == null &&
        (unitPrice.contains(RegExp(',')) || unitPrice.contains(RegExp('.'))) &&
        !unitPrice.contains(RegExp('[a-zA-Z]'))) {
      // Verilen birim fiyatı convertFromStringToDouble ile TR para birimini String tipden double tipe çevirir 1.023,12 => 1023.12
      double _unitPrice = unitPrice.convertFromStringToDouble();
      double _stockPiece = double.parse(stockPiece);

      double resultDouble =
          CalculationOperations.calculateBasePrice(_unitPrice, _stockPiece);
      String resultString = CurrencyFormatter.instance()
          .moneyValueCheck(resultDouble.toString().convertFromDoubleToString());

      totalPrice = resultString;
      notifyListeners();
    }
    return null;
  }

  //* KATEGORİ LİSTESİNDEKİ BAŞLIKLAR
  String? _selectCategoryName = categoryAllMap.keys.first;
  String? get selectCategoryName => _selectCategoryName;
  set selectCategoryName(String? value) {
    _selectCategoryName = value!;
    _selectCategorySubName = null; // ALT KATEGORİ VALUE DEĞERİ NULL YAPILIYOR
    categoryModel.categoryName = value;
    notifyListeners();
  }

  //* KATEGORİ LİSTESİNDE ALT BAŞLIKLAR
  String? _selectCategorySubName;
  String? get selectCategorySubName => _selectCategorySubName;
  set selectCategorySubName(String? value) {
    _selectCategorySubName = value!;
    categoryModel.categorySubName = value;
    notifyListeners();
  }

  //* STOK DURUM SAYFASINDA KATEGORİ FİLTRELEME
  String _selectFilterCategoryName = categoryAllMap.keys.first;
  String? get selectFilterCategoryName => _selectFilterCategoryName;
  set selectFilterCategoryName(String? value) {
    _selectFilterCategoryName = value!;
    notifyListeners();
  }

  void defaultProductAddView() {
    _selectCategoryName = null;
  }

  //* KATEGORİLERİ VERİTABANINDAN VEYA LOCALDEN GETİRİR
  List<String> fetchCategoryNameList() {
    return _categoryRepository.fetchCategoryNameList();
  }

  Future<void> refresh() async {
    viewState = ProductViewState.BUSY;
    //! YENİLE YAPIP YAPMADIĞI KONTROL EDİLECEK
    viewState = ProductViewState.IDLE;
  }

  //**************************** WORK İŞLEMLERİ ********************************

  // WORK EKLEME MOTHODU
  @override
  Future<bool?> addWork(WorkBaseModel model) {
    // TODO: implement addWork
    throw UnimplementedError();
  }
}

enum ProductViewState { IDLE, BUSY }
