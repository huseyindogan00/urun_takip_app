import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/constant/images/const_image.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';
import 'package:urun_takip_app/core/utility/extension/string_extension.dart';
import 'package:urun_takip_app/core/utility/util/validation/currency_formatter.dart';
import 'package:urun_takip_app/data/models/base/base_model.dart';
import 'package:urun_takip_app/data/models/base/base_work_model.dart';
import 'package:urun_takip_app/ui/components/common/dialog/platform_sensitive_alert_dialog.dart';
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

  final TextStyle _nameTextTheme = const TextStyle(color: Colors.black, fontSize: 16);
  final TextStyle _titleTextTheme = const TextStyle(color: Colors.blue, fontSize: 16);
  final BoxDecoration _cardContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color.fromARGB(255, 19, 19, 19), width: 2),
  );

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
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return Future.delayed(const Duration(milliseconds: 250));
      },
      child: FutureBuilder<List<BaseModel>>(
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
                  return Dismissible(
                    key: ValueKey(index),
                    movementDuration: const Duration(milliseconds: 400),
                    resizeDuration: const Duration(milliseconds: 1000),
                    background: Container(
                      color: const Color.fromARGB(255, 83, 205, 103),
                      child: Image(
                        image: AssetImage(
                          model.businessCase == BusinessCaseText.continues
                              ? ConstImage.completedworkPath
                              : ConstImage.workinprogressPath,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: const Color.fromARGB(255, 219, 75, 65),
                      child: const Icon(Icons.delete, size: 64),
                    ),
                    direction: DismissDirection.horizontal,
                    confirmDismiss: (direction) async {
                      bool? resultEnToStart = false;
                      bool? resultStratToEnd = false;
                      String content = direction == DismissDirection.endToStart
                          ? 'İşi silmek istediğinizden emin misiniz?'
                          : model.businessCase == BusinessCaseText.completed
                              ? 'İşi Devam Eden İşlere taşınsın mı ?'
                              : 'İş tamamlandı mı?';

                      if (direction == DismissDirection.endToStart) {
                        resultEnToStart = await PlatformSensitiveAlertDialog(
                          content: content,
                          title: 'Uyarı!',
                          doneButtonTitle: 'Evet',
                          cancelButtonTitle: 'İptal',
                        ).show(context);
                        if (resultEnToStart != null && resultEnToStart) {
                          await viewModel.delete(model);
                          setState(() {});
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Silme işlemi başarılı'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                          return true;
                        }
                      } else if (direction == DismissDirection.startToEnd) {
                        resultStratToEnd = await PlatformSensitiveAlertDialog(
                          content: content,
                          title: 'Uyarı!',
                          doneButtonTitle: 'Evet',
                          cancelButtonTitle: 'İptal',
                        ).show(context);
                        if (resultStratToEnd != null && resultStratToEnd) {
                          model.businessCase = model.businessCase == BusinessCaseText.completed
                              ? BusinessCaseText.continues
                              : BusinessCaseText.completed;
                          await viewModel.update(model);
                          setState(() {});
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('İş durumu güncellendi'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                          return true;
                        }
                      }
                      return null;
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: _cardContainerDecoration,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                runSpacing: 10,
                                spacing: double.infinity,
                                alignment: WrapAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Text('Firma Adı :  ', style: _nameTextTheme),
                                      Text(model.companyName.toString(), style: _titleTextTheme),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Kategori : ', style: _nameTextTheme),
                                      Text(model.productModel.category.categoryName.toString(), style: _titleTextTheme),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Alt Kategori :', style: _nameTextTheme),
                                      Text(model.productModel.category.categorySubName.toString(),
                                          style: _titleTextTheme),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Toplam Yapılan Adet :  ', style: _nameTextTheme),
                                      Text(model.productModel.stockPiece.toInt().toString(), style: _titleTextTheme)
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('Toplam Tutar :  ', style: _nameTextTheme),
                                      Text(
                                          CurrencyFormatter.instance()
                                              .moneyValueCheck(model.totalPrice.toString().convertFromDoubleToString()),
                                          style: _titleTextTheme),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Text('İş Durumu :  ', style: _nameTextTheme),
                                      Text(model.businessCase, style: _titleTextTheme),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          height: 45,
                          top: 10,
                          right: 30,
                          child: Image(
                            color: Colors.red.shade900,
                            image: AssetImage(ConstImage.pinPath),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
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
