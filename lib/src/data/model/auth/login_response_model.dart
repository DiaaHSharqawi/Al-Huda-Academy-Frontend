import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginResponse {
  final UserModel? _user;
  final String? _message;
  final bool? _success;
  final String? _accessToken;
  final String? _refreshToken;
  final int? _statusCode;

  LoginResponse({
    bool? success,
    String? message,
    UserModel? user,
    String? accessToken,
    String? refreshToken,
    int? statusCode,
  })  : _user = user,
        _message = message,
        _success = success,
        _accessToken = accessToken,
        _refreshToken = refreshToken,
        _statusCode = statusCode;

  UserModel? get user => _user;
  String? get message => _message;
  bool get success => _success!;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  int? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    return {
      'statusCode': _statusCode,
      'user': _user?.toJson(),
      'message': _message,
      'success': _success,
      'accessToken': _accessToken,
      'refreshToken': _refreshToken,
    };
  }
}
