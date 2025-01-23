import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';

class CustomContentDropDownAyahs extends StatelessWidget {
  const CustomContentDropDownAyahs({
    super.key,
    required this.hintText,
    required this.selectedSurah,
    required this.groupContentList,
    required this.selectedAyahId,
    required this.onChanged,
  });

  final String hintText;
  final int selectedSurah;
  final List<GroupContent> groupContentList;
  final int selectedAyahId;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    List<String> items = List<String>.generate(
        groupContentList
            .firstWhereOrNull((e) => e.id == selectedSurah)!
            .endAyah!,
        (index) => (index + 1).toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: hintText,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        value: selectedAyahId,
        onChanged: onChanged,
        items: items.map((value) {
          return DropdownMenuItem<int>(
            value: int.parse(value),
            child: CustomGoogleTextWidget(
              text: value,
              fontSize: 16.0,
              color: AppColors.blackColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
