import 'package:flutter/material.dart';
import 'package:urun_takip_app/data/base/db_base.dart';

abstract class IBaseViewModel extends ChangeNotifier implements DbBase {
  Future<void> refresh();
  Future<bool?> showDialogCustom(BuildContext context, String content, String title, String doneButtonTitle);
}
