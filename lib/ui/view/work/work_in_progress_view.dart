import 'package:flutter/material.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/widget/work_in_progress_widget.dart';

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
      body: WorkInProgressWidget(),
    );
  }
}
