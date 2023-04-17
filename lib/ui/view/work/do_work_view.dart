import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/constant/text/product_stock_status_text.dart';
import 'package:urun_takip_app/core/global/global_map.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/manager/uuid_manager.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/data/models/result_message_model.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/do_work_view_model.dart';
import 'package:urun_takip_app/ui/widget/work_card_widget.dart';

class DoWorkView extends StatefulWidget {
  const DoWorkView({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<DoWorkView> createState() => _DoWorkViewState();
}

class _DoWorkViewState extends State<DoWorkView> {
  late final ProductModel _productModel;
  late TextEditingController _companyNameController; //ALICI FİRMA ADI
  late TextEditingController _productPieceController; // ÜRÜN ADEDİ
  late TextEditingController _kdvController; // KDV
  late TextEditingController _shippingPlaceController; // GÖNDERİM YERİ
  late TextEditingController _businessCaseController; //İŞ DURUMU
  late TextEditingController _totalPriceController; // TOPLAM NET TUTAR
  late TextStyle? titleStyle;
  late TextStyle? contentStyle;
  //late BaseWorkModel? workModel;
  late DoWorkViewModel _doWorkViewModel;
  bool _confirmButton = false;

  late TextStyle _largeTextStyle;
  late TextStyle _smallTextStyle;

  final _decoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    color: Color.fromARGB(255, 171, 172, 173),
    boxShadow: [BoxShadow(color: Color.fromARGB(255, 2, 8, 12), blurRadius: 5)],
  );
  final stepDecoration = const InputDecoration(
    border: InputBorder.none,
    errorStyle: TextStyle(color: Colors.red),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(5),
  );
  final _productPieceDecoration = const InputDecoration(
    label: Text(AppText.isAdedi),
    labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
    errorStyle: TextStyle(color: Colors.red),
    border: InputBorder.none,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(5),
  );
  final _kdvDecoration = const InputDecoration(
    prefix:
        Text('% ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
    label: Text(AppText.kdv),
    labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
    errorStyle: TextStyle(color: Colors.red),
    border: InputBorder.none,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(5),
  );
  final _containerMarginTopBottom = const EdgeInsets.all(10);
  final _dropdownColor = Colors.white;
  final _dropdownDecoration = const BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));

  final _companyNameKey = GlobalKey<FormFieldState>();
  final _productPieceKey = GlobalKey<FormFieldState>();
  final _kdvKey = GlobalKey<FormFieldState>();
  final _shippingPlaceKey = GlobalKey<FormFieldState>();
  final _workStateKey = GlobalKey<FormFieldState>();
  final _totalPriceKey = GlobalKey<FormFieldState>();

  bool isActive = false; // stepin aktiflik kontrolü
  int currentIndex = 0; //
  //late int stockPiece;

  late Widget textStock;
  late Widget iconStock;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _productPieceController = TextEditingController();
    _totalPriceController = TextEditingController(text: '0');
    _shippingPlaceController =
        TextEditingController(text: shippingPlaceMap.values.first);
    _businessCaseController =
        TextEditingController(text: businessCaseMap.values.first);
    _kdvController = TextEditingController();

