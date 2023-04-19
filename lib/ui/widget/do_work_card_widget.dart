import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';

class DoWorkCardWidget extends StatelessWidget {
  DoWorkCardWidget({super.key, required this.workModel});

  BaseWorkModel workModel;
  TextStyle firstColumnStyle = const TextStyle(fontSize: 14, color: Colors.black);
  TextStyle secondColumnStyle = const TextStyle(fontSize: 14, color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    print('WordCardWidget Tetiklendi');
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black)],
        color: workModel.businessCase == BusinessCaseText.completed ? Colors.green.shade800 : Colors.red.shade500,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(5),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Firma Adı         : ', style: firstColumnStyle),
                      Text('Kategori           : ', style: firstColumnStyle),
                      Text('Alt Kategori     : ', style: firstColumnStyle),
                      Text('KDV                  : ', style: firstColumnStyle),
                      Text('Adet                  : ', style: firstColumnStyle),
                      Text('Net Fiyat          : ', style: firstColumnStyle),
                      Text('Gönderim Yeri : ', style: firstColumnStyle),
                      Text('İş Durumu        : ', style: firstColumnStyle),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FİRMA ADI
                        Text(workModel.companyName!,
                            style: secondColumnStyle, softWrap: false, maxLines: 1, overflow: TextOverflow.ellipsis),
                        // KATEGORİ ADI
                        Text(
                          workModel.productModel.category.categoryName!,
                          style: secondColumnStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // ALT KATEGORİ ADI
                        Text(
                          workModel.productModel.category.categorySubName!,
                          style: secondColumnStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // KDV
                        Text('% ${workModel.KDV.toInt().toString()}', style: secondColumnStyle),
                        // ADET
                        Text(workModel.productModel.stockPiece.toInt().toString(), style: secondColumnStyle),
                        // NET TUTAR
                        Text(
                            '${CurrencyFormatter.instance().moneyValueCheck(workModel.totalPrice.toString().convertFromDoubleToString())} ₺',
                            style: secondColumnStyle),
                        // GÖNDERİM YERİ
                        Text(
                            workModel.shippingPlace == ShippingPlaceText.local
                                ? ShippingPlaceText.local
                                : ShippingPlaceText.upstate,
                            style: secondColumnStyle),
                        // İŞ DURUMU
                        Text(
                            workModel.businessCase == BusinessCaseText.completed
                                ? BusinessCaseText.completed
                                : BusinessCaseText.continues,
                            style: secondColumnStyle),
                      ],
                    ),
                  ),
                ],
              ),
              //subtitle: Text('Tarih: ${DateTime.now().toString()}'),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: workModel.businessCase == BusinessCaseText.completed
                ? const Icon(
                    Icons.check_box,
                    color: Colors.green,
                    size: 30,
                  )
                : const Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
          )
        ],
      ),
    );
  }
}
