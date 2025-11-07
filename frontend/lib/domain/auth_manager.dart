import 'dart:async';
import 'package:flutter_restaurant_app/data/local/models/registration_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/login_dto.dart';
import 'package:flutter_restaurant_app/domain/user_logic.dart';
import 'package:flutter_restaurant_app/services/prefs/prefs_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dao/auth_dao.dart';

final authManagerProvider = Provider(AuthManager.new);

class AuthManager {
  AuthManager(this.ref);
  Ref ref;
  AuthDao get _authApi => ref.read(authDaoProvider);
  PreferencesService get _prefs => ref.read(prefsProvider);

  Future<void> signup({required RegistrationDTO registerInfo}) async {
    try {
      final response = await _authApi.register(registerInfo: registerInfo);
      await _prefs.setString(PersistStoreKey.token, response.token);
      ref.read(userProvider.notifier).setUser(response.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signin({required LoginDTO loginInfo}) async {
    try {
      final response = await _authApi.login(loginInfo: loginInfo);

      print('login response token: ${response.token}');
      await _prefs.setString(PersistStoreKey.token, response.token);
      ref.read(userProvider.notifier).setUser(response.user);
    } catch (e) {
      rethrow;
    }
  }
}
