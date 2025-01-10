import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomDropdownWidget extends StatelessWidget {
  final RxInt limit;
  final Map<String, dynamic> queryParams;
  final Future<void> Function() fetcherFunction;
  final List<int> dropDownItems;

  const CustomDropdownWidget({
    super.key,
    required this.dropDownItems,
    required this.limit,
    required this.queryParams,
    required this.fetcherFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomGoogleTextWidget(
          text: "عرض",
          fontSize: 18.0,
        ),
        const SizedBox(width: 16.0),
        Obx(
          () => DropdownButton<int>(
            dropdownColor: AppColors.white,
            focusColor: AppColors.primaryColor,
            value: limit.value,
            items: dropDownItems.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: CustomGoogleTextWidget(
                  text: value.toString(),
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              );
            }).toList(),
            onChanged: (int? newValue) async {
              if (newValue != null) {
                limit.value = newValue;
                queryParams['limit'] = limit.value;

                await fetcherFunction();
              }
            },
          ),
        ),
        const SizedBox(width: 16.0),
        const CustomGoogleTextWidget(
          text: "خانات",
          fontSize: 18.0,
        ),
      ],
    );
  }
}
