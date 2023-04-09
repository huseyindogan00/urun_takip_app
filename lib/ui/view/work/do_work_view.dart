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
  late TextEditingController _companyNameController;
  late TextStyle? titleStyle;
  late TextStyle? contentStyle;

  final _decoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    color: Color.fromARGB(255, 225, 224, 224),
    boxShadow: [BoxShadow(color: Color.fromARGB(255, 2, 8, 12), blurRadius: 5)],
  );

  final _containerMarginTopBottom = const EdgeInsets.all(10);
  bool isActive = false;
  int tapped = 0;
  int currentStep = 0;

  late Widget textStock;
  late Widget iconStock;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _productModel = widget.productModel;
    textStock = _productModel.stockPiece > 0
        ? Text('Stokta var', style: TextStyle(color: Colors.green.shade800))
        : Text('Stokta Yok', style: TextStyle(color: Colors.red.shade800));
    iconStock = _productModel.stockPiece > 0
        ? const Icon(Icons.done, color: Colors.green)
        : const Icon(Icons.dangerous, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    titleStyle = Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14);
    contentStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 14, color: Colors.black);
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
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400),
                    onPressed: () {
                      _buildStepController(StepEnum.CONTINUE);
                    },
                    child: Text('İleri',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400),
                    onPressed: () {
                      _buildStepController(StepEnum.CANCEL);
                    },
                    child: Text('Geri',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onStepTapped: (value) => setState(() {
        tapped = value;
      }),
      currentStep: currentStep,
      elevation: 5,
      steps: _buildStepList(),
    );
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
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
                      ? Colors.green.shade700
                      : Colors.red.shade700),
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

  List<Step> _buildStepList() {
    return [
      Step(
        state: StepState.editing,
        isActive: isActive,
        label: const Text('label adı'),
        title: const Text('Alıcı Firma Adı'),
        content: TextField(controller: _companyNameController),
      ),
      Step(
        state: StepState.indexed,
        isActive: isActive,
        label: const Text('label adı'),
        title: const Text('Alıcı Firma Adı'),
        content: TextField(controller: _companyNameController),
      ),
      Step(
        state: StepState.indexed,
        isActive: isActive,
        label: const Text('label adı'),
        title: const Text('Alıcı Firma Adı'),
        content: TextField(controller: _companyNameController),
      ),
    ];
  }

  _buildStepController(StepEnum whichStep) {
    switch (whichStep) {
      case StepEnum.CONTINUE:
        setState(() {
          currentStep++;
        });
        break;
      case StepEnum.CANCEL:
        setState(() {
          currentStep--;
        });

        break;
    }
  }
}

enum StepEnum {
  CANCEL,
  CONTINUE,
}

enum StepStateEnum { COMPLATED, EDITING, INDEXED }
