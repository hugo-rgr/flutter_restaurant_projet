import 'dart:async';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/base_state_notifier.dart';


final reservationNotifierProvider =
AsyncNotifierProvider.autoDispose<ReservationNotifier, ReservationState>(
  ReservationNotifier.new,
);

class ReservationNotifier extends BaseStateNotifier<ReservationState> {
  ReservationNotifier() : super(initialState: const ReservationState());


  @override
  FutureOr<void> refresh() async {

  }

  void openReservation() {
  }

}
