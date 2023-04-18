import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/completed_work_view_model.dart';

class CompletedWorkWidget extends StatelessWidget {
  CompletedWorkWidget({super.key});
  late CompletedWorkViewModel completedWorkViewModel;

  @override
  Widget build(BuildContext context) {
    completedWorkViewModel = Provider.of<CompletedWorkViewModel>(context);
    return FutureBuilder<List<BaseModel>>(
      future: completedWorkViewModel.fetchAll(DBCollectionName.completedWorks),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return _buildProgress();
        } else {
          List<CompletedWorkModel> list = snapshot.data as List<CompletedWorkModel>;

          if (list.isEmpty) {
            return _buildWorkInProgressModelEmpty(context);
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                CompletedWorkModel model = list[index];
                return Card(
                  color: Colors.green.shade300,
                  child: ListBody(children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text('İş Bilgileri'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Firma Adı: ${model.companyName}'),
                          Text('Kategori: ${model.productModel.category.categoryName}'),
                          Text('Alt Kategori: ${model.productModel.category.categorySubName}'),
                          Text('Toplam Yapılan Adet: ${model.productModel.stockPiece}'),
                          Text('Toplam Tutar: ${model.totalPrice.toString().convertFromDoubleToString()}'),
                          Text('İş Durumu: ${model.businessCase}', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text('Ürün Bilgileri'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Açıklama: ${model.productModel.title}'),
                        ],
                      ),
                    ),
                  ]),
                );
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
        'Tamamlanan İş Listesi Boş',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade200),
      ),
    );
  }
}
