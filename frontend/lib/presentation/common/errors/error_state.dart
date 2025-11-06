import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_state.freezed.dart';

mixin BaseErrorState implements Exception {
  String get message;
  Object get exception;
  StackTrace? get stack;
}

@freezed
class ErrorState with _$ErrorState, BaseErrorState {
  const factory ErrorState.stringError({
    required String message,
    required Object exception,
    StackTrace? stack,
  }) = StringError;
}
