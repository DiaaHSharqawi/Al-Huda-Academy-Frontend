import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class PaginationWidget extends StatelessWidget {
  final RxInt currentPage;
  final RxInt totalPages;
  final Future<void> Function() fetchRequestsForCreatingGroup;
  final Color primaryColor;
  final Color textColor;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.fetchRequestsForCreatingGroup,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (totalPages <= 1) {
        return const SizedBox.shrink();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: currentPage.value > 1
                    ? () async {
                        currentPage.value--;
                        await fetchRequestsForCreatingGroup();
                      }
                    : null,
              ),
              ...List.generate(totalPages.value, (index) {
                if (index == 0 ||
                    index == totalPages.value - 1 ||
                    (index >= currentPage.value - 2 &&
                        index <= currentPage.value)) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomButton(
                      backgroundColor: currentPage.value == index + 1
                          ? primaryColor.withOpacity(0.8)
                          : primaryColor,
                      foregroundColor: textColor,
                      buttonText: '${index + 1}',
                      buttonTextColor: textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      onPressed: () async {
                        currentPage
                            .update((val) => currentPage.value = index + 1);
                        await fetchRequestsForCreatingGroup();
                      },
                    ),
                  );
                } else if (index == currentPage.value - 3 ||
                    index == currentPage.value + 1) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomGoogleTextWidget(
                      text: '...',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: currentPage.value < totalPages.value
                    ? () async {
                        currentPage.value++;
                        await fetchRequestsForCreatingGroup();
                      }
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
