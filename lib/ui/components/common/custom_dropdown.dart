import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/models/category_json.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class CustomDropdownButton extends StatelessWidget {
  CustomDropdownButton({super.key});
  String? _categoryName;
  final String _categoriTitle = 'Kategori Seçiniz';
  final String _categorySubTitle = 'Alt Kategori Seçiniz';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _categoriTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        DropdownButton(
          menuMaxHeight: CustomSize.kHeight(context) * 0.7,
          hint: Text(_categoriTitle),
          value: _categoryName,
          isExpanded: true,
          underline: const SizedBox(),
          items: categoryAllMap.keys.map((key) => _buildDropdownMenuItem(key)).toList(),
          onChanged: (value) {
            _categoryName = value;
            context.read<ProductViewModel>().selectCategoryName = value;
          },
        ),
        Text(
          _categorySubTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        DropdownButton(
          menuMaxHeight: CustomSize.kHeight(context) * 0.7,
          hint: Text(_categorySubTitle),
          value: context.watch<ProductViewModel>().selectCategorySubName,
          isExpanded: true,
          underline: const SizedBox(),
          items: categoryAllMap[context.watch<ProductViewModel>().selectCategoryName]!
              .map((name) => _buildDropdownMenuItem(name))
              .toList(),
          onChanged: (value) {
            context.read<ProductViewModel>().selectCategorySubName = value;
          },
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
