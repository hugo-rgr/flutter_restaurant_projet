import 'dart:async';

import 'package:flutter_restaurant_app/data/local/models/login_dto.dart';
import 'package:flutter_restaurant_app/domain/auth_manager.dart';
import 'package:flutter_restaurant_app/presentation/auth/auth.dart';
import 'package:flutter_restaurant_app/presentation/entrypoint/entrypoint.dart';
import 'package:flutter_restaurant_app/presentation/splash/state/splash_state.dart';
import 'package:flutter_restaurant_app/services/prefs/prefs_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/base_state_notifier.dart';
import '../../menu/menu.dart';

final splashNotifierProvider =
    AsyncNotifierProvider.autoDispose<SplashNotifier, SplashState>(
      SplashNotifier.new,
    );

class SplashNotifier extends BaseStateNotifier<SplashState> {
  SplashNotifier() : super(initialState: const SplashState());

  AuthManager get authManager => ref.read(authManagerProvider);

  PreferencesService get prefs => ref.read(prefsProvider);

  @override
  FutureOr<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));

    await tryAutoLogin();
    openMenu();
  }

  Future<void> tryAutoLogin() async {
    final email = await prefs.getString(PersistStoreKey.email);
    final password = await prefs.getString(PersistStoreKey.password);

    if (email == null || password == null) {
      return;
    }

    try {
      await authManager.signin(
        loginInfo: LoginDTO(email: email, password: password),
      );
    } catch (e) {
      return;
    }
  }

  void openMenu() {
    router.pushReplacement(EntryPointUI(), EntryPointUI.route);
  }
}
