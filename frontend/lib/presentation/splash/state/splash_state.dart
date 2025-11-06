import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState, BaseState {
  const factory SplashState() = _SplashState;
}
