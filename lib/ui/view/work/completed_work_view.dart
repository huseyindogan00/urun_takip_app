import 'package:flutter/material.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';
import 'package:urun_takip_app/ui/widget/completed_work_widget.dart';

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
      body: CompletedWorkWidget(),
    );
  }
}
