import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';

class CustomContentDropDown extends StatelessWidget {
  const CustomContentDropDown({
    super.key,
    required this.groupContentList,
    required this.onChanged,
    required this.selectedContentId,
    required this.hintText,
    this.errorText,
  });

  final List<GroupContent> groupContentList;
  final void Function(GroupContent?) onChanged;
  final int selectedContentId;
  final String hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<GroupContent>(
        decoration: InputDecoration(
          errorText: errorText,
          labelText: hintText,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        value: groupContentList
            .firstWhereOrNull((element) => element.id == selectedContentId),
        onChanged: onChanged,
        items: groupContentList.map((value) {
          return DropdownMenuItem<GroupContent>(
            value: value,
            child: CustomGoogleTextWidget(
              text: value.name!,
              fontSize: 16.0,
              color: AppColors.blackColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
