import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';
import 'package:urun_takip_app/ui/view_model/base_view_model.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/work_in_progress_view_model.dart';

class WorkShowWidget<T extends BaseWorkModel> extends StatefulWidget {
  WorkShowWidget({super.key, required this.viewModel});
  IBaseViewModel viewModel;

  @override
  State<WorkShowWidget<T>> createState() => _WorkShowWidgetState<T>();
}

class _WorkShowWidgetState<T extends BaseWorkModel> extends State<WorkShowWidget<T>> {
  late IBaseViewModel viewModel;
  late DBCollectionName dbCollectionName;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    dbCollectionName =
        viewModel is WorkInProgressViewModel ? DBCollectionName.worksInProgress : DBCollectionName.completedWorks;
  }

  @override
  Widget build(BuildContext context) {
    //viewModel = Provider.of<IBaseViewModel>(context);
    return FutureBuilder<List<BaseModel>>(
      future: viewModel.fetchAll(dbCollectionName),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return _buildProgress();
        } else {
          List<T> list = snapshot.data as List<T>;

          if (list.isEmpty) {
            return _buildWorkInProgressModelEmpty(context);
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                T model = list[index];
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Card(
                        elevation: 15,
                        color: Colors.amber.shade200,
                        child: ListBody(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: const Text('İş Bilgileri'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Firma Adı: ${model.companyName}'),
                                  Text('Kategori: ${model.productModel.category.categoryName}'),
                                  Text('Alt Kategori: ${model.productModel.category.categorySubName}'),
                                  Text('Toplam Yapılan Adet: ${model.productModel.stockPiece}'),
                                  Text('Toplam Tutar: ${model.totalPrice.toString().convertFromDoubleToString()}'),
                                  Text('İş Durumu: ${model.businessCase}', style: const TextStyle(color: Colors.red))
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      height: 45,
                      top: 18.5,
                      right: 20,
                      child: Image(
                        color: Colors.red.shade900,
                        image: AssetImage(ConstImage.pinPath),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
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
        'İş Listesi Boş',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade200),
      ),
    );
  }
}
