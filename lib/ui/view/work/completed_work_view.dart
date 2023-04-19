import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/data/models/completed_work_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/completed_work_view_model.dart';
import 'package:urun_takip_app/ui/widget/work_show_widget.dart';

class CompletedWorkView extends StatelessWidget {
  const CompletedWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Tamamlanan İşler',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: WorkShowWidget<CompletedWorkModel>(viewModel: Provider.of<CompletedWorkViewModel>(context)),
    );
  }
}
