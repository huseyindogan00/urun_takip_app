import 'package:flutter/material.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';

class DoWorkView extends StatelessWidget {
  const DoWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(title: 'İş Yap'),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
