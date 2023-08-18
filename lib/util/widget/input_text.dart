import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final bool? enabled;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final String? suffixText;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onChange;

  const InputText({
    super.key,
    this.enabled = true,
    this.hintText,
    this.label,
    this.suffixIcon,
    this.suffixText,
    this.fillColor,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 15),
        label: label != null ? Text(label!) : null,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        fillColor: fillColor,
      ),
      style: const TextStyle(fontSize: 20),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChange,
    );
  }
}
