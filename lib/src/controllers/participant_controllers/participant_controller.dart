import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_service.dart';

class ParticipantController extends GetxController {
  // ignore: unused_field
  final ParticipantService _participantService;
  ParticipantController(this._participantService);

  void navigateToCurrentGroupsScreen() {
    debugPrint('navigateToCurrentGroupsScreen');

    Get.toNamed(
      AppRoutes.participantCurrentGroupsScreen,
    );
  }
}
