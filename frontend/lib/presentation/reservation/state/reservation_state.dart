import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation.dart';
import 'package:flutter_restaurant_app/data/local/models/table.dart';
import '../../common/base_state.dart';
part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState, BaseState {
  const factory ReservationState({
    @Default([]) List<Reservation> reservations,
    @Default([]) List<RestaurantTable> availableTables,
    @Default([]) List<Reservation> allReservations,
    @Default(false) bool checkingAvailability,
    @Default(false) bool hasChecked,
    required TextEditingController seatsController,
    @Default(false) bool isAvailable,
    @Default(null) DateTime? selectedDate,
    String? error,
    @Default(tableSlot) List<Map<String, dynamic>> tableSlots,
    @Default({
      'id': '1',
      'startTime': '08:00',
      'endTime': '9:00',
    }) Map<String, dynamic> actualSlot,
    Reservation? selectedReservation,
  }) = _ReservationState;

  factory ReservationState.initial() => ReservationState(
    seatsController: TextEditingController(),
      );
}


const List<Map<String, dynamic>> tableSlot = [
  {'id': '1', 'startTime': '08:00', 'endTime': '9:00'},
  {'id': '2', 'startTime': '10:00', 'endTime': '11:00'},
  {'id': '3', 'startTime': '12:00', 'endTime': '13:00'},
  {'id': '4', 'startTime': '14:00', 'endTime': '15:00'},
  {'id': '5', 'startTime': '18:00', 'endTime': '19:00'},
  {'id': '6', 'startTime': '19:00', 'endTime': '20:00'},
];

const  actualSlot = {
  'id':'1',
  'startTime': '08:00',
  'endTime': '9:00',
};
