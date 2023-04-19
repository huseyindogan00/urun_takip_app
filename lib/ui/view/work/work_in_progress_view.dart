import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/data/models/work_in_progress_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/view_model/work_view_model/work_in_progress_view_model.dart';
import 'package:urun_takip_app/ui/widget/work_show_widget.dart';

class WorkInProgressView extends StatelessWidget {
  const WorkInProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Devam Eden İşler',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: WorkShowWidget<WorkInProgressModel>(viewModel: Provider.of<WorkInProgressViewModel>(context)),
    );
  }
}
