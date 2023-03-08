import 'package:flutter/material.dart';
import 'package:urun_takip_app/core/constant/size/custom_size.dart';
import 'package:urun_takip_app/ui/pages/product/viewModel/product_view_model.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton(
      {super.key, required this.items, required this.onChanged});

  List<String> items;
  final Function(String value) onChanged;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectCategoryValue;
  late ProductViewModel _productViewModel;

  @override
  void initState() {
    super.initState();
    _productViewModel = ProductViewModel();
  }

  /* provider paketi eklendiğinde dropdown menüsünden seçilen değere göre alt kategori doldurulacak  */

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      menuMaxHeight: CustomSize.kHeight(context) * 0.7,
      value: _selectCategoryValue,
      hint: const Text('Kategori Seçiniz'),
      isExpanded: true,
      underline: const SizedBox(),
      items: widget.items.map((item) => _buildDropdownMenuItem(item)).toList(),
      onChanged: (value) => widget.onChanged(value!),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String menuItem) {
    return DropdownMenuItem(
      value: menuItem,
      child: Text(menuItem),
    );
  }
}
