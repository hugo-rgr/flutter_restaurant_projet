import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState, BaseState {
  const factory AuthState({
    String? error,
    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
    nameController: TextEditingController(),
    phoneController: TextEditingController(),
  );
}
