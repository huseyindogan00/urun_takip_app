import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/core/constant/text/product_stock_status_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/button/custom_elevated_button.dart';
import 'package:urun_takip_app/ui/view/product/product_update_view.dart';
import 'package:urun_takip_app/ui/view/work/do_work_view.dart';
import 'package:urun_takip_app/ui/widget/image_view_widget.dart';

class ProductStockWidget extends StatelessWidget {
  ProductStockWidget({super.key, required this.productModel});

  final ProductModel productModel;
  late TextStyle? titleStyle;
  late TextStyle? contentStyle;

  final _decoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    color: Color.fromARGB(255, 225, 224, 224),
    boxShadow: [BoxShadow(color: Color.fromARGB(255, 2, 8, 12), blurRadius: 5)],
  );

  final _containerMarginTopBottom = const EdgeInsets.only(top: 20, bottom: 20);

  @override
  Widget build(BuildContext context) {
    titleStyle = Theme.of(context).textTheme.labelLarge!;
    contentStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 16,
          color: Colors.black,
        );
    return Container(
      margin: _containerMarginTopBottom,
      padding: _containerMarginTopBottom,
      decoration: _decoration,
      width: CustomSize.kWidth(context),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _buildImage(context),
              ),
              Expanded(
                flex: 5,
                child: _buildTextColumn(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade600, indent: 10, endIndent: 10),
          const SizedBox(height: 10),
          _buildUpdateAndDoWorkButton(context),
        ],
      ),
    );
  }

  // GÜNCELLE VE İŞ YAP
  Row _buildUpdateAndDoWorkButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade500,
              textStyle: const TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) =>
                    ProductUpdateView(productModel: productModel),
              ),
            );
          },
          text: 'Güncelle',
          height: 40,
          width: 120,
        ),
        CustomElevatedButton(
          buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              textStyle: const TextStyle(color: Colors.black)),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoWorkView(productModel: productModel),
              ),
            );
          },
          text: 'İş Yap',
          height: 40,
          width: 120,
        ),
      ],
    );
  }

  Container _buildImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 108, 107, 107)),
      ),
      height: 120,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: productModel.photoURL != null && productModel.photoURL!.isNotEmpty
          ? _buildOnTapPhoto(context)
          : Image.asset(ConstImage.defaultImagePlaceHolder),
    );
  }

  InkWell _buildOnTapPhoto(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImageViewWidget(imagePath: productModel.photoURL!),
          ),
        );
      },
      child: Material(
        child: Image.network(
          productModel.photoURL!,
          fit: BoxFit.cover,
        ),
      ),
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
            Text(productModel.stockCode.toString(), style: contentStyle),
          ],
        ),
        Wrap(
          children: [
            Text(ProductStockStatusText.kategori, style: titleStyle),
            Text(
              productModel.category.categoryName.toString(),
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
            Text(productModel.category.categorySubName.toString(),
                style: contentStyle, overflow: TextOverflow.ellipsis),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.adet, style: titleStyle),
            Text(productModel.stockPiece.toInt().toString(),
                style: contentStyle),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.birimFiyati, style: titleStyle),
            Text(
                '${CurrencyFormatter.instance().moneyValueCheck(productModel.unitPrice.toString().convertFromDoubleToString())} ₺',
                style: contentStyle),
          ],
        ),
        Row(
          children: [
            Text(ProductStockStatusText.matrah, style: titleStyle),
            Text(
                '${CurrencyFormatter.instance().moneyValueCheck(productModel.basePrice.toString().convertFromDoubleToString())} ₺',
                style: contentStyle),
          ],
        ),
        /* Row(
          children: [
            Text(ProductStockStatusText.kdv, style: titleStyle),
            Text(' % ${productModel.kdv.toInt().toString()}',
                style: contentStyle),
          ],
        ), */
        Wrap(
          children: [
            Text(ProductStockStatusText.aciklama, style: titleStyle),
            Text(productModel.title,
                style: contentStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ],
        ),
      ],
    );
  }
}
