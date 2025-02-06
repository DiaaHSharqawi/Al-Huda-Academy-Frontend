import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get/instance_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class VerifyTokenJwtMiddleWare extends GetMiddleware {
  final AppService _appService = Get.find<AppService>();

  @override
  RouteSettings? redirect(String? route) {
    if (_appService.userValue == null ||
        JwtDecoder.isExpired(_appService.accessToken.value) == true) {
      debugPrint("Token is either null or expired");
      return RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
