import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState, BaseState {
  const factory AuthState() = _AuthState;
}
