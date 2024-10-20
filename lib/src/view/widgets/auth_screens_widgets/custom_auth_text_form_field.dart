import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final String textFormLabelText;
  final String textFormHintText;
  final TextDirection hintTextDirection;
  final IconData iconName;
  final Color colorIcon;
  final bool obscureText;

  const CustomAuthTextFormField(
      {super.key,
      required this.textFormLabelText,
      required this.textFormHintText,
      required this.iconName,
      required this.colorIcon,
      this.obscureText = false,
      required this.hintTextDirection});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        hintTextDirection: hintTextDirection,
        labelText: textFormLabelText,
        hintText: textFormHintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          iconName,
          color: colorIcon,
        ),
      ),
    );
  }
}
