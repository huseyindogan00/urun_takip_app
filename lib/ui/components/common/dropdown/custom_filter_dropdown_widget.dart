import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/ui/view_model/product_view_model/product_view_model.dart';

class CustomFilterDropdownWidget extends StatefulWidget {
  CustomFilterDropdownWidget({super.key});

  @override
  State<CustomFilterDropdownWidget> createState() => _CustomFilterDropdownWidgetState();
}

class _CustomFilterDropdownWidgetState extends State<CustomFilterDropdownWidget> {
  String selectValue = 'Teknoloji Ürünleri';

  late List<DropdownMenuItem<String>> items;

  @override
  void initState() {
    super.initState();
    items = categoryAllMap.keys.map((e) => _buildDropdownMenuItem(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: DropdownButton<String>(
        menuMaxHeight: CustomSize.kHeight(context) * 0.6,
        underline: const SizedBox(),
        isExpanded: true,
        value: context.watch<ProductViewModel>().selectFilterCategoryName,
        items: items,
        onChanged: (value) {
          setState(() {
            context.read<ProductViewModel>().selectFilterCategoryName = value!;
          });
        },
      ),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String menuItem) {
    return DropdownMenuItem(
      value: menuItem,
      child: Text(menuItem),
    );
  }
}