    _productModel = widget.productModel;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _doWorkViewModel = Provider.of<DoWorkViewModel>(context, listen: false);
      _doWorkViewModel.availableProductModel = _productModel
          .copyWith(); // SEÇİLEN PRODUCT MODELİ VİEWMODELA GÖNDERİYORUZ
      _doWorkViewModel.processedProductModel =
          _productModel.copyWith(); // ÜZERİNDE İŞLEM YAPILACAK PRODUCT MODEL
    });
    _initialize();
  }

  void _initialize() {
    textStock = _productModel.stockPiece > 0
        ? Text('Stokta var',
            style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 17))
        : Text('Stokta Yok',
            style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 17));
    iconStock = _productModel.stockPiece > 0
        ? Icon(Icons.done, color: Colors.green.shade800, size: 30)
        : const Icon(Icons.dangerous_outlined, color: Colors.red);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _productPieceController.dispose();
    _shippingPlaceController.dispose();
    _businessCaseController.dispose();
    _totalPriceController.dispose();
    _kdvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _largeTextStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Colors.blue.shade700, fontWeight: FontWeight.bold);
    _smallTextStyle = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: Colors.grey.shade700);
    titleStyle = Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14);
    contentStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 14, color: Colors.black);
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'İş Yap',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 240, 240),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            _buildProductCard(context),
            Divider(color: Colors.grey.shade400, thickness: 1),
            Expanded(child: buildStepper()),
          ],
        ),
      ),
    );
  }

  Stepper buildStepper() {
    return Stepper(
      currentStep: currentIndex,
      steps: [
        _buildStep(0, WorkStepText.step0,
            controller: _companyNameController, key: _companyNameKey),
        _buildStep(1, WorkStepText.step1,
            controller: _productPieceController, key: _productPieceKey),
        _buildStep(2, WorkStepText.step2,
            controller: _shippingPlaceController, key: _shippingPlaceKey),
        _buildStep(3, WorkStepText.step3,
            controller: _businessCaseController, key: _workStateKey),
        _buildStep(4, WorkStepText.step4),
      ],
      controlsBuilder: (context, _) {
        if (currentIndex == 4) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBackButton(context),
              _buildConfirmButton(context),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              currentIndex == 0 ? const SizedBox() : _buildBackButton(context),
              _buildForwardButton(context),
            ],
          );
        }
      },
    );
  }

  // ONAY BUTONU
  Container _buildConfirmButton(BuildContext context) {
    return Container(
      width: 110,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shadowColor: Colors.green.shade800,
            elevation: 6),
        onPressed: () => _confirmButton ? _buildSubmit() : null,
        child: Consumer<DoWorkViewModel>(
          builder: (_, viewModel, child) {
            if (viewModel.viewState == ViewState.BUSY) {
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ));
            } else {
              return child!;
            }
          },
          child: Text(
            'Onayla',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _buildSubmit() async {
    ResultMessageModel? resultMessageModel =
        await _doWorkViewModel.add(_doWorkViewModel.workModel);
    if (mounted) {
      await PlatformSensitiveAlertDialog(
              content: resultMessageModel!.message!,
              title: 'Bilgi',
              doneButtonTitle: 'Tamam')
          .show(context);
      if (mounted) Navigator.pop(context);
    }
  }

  // İLERİ BUTONU
  Container _buildForwardButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 110,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade800,
          shadowColor: Colors.grey.shade900,
          elevation: 5,
        ),
        onPressed: () {
          _buildStepController(StepEnum.CONTINUE);
        },
        child: Text('İleri',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white)),
      ),
    );
  }

  // GERİ BUTONU
  Container _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 105,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade500,
            shadowColor: Colors.grey.shade900,
            elevation: 5),
        onPressed: () {
          _buildStepController(StepEnum.CANCEL);
        },
        child: Text('Geri',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white)),
      ),
    );
  }

  // STEPLERİN OLUŞTURULMASI
  Step _buildStep(int index, String title,
      {TextEditingController? controller, GlobalKey? key}) {
    switch (index) {
      // ALICI FİRMA STEP
      case 0:
        return Step(
          state: currentIndex == index
              ? StepState.editing
              : currentIndex > index
                  ? StepState.complete
                  : StepState.indexed,
          isActive: currentIndex == index ? true : false,
          title: Text(
            title,
            style: currentIndex == index ? _largeTextStyle : _smallTextStyle,
          ),
          content: TextFormField(
            key: key,
            controller: controller,
            decoration: stepDecoration,
            onSaved: (newValue) => controller!.text = newValue!,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Bir değer giriniz';
              return null;
            },
          ),
        );
      // YAPILAN İŞ ADEDİ VE KDV TUTARI
      case 1:
        return Step(
          state: currentIndex == index
              ? StepState.editing
              : currentIndex > index
                  ? StepState.complete
                  : StepState.indexed,
          isActive: currentIndex == index ? true : false,
          title: Text(
            title,
            style: currentIndex == index ? _largeTextStyle : _smallTextStyle,
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  key: _productPieceKey,
                  controller: _productPieceController,
                  decoration: _productPieceDecoration,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (newValue) =>
                      _productPieceController.text = newValue!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '0') {
                      return 'İş adedi giriniz';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 2,
                child: TextFormField(
                  key: _kdvKey,
                  controller: _kdvController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _kdvDecoration,
                  onSaved: (newValue) => _kdvController.text = newValue!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '0') {
                      return 'KDV giriniz';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        );
      // GÖNDERİM YERİ
      case 2:
        return Step(
          state: currentIndex == index
              ? StepState.editing
              : currentIndex > index
                  ? StepState.complete
                  : StepState.indexed,
          isActive: currentIndex == index ? true : false,
          title: Text(
            title,
            style: currentIndex == index ? _largeTextStyle : _smallTextStyle,
          ),
          content: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: _dropdownDecoration,
            child: DropdownButton(
              dropdownColor: _dropdownColor,
              isExpanded: true,
              items: shippingPlaceMap.values.map((value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              value: _shippingPlaceController.text,
              underline: const SizedBox(),
              onChanged: (value) {
                setState(() {
                  _shippingPlaceController.text = value!;
                });
              },
            ),
          ),
        );
      // İŞ DURUMU
      case 3:
        return Step(
          state: currentIndex == index
              ? StepState.editing
              : currentIndex > index
                  ? StepState.complete
                  : StepState.indexed,
          isActive: currentIndex == index ? true : false,
          title: Text(title,
              style: currentIndex == index ? _largeTextStyle : _smallTextStyle),
          content: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: _dropdownDecoration,
            child: DropdownButton(
                dropdownColor: _dropdownColor,
                isExpanded: true,
                items: businessCaseMap.values.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                value: _businessCaseController.text,
                underline: const SizedBox(),
                onChanged: (value) {
                  setState(() {
                    _businessCaseController.text = value!;
                  });
                }),
          ),
        );
      // İŞİ ONAYLAMA
      case 4:
        return Step(
          state: currentIndex == index ? StepState.complete : StepState.indexed,
          isActive: currentIndex == index ? true : false,
          title: Text(title,
              style: currentIndex == index ? _largeTextStyle : _smallTextStyle),
          content: Builder(
            builder: (context) {
              if (currentIndex == 4) {
                if ((_doWorkViewModel.availableProductModel!.stockPiece -
                        double.parse(_productPieceController.text)) >=
                    0) {
                  _confirmButton = true;
                  _doWorkViewModel.calculate(context,
                      _productPieceController.text, _kdvController.text);

                  if (_businessCaseController.text ==
                      BusinessCaseText.completed) {
                    _doWorkViewModel.workModel = CompletedWorkModel(
                      id: UuidManager().randomId(),
                      companyName: _companyNameController.text,
                      productModel: _doWorkViewModel.doWorkProductModel!,
                      KDV: double.parse(_kdvController.text),
                      totalPrice: _doWorkViewModel.newProductTotalPrice,
                      businessCase: businessCaseMap[BusinessCase.COMPLATED]!,
                      shippingPlace: shippingPlaceMap[
                          _shippingPlaceController.text ==
                                  ShippingPlaceText.local
                              ? ShippingPlace.LOCAL
                              : ShippingPlace.UPSTATE]!,
                      workDate: DateTime.now(),
                    );
                  } else if (_businessCaseController.text ==
                      BusinessCaseText.continues) {
                    _doWorkViewModel.workModel = WorkInProgressModel(
                      id: UuidManager().randomId(),
                      companyName: _companyNameController.text,
                      productModel: _doWorkViewModel.doWorkProductModel!,
                      KDV: double.parse(_kdvController.text),
                      totalPrice: _doWorkViewModel.newProductTotalPrice,
                      businessCase: businessCaseMap[BusinessCase.CONTINUES]!,
                      shippingPlace: shippingPlaceMap[
                          _shippingPlaceController.text ==
                                  ShippingPlaceText.local
                              ? ShippingPlace.LOCAL
                              : ShippingPlace.UPSTATE]!,
                      workDate: DateTime.now(),
                    );
                  }

                  return WorkCardWidget(workModel: _doWorkViewModel.workModel);
                } else {
                  // eğer yapılan iş stoktan fazla ise
                  _confirmButton = false;
                  return const Text(
                    'Yapılan iş mevcut stoktan fazla !',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  );
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        );

      default:
        return const Step(
            title: Text('boş title'), content: Text('boş content'));
    }
  }

  // STEP üzerinde index kontrolü yapılır
  _buildStepController(StepEnum whichStep) {
    switch (whichStep) {
      case StepEnum.CONTINUE:
        // FİRMA ADI KONTROLÜ
        if (currentIndex == 0) {
          if (_companyNameKey.currentState!.validate()) {
            _companyNameKey.currentState!.save();
            setState(() {
              if (currentIndex < 4) currentIndex++;
            });
          }
        }
        // YAPILAN İŞ ADEDİ VE KDV KONTROLÜ
        else if (currentIndex == 1) {
          if (_productPieceKey.currentState!.validate()) {
            if (_kdvKey.currentState!.validate()) {
              _productPieceKey.currentState!.save();
              _kdvKey.currentState!.save();
              setState(() {
                if (currentIndex < 4) currentIndex++;
              });
            }
          }
        }
        // GÖNDERİM YERİ
        else {
          setState(() {
            if (currentIndex < 4) currentIndex++;
          });
        }

        break;
      case StepEnum.CANCEL:
        setState(() {
          if (currentIndex > 0) currentIndex--;
        });
        break;
    }
  }

  // İŞLEM YAPILAN PRODUCTMODEL
  Container _buildProductCard(BuildContext context) {
    return Container(
      margin: _containerMarginTopBottom,
      padding: _containerMarginTopBottom,
      decoration: _decoration,
      width: CustomSize.kWidth(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildImage(context),
                    const SizedBox(height: 10),
                    iconStock,
                    textStock,
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: _buildTextColumn(),
              ),
            ],
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  Container _buildImage(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 50, color: Colors.grey.shade300)],
        border: Border.all(color: Colors.grey.shade700, width: 0.01),
      ),
      margin: const EdgeInsets.only(left: 5, right: 10),
      child:
          _productModel.photoURL != null && _productModel.photoURL!.isNotEmpty
              ? Image.network(
                  _productModel.photoURL!,
                  fit: BoxFit.fitWidth,
                )
              : Image.asset(ConstImage.defaultImagePlaceHolder),
    );
  }

  Column _buildTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text(ProductStockStatusText.stokKodu, style: titleStyle),
            Text(_productModel.stockCode.toString(), style: contentStyle),
          ],
        ),
        Wrap(
          children: [
            Text(ProductStockStatusText.kategori, style: titleStyle),
            Text(
              _productModel.category.categoryName.toString(),
              style: contentStyle,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
        Wrap(
          children: [
            Text(
              ProductStockStatusText.altKategori,
              style: titleStyle,
            ),
            Text(_productModel.category.categorySubName.toString(),
                style: contentStyle, overflow: TextOverflow.ellipsis),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.adet, style: titleStyle),
            Text(
              _productModel.stockPiece.toInt().toString(),
              style: contentStyle!.copyWith(
                color: _productModel.stockPiece > 0
                    ? Colors.green.shade900
                    : Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.birimFiyati, style: titleStyle),
            Text(
                '${CurrencyFormatter.instance().moneyValueCheck(_productModel.unitPrice.toString().convertFromDoubleToString())} ₺',
                style: contentStyle),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.matrah, style: titleStyle),
            Text(
                '${CurrencyFormatter.instance().moneyValueCheck(_productModel.basePrice.toString().convertFromDoubleToString())} ₺',
                style: contentStyle),
          ],
        ),
        Wrap(
          children: [
            Text(ProductStockStatusText.aciklama, style: titleStyle),
            Text(_productModel.title,
                style: contentStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ],
        ),
      ],
    );
  }
}

enum StepEnum {
  CANCEL,
  CONTINUE,
}
