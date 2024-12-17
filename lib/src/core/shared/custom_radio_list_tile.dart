import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Color fillColor;
  final bool selected;

  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    required this.title,
    this.fillColor = AppColors.primaryColor,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      fillColor: WidgetStateProperty.all(fillColor),
      title: title,
      value: value,
      groupValue: groupValue,
      selected: selected,
      onChanged: onChanged,
    );
  }
}
