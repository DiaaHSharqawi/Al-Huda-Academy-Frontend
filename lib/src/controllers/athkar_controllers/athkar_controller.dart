import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/athkar/athkar_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkars/athkar.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkars/athkars_response.dart';

class AthkarController extends GetxController {
  late AthkarService _athkarService;
  AthkarController(AthkarService athkarService) {
    _athkarService = athkarService;
  }

  var categoryId = ''.obs;

  var athkarCategoryName = ''.obs;
  var isLoading = false.obs;

  var totalNumberOfAthkar = 0.obs;
  var currentAthkarIndex = 0.obs;

  var maxNumberofCounts = 0.obs;
  var currentThekerCount = 0.obs;

  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();

    categoryId.value = Get.arguments['categoryId'] ?? '';
    debugPrint("Category ID: ${categoryId.value}");

    fetchAthkar(categoryId.value);
  }

  var athkars = <Athkar>[].obs;
  Future<void> fetchAthkar(String categoryId) async {
    debugPrint("Fetching Athkar  controller");

    try {
      isLoading(true);
      AthkarResponse? athkarResponse =
          await _athkarService.fetchAthkar(categoryId);

      if (athkarResponse!.statusCode == 200) {
        debugPrint('******************************');
        athkarCategoryName.value = athkarResponse.message!.category!;

        athkars.assignAll(athkarResponse.message!.athkars!.toList());

        totalNumberOfAthkar.value = athkars.length;

        maxNumberofCounts.value = athkars[currentAthkarIndex.value].count!;
        currentThekerCount.value = maxNumberofCounts.value;
      } else if (athkarResponse.statusCode == 404) {
        debugPrint("No Athkar found");
        athkars.clear();
      }

      //  debugPrint(
      // 'Athkar Categories: ${athkars.map((e) => 'Category: ${e.category}, ID: ${e.athkarCategotyId}').toList()}');
    } catch (e) {
      debugPrint("Error fetching athkar categories: $e");
    } finally {
      isLoading(false);
    }
  }
}
