import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/base_state.dart';
part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState, BaseState {
  const factory ReservationState() = _ReservationState;
}
