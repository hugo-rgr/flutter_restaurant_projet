import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'menu_state.freezed.dart';

@freezed
class MenuState with _$MenuState, BaseState {

  const factory MenuState({
    @Default('Entrée') String selectedCategory,
}) = _MenuState;


   factory MenuState.initial() => MenuState();
}



/*@freezed
class GameState with _$GameState, BaseState {
  const factory GameState({
    @Default('') String error,
    @Default(10) int dailyCredit,
    @Default([]) List<GameDataResponse> games
  }) = _GameState;

  factory GameState.initial() => GameState();
}*/
