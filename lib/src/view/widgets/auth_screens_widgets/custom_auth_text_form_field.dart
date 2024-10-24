import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final String? textFormLabelText;
  final String textFormHintText;
  final TextDirection hintTextDirection;
  final IconData iconName;
  final Color colorIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? textFormFieldValidator;
  final AutovalidateMode autovalidateMode;
  final TextDirection textFormDirection;

  const CustomAuthTextFormField(
      {super.key,
      this.textFormLabelText,
      required this.textFormHintText,
      required this.iconName,
      required this.colorIcon,
      this.obscureText = false,
      required this.hintTextDirection,
      required this.controller,
      required this.textFormFieldValidator,
      required this.autovalidateMode,
      required this.textFormDirection});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
      validator: textFormFieldValidator,
      controller: controller,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        hintTextDirection: hintTextDirection,
        labelText: textFormLabelText,
        hintText: textFormHintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        prefixIcon: Icon(
          iconName,
          color: colorIcon,
        ),
      ),
      textDirection: textFormDirection,
    );
  }
}
