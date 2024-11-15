import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/athkar/athkar_categories_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories_response.dart';

class AthkarCategoriesController extends GetxController {
  late AthkarCategoriesService _athkarCategoriesService;

  AthkarCategoriesController(AthkarCategoriesService athkarCategoriesService) {
    _athkarCategoriesService = athkarCategoriesService;
    debounce(
      query,
      (_) {
        debugPrint("Debounced query triggered: ${query.value}");
        fetchAthkarCategories();
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  final ScrollController scrollController = ScrollController();

  final TextEditingController searchController = TextEditingController();

  var isMoreDataLoading = false.obs;
  var isLoading = false.obs;

  var page = 1.obs;
  var limit = 10.obs;

  var query = ''.obs;

  late int totalPages;
  late int totalAthkarsCategories;

  @override
  void onInit() async {
    super.onInit();
    await fetchAthkarCategories();
    ever(query, (callback) {
      if (query.value.isEmpty) {
        athkarsCategories.clear();
        page.value = 1;
        fetchAthkarCategories();
      }
    });
  }

  var athkarsCategories = <AthkarCategories>[].obs;

  Future<void> fetchAthkarCategories() async {
    debugPrint("Fetching Athkar Categories controller");
    // Fetch Athkar Categories
    debugPrint("Fetching Query : $query");

    try {
      AthkarCategoriesResponse? athkarCategoriesMode =
          await _athkarCategoriesService.fetchAthkarCategories(
              page, limit, query);
      //  debugPrint("-----------------------------------------------");
      // debugPrint("athkarCategoriesMode: ${athkarCategoriesMode?.toJson()}");
      // debugPrint("-----------------------------------------------");

      if (athkarCategoriesMode?.statusCode == 200) {
        if (query.isNotEmpty && page.value == 1) {
          debugPrint("Query is not empty");
          athkarsCategories.clear();

          page.value = 1;
        }
        athkarsCategories.addAll(athkarCategoriesMode!.message!.athkars!);
        totalPages = athkarCategoriesMode.metaData!.totalPages;
        totalAthkarsCategories =
            athkarCategoriesMode.metaData!.totalAthkarsCategories;
      } else if (athkarCategoriesMode?.statusCode == 404) {
        athkarsCategories.clear();
        page.value = 1;
      }

      //  debugPrint(
      // 'Athkar Categories: ${athkars.map((e) => 'Category: ${e.category}, ID: ${e.athkarCategotyId}').toList()}');
    } catch (e) {
      debugPrint("Error fetching athkar categories: $e");
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    debugPrint("load more .............................");
    debugPrint("${isMoreDataLoading.value}");
    if (!isMoreDataLoading.value) {
      isMoreDataLoading.value = true;
      debugPrint("page value : ${page.value}");
      if (page.value <= totalPages) {
        fetchAthkarCategories().then((_) {
          page.value += 1;
          isMoreDataLoading.value = false;
          double savedScrollPosition = scrollController.position.pixels;
          scrollController.jumpTo(savedScrollPosition + 1);
        });
      }
    }
  }
}
