import 'dart:async';

import 'package:flutter_restaurant_app/presentation/auth/auth.dart';
import 'package:flutter_restaurant_app/presentation/entrypoint/entrypoint.dart';
import 'package:flutter_restaurant_app/presentation/splash/state/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/base_state_notifier.dart';
import '../../menu/menu.dart';


final splashNotifierProvider =
AsyncNotifierProvider.autoDispose<SplashNotifier, SplashState>(
  SplashNotifier.new,
);

class SplashNotifier extends BaseStateNotifier<SplashState> {
  SplashNotifier() : super(initialState: const SplashState());


  @override
  FutureOr<void> refresh() async {

    await Future.delayed(const Duration(seconds: 2));
    openMenu();

  }

  void openMenu() {

    router.pushReplacement(EntryPointUI(), EntryPointUI.route);
  }

}
