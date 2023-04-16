import 'package:urun_takip_app/core/constant/enum/enumerations.dart';
import 'package:urun_takip_app/core/constant/text/app_text.dart';

Map<BusinessCase, String> businessCaseMap = {
  BusinessCase.COMPLATED: BusinessCaseText.completed,
  BusinessCase.CONTINUES: BusinessCaseText.continues,
};

Map<ShippingPlace, String> shippingPlaceMap = {
  ShippingPlace.LOCAL: ShippingPlaceText.local,
  ShippingPlace.UPSTATE: ShippingPlaceText.upstate,
};
