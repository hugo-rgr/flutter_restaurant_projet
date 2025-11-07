import 'dart:async';
import 'package:flutter_restaurant_app/presentation/auth/auth.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';


final profileNotifierProvider =
AsyncNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);

class ProfileNotifier extends BaseStateNotifier<ProfileState> {
  ProfileNotifier() : super(initialState: const ProfileState());


  @override
  FutureOr<void> refresh() async {

  }

  void openProfile() {
  }


  void openAuth() {
    router.pushReplacement(Auth(), Auth.route);
  }

}
