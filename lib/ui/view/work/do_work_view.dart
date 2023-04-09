import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/product_stock_status_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';

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
  late TextEditingController _shippingPlaceController; // GÖNDERİM YERİ
  late TextEditingController _workStateController; //İŞ DURUMU
  late TextEditingController _totalPriceController; // TOPLAM NET TUTAR
  late TextStyle? titleStyle;
  late TextStyle? contentStyle;

  final _decoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    color: Color.fromARGB(255, 171, 172, 173),
    boxShadow: [BoxShadow(color: Color.fromARGB(255, 2, 8, 12), blurRadius: 5)],
  );
  final stepDecoration = const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(5),
  );

  final _companyNameKey = GlobalKey<FormFieldState>();
  final _productPieceKey = GlobalKey<FormFieldState>();
  final _shippingPlaceKey = GlobalKey<FormFieldState>();
  final _workStateKey = GlobalKey<FormFieldState>();
  final _totalPriceKey = GlobalKey<FormFieldState>();

  final _containerMarginTopBottom = const EdgeInsets.all(10);
  bool isActive = false;
  int tapped = 0;
  int currentIndex = 0;

  late Widget textStock;
  late Widget iconStock;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _productPieceController = TextEditingController();
    _shippingPlaceController = TextEditingController();
    _workStateController = TextEditingController();
    _totalPriceController = TextEditingController();

    _productModel = widget.productModel;

    textStock = _productModel.stockPiece > 0
        ? Text('Stokta var', style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold))
        : Text('Stokta Yok', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold));
    iconStock = _productModel.stockPiece > 0
        ? Icon(Icons.done, color: Colors.green.shade800, size: 30)
        : const Icon(Icons.dangerous_outlined, color: Colors.red);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _companyNameController.dispose();
    _productPieceController.dispose();
    _shippingPlaceController.dispose();
    _workStateController.dispose();
    _totalPriceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleStyle = Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14);
    contentStyle = Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14, color: Colors.black);
    return Scaffold(
      appBar: CustomAppbarWidget(title: 'İş Yap'),
      body: Container(
        color: Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            _buildProductCard(context),
            Expanded(
              child: buildStepper(),
            ),
          ],
        ),
      ),
    );
  }

  Stepper buildStepper() {
    return Stepper(
      controlsBuilder: (context, _) {
        if (currentIndex == 4) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBack(context),
              Container(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: const Text('ONAY'),
                ),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              currentIndex == 0 ? const SizedBox() : _buildBack(context),
              _buildForward(context),
            ],
          );
        }
      },
      currentStep: currentIndex,
      steps: [
        _buildStep(0, 'Alıcı Firma Adı', _companyNameController, _companyNameKey),
        _buildStep(1, 'Yapılan İş Adedi', _productPieceController, _productPieceKey),
        _buildStep(2, 'Gönderim Yeri', _shippingPlaceController, _shippingPlaceKey),
        _buildStep(3, 'İş Durumu', _workStateController, _workStateKey),
        _buildConfirm(4, 'İşi Onayla'),
      ],
    );
  }

  Container _buildForward(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 100,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade600, shadowColor: Colors.grey.shade800, elevation: 5),
        onPressed: () {
          _buildStepController(StepEnum.CONTINUE);
        },
        child: Text('İleri', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }

  Container _buildBack(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 100,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300, shadowColor: Colors.grey.shade900, elevation: 5),
        onPressed: () {
          _buildStepController(StepEnum.CANCEL);
        },
        child: Text('Geri', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }

  Step _buildConfirm(int index, String title) {
    return Step(
      state: currentIndex == index ? StepState.complete : StepState.indexed,
      isActive: currentIndex == index ? true : false,
      title: Text(title),
      content: const Text('data'),
    );
  }

  Step _buildStep(int index, String title, TextEditingController controller, GlobalKey key) {
    return Step(
      state: currentIndex == index
          ? StepState.editing
          : currentIndex > index
              ? StepState.complete
              : StepState.indexed,
      isActive: currentIndex == index ? true : false,
      title: Text(title),
      content: TextFormField(
        key: key,
        controller: controller,
        decoration: stepDecoration,
      ),
    );
  }

  _buildStepController(StepEnum whichStep) {
    switch (whichStep) {
      case StepEnum.CONTINUE:
        setState(() {
          if (currentIndex < 4) {
            currentIndex++;
          }
        });
        break;
      case StepEnum.CANCEL:
        setState(() {
          if (currentIndex > 0) {
            currentIndex--;
          }
        });

        break;
    }
  }

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
        border: Border.all(color: Colors.grey.shade500, width: 0.01),
      ),
      margin: const EdgeInsets.only(left: 5, right: 10),
      child: _productModel.photoURL != null && _productModel.photoURL!.isNotEmpty
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
                color: _productModel.stockPiece > 0 ? Colors.green.shade900 : Colors.red.shade700,
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
            Text(_productModel.title, style: contentStyle, overflow: TextOverflow.ellipsis, maxLines: 2),
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

enum StepStateEnum { COMPLATED, EDITING, INDEXED }
