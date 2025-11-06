import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'menu_state.freezed.dart';

@freezed
class MenuState with _$MenuState, BaseState {
  const factory MenuState() = _MenuState;
}
