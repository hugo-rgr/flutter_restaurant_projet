import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/domain/user_logic.dart';
import 'package:flutter_restaurant_app/presentation/auth/auth.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_state.dart';
import 'package:flutter_restaurant_app/services/prefs/prefs_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';

final profileNotifierProvider =
    AsyncNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      ProfileNotifier.new,
    );

class ProfileNotifier extends BaseStateNotifier<ProfileState> {
  ProfileNotifier() : super(initialState: const ProfileState());

  PreferencesService get prefs => ref.read(prefsProvider);

  @override
  FutureOr<void> refresh() async {}

  void openProfile() {}

  void openAuth() {
    router.pushReplacement(Auth(), Auth.route);
  }

  Future<void> logout() async {
    ref.read(userProvider.notifier).killUser();
    await prefs.setString(PersistStoreKey.token, null);
    await prefs.setString(PersistStoreKey.email, null);
    await prefs.setString(PersistStoreKey.password, null);

    if(!router.routerContext.mounted){
      return;
    }
    ScaffoldMessenger.of(router.routerContext).showSnackBar(
      SnackBar(
        content: Text(
          'Vous avez été déconnecté.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
