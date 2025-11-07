import 'dart:async';
import 'package:flutter_restaurant_app/data/local/models/registration_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/login_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dao/auth_dao.dart';

final authManagerProvider = Provider(AuthManager.new);

class AuthManager {
  AuthManager(this.ref);
  Ref ref;
  AuthDao get _authApi => ref.read(authDaoProvider);

  Future<void> signup({required RegistrationDTO registerInfo}) async {
    try {
      await _authApi.register(registerInfo: registerInfo);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> signin({required LoginDTO loginInfo}) async {
    try {
      await _authApi.login(loginInfo: loginInfo);
    } catch (e) {
      rethrow;
    }
  }
}
