import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/data/models/category_json.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

///Belirlenen kategoriye göre
class CustomCategoryDropdownButton extends StatelessWidget {
  CustomCategoryDropdownButton({super.key});

  final String _categoriTitle = 'Kategori Seçiniz';
  final String _categorySubTitle = 'Alt Kategori Seçiniz';
  final BoxDecoration _boxDecoration = BoxDecoration(
    border: Border.all(color: Colors.black),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _categoriTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        //* KATEGORİ SEÇİMİ
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.only(right: 10, left: 10),
          decoration: _boxDecoration,
          child: DropdownButton(
            menuMaxHeight: CustomSize.kHeight(context) * 0.7,
            hint: Text(_categoriTitle),
            value: context.watch<ProductViewModel>().selectCategoryName,
            isExpanded: true,
            underline: const SizedBox(),
            items: categoryAllMap.keys
                .map((key) => _buildDropdownMenuItem(key))
                .toList(),
            onChanged: (value) {
              context.read<ProductViewModel>().selectCategoryName = value;
            },
          ),
        ),
        CustomSize.betweenWidgetSize,
        Text(
          _categorySubTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        //* ALT KATEGORİ SEÇİMİ
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.only(right: 10, left: 10),
          decoration: _boxDecoration,
          child: DropdownButton(
            menuMaxHeight: CustomSize.kHeight(context) * 0.7,
            hint: Text(_categorySubTitle),
            value: context.watch<ProductViewModel>().selectCategorySubName,
            isExpanded: true,
            underline: const SizedBox(),
            items: categoryAllMap[
                    context.watch<ProductViewModel>().selectCategoryName]!
                .map((name) => _buildDropdownMenuItem(name))
                .toList(),
            onChanged: (value) {
              context.read<ProductViewModel>().selectCategorySubName = value;
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String menuItem) {
    return DropdownMenuItem(
      value: menuItem,
      child: Text(menuItem),
    );
  }
}
