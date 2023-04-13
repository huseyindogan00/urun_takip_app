import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';

class WorkCardWidget extends StatelessWidget {
  WorkCardWidget({super.key, required this.workModel});

  BaseWorkModel workModel;

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(fontSize: 14);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black)],
        color: workModel.businessCase == BusinessCase.COMPLATED ? Colors.green.shade800 : Colors.red.shade500,
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
                      Text('Firma Adı         : ', style: style),
                      Text('Kategori           : ', style: style),
                      Text('Alt Kategori     : ', style: style),
                      Text('Gönderim Yeri : ', style: style),
                      Text('Adet                  : ', style: style),
                      Text('Net Fiyat          : ', style: style),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(workModel.companyName!,
                            style: style, softWrap: false, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(
                          workModel.productModel.category.categoryName!,
                          style: style,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(workModel.productModel.category.categorySubName!, style: style),
                        Text(workModel.shippingPlace.name, style: style),
                        Text(workModel.productPiece.toString(), style: style),
                        Text(workModel.totalPrice.toString(), style: style),
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
            child: workModel.businessCase == BusinessCase.COMPLATED
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
