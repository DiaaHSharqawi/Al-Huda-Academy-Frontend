import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginResponse {
  final UserModel? user;
  final String? message;
  final bool success;

  LoginResponse({this.user, this.message, required this.success});
}
