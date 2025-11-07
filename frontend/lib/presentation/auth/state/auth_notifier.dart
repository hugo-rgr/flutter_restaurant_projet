import 'dart:async';
import 'package:flutter_restaurant_app/data/local/models/registration_dto.dart';
import 'package:flutter_restaurant_app/domain/auth_manager.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_state.dart';
import 'package:flutter_restaurant_app/presentation/entrypoint/entrypoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';

final authNotifierProvider =
    AsyncNotifierProvider.autoDispose<AuthNotifier, AuthState>(
      AuthNotifier.new,
    );

class AuthNotifier extends BaseStateNotifier<AuthState> {
  AuthNotifier() : super(initialState: AuthState.initial());

  AuthManager get authManager => ref.read(authManagerProvider);

  @override
  FutureOr<void> refresh() async {}

  void switchAuth() {
    currentState = currentState.copyWith(
      isLogin: !currentState.isLogin,
      error: null,
    );
  }

  void register() async {
    print('login clicked');

    currentState = currentState.copyWith(error: null);
    final name = currentState.nameController.text.trim();
    final password = currentState.passwordController.text.trim();
    final phone = currentState.phoneController.text.trim();
    final email = currentState.emailController.text.trim();

    if (email == '' || password == '') {
      currentState = currentState.copyWith(
        error: "Le mot de passe et l'email sont obligatoires",
      );
      return;
    }

    try {
      currentState = currentState.copyWith(isLoading: true);
      await authManager.signup(
        registerInfo: RegistrationDTO(
          email: email,
          password: password,
          name: name,
          phone: phone,
          role: ROLE.client,
        ),
      );

      openEntryPoint();
    } catch (e) {
      currentState = currentState.copyWith(
        error: "Une erreur est survenue durant l'inscription",
        isLoading: false,
      );
      return;
    }
  }

  void login() async {
    print('login clicked');
    currentState = currentState.copyWith(error: null);
    final password = currentState.passwordController.text.trim();
    final email = currentState.emailController.text.trim();

    if (email == '' || password == '') {
      currentState = currentState.copyWith(
        error: "Le mot de passe et l'email sont obligatoires",
      );
      return;
    }

    try {
      currentState = currentState.copyWith(isLoading: true);
      // await authManager.login();

      openEntryPoint();
    } catch (e) {
      currentState = currentState.copyWith(
        error: "Une erreur est survenue durant la connexion",
        isLoading: false,
      );
      return;
    }
  }

  void openEntryPoint() {
    router.pushReplacement(EntryPointUI(), EntryPointUI.route);
  }
}
