import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/work_in_progress_view_model.dart';

class WorkInProgressWidget extends StatelessWidget {
  WorkInProgressWidget({super.key});
  late WorkInProgressViewModel workInProgressViewModel;

  @override
  Widget build(BuildContext context) {
    workInProgressViewModel = Provider.of<WorkInProgressViewModel>(context);
    return FutureBuilder<List<BaseModel>>(
      future:
          workInProgressViewModel.fetchAll(DBCollectionName.worksInProgress),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return _buildProgress();
        } else {
          List<WorkInProgressModel> list =
              snapshot.data as List<WorkInProgressModel>;

          if (list.isEmpty) {
            return _buildWorkInProgressModelEmpty(context);
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                WorkInProgressModel model = list[index];
                return Stack(children: [
                  Card(
                    color: Colors.amber.shade200,
                    child: ListBody(children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: const Text('İş Bilgileri'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Firma Adı: ${model.companyName}'),
                            Text(
                                'Kategori: ${model.productModel.category.categoryName}'),
                            Text(
                                'Alt Kategori: ${model.productModel.category.categorySubName}'),
                            Text(
                                'Toplam Yapılan Adet: ${model.productModel.stockPiece}'),
                            Text(
                                'Toplam Tutar: ${model.totalPrice.toString().convertFromDoubleToString()}'),
                            Text('İş Durumu: ${model.businessCase}',
                                style: const TextStyle(color: Colors.green))
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: const Text('Ürün Bilgileri'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Açıklama: ${model.productModel.title}'),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Positioned(
                    width: 50,
                    height: 50,
                    right: 20,
                    top: 15,
                    child: Image(
                      image: AssetImage(ConstImage.pinPath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ]);
              },
            );
          }
        }
      },
    );
  }

  Center _buildProgress() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildWorkInProgressModelEmpty(BuildContext context) {
    return Center(
      child: Text(
        'Devam Eden İş Listesi Boş',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.grey.shade200),
      ),
    );
  }
}
