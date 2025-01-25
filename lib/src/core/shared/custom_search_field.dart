import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.queryParams,
  });

  final TextEditingController searchController;
  final RxString searchQuery;
  final RxMap<String, dynamic> queryParams;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              onChanged: (String value) async {
                if (value.isEmpty) {
                  debugPrint("Search query is empty");
                }
                searchQuery.value = value;
              },
              iconName: Icons.search,
              textFormHintText: "ابحث عن حلقة",
              controller: searchController,
              textFormFieldValidator: (value) {
                if (value == null) {
                  return "الرجاء إدخال كلمة البحث";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          searchQuery.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    searchQuery.value = '';

                    queryParams['fullName'] = null;
                  },
                ),
        ],
      ),
    );
  }
}
