import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState, BaseState {
  const factory ProfileState() = _ProfileState;
}
