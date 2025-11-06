import 'dart:async';
import 'package:flutter_restaurant_app/domain/auth_manager.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';


final authNotifierProvider =
AsyncNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends BaseStateNotifier<AuthState> {
  AuthNotifier() : super(initialState: const AuthState());


  AuthManager get authManager => ref.read(authManagerProvider);


  @override
  FutureOr<void> refresh() async {

  }

  void openAuth() {
  }

}
