import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urun_takip_app/core/constant/size/custom_padding.dart';

///
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.maxLines,
    this.maxLength,
    required this.controller,
    required this.labelText,
    this.suffix,
    this.prefix,
    this.readOnly = false,
    this.inputFormatters,
    this.keyboardType,
    required this.onSaved,
    this.onChanged,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Function(String? newValue)? onSaved;
  final Function(String? value)? onChanged;
  final String? Function(String? newValue)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      onSaved: onSaved,
      maxLength: maxLength,
      onChanged: onChanged,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefix: prefix,
        filled: readOnly ? true : false,
        fillColor:
            readOnly ? Theme.of(context).inputDecorationTheme.fillColor : null,
        suffix: suffix,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        contentPadding: CustomPadding.paddingTextFormField,
        labelStyle: Theme.of(context).textTheme.titleSmall,
        labelText: labelText,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide(color: Colors.blue)),
        errorBorder: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide()),
        border: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide()),
        disabledBorder: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide()),
        focusedBorder: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
            borderSide: readOnly
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide(color: Colors.black)),
      ),
    );
  }
}
