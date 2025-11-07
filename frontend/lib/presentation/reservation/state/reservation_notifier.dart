import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/data/local/models/user.dart';
import 'package:flutter_restaurant_app/domain/table_manager.dart';
import 'package:flutter_restaurant_app/domain/user_logic.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_restaurant_app/presentation/reservation/widgets/edit_reservation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/domain/reservation_manager.dart';
import 'package:flutter_restaurant_app/services/prefs/prefs_service.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_create_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_update_dto.dart';
import 'package:intl/intl.dart';
import '../../../data/local/models/available_table_request_dto.dart';
import '../../auth/auth.dart';
import '../../common/base_state_notifier.dart';

final reservationNotifierProvider =
    AsyncNotifierProvider.autoDispose<ReservationNotifier, ReservationState>(
      ReservationNotifier.new,
    );

class ReservationNotifier extends BaseStateNotifier<ReservationState> {
  ReservationNotifier() : super(initialState: ReservationState.initial());

  ReservationManager get _manager => ref.read(reservationManagerProvider);
  TableManager get _tableManager => ref.read(tableManagerProvider);
  PreferencesService get _prefs => ref.read(prefsProvider);

  @override
  FutureOr<void> refresh() async {
    await loadUserReservations();
    await loadAdminAllManagingReservations();
  }

  void setActualSlot(Map<String, dynamic> actualSlot) {
    print('Actual slot set to: $actualSlot');
    currentState = currentState.copyWith(actualSlot: actualSlot);
  }

  void setSelectedDate(DateTime selectedDate) {
    currentState = currentState.copyWith(selectedDate: selectedDate);
  }

  /// Charge les réservations de l'utilisateur connecté
  Future<void> loadUserReservations() async {
    final user = ref.read(userProvider);
    if (user == null) {
      currentState = currentState.copyWith(reservations: []);
      return;
    }
    try {
      final reservations = await _manager.list(userId: user.id);
      print('Loaded reservations: $reservations');
      currentState = currentState.copyWith(reservations: reservations);
    } catch (e) {
      // En cas d'erreur, on affiche une liste vide plutôt que de bloquer
      currentState = currentState.copyWith(reservations: []);
    }
  }

  void setSeatsController(String string) {
    currentState = currentState.copyWith(
      seatsController: TextEditingController(text: string),
    );
  }


  void addSlot(Reservation reservation, notifier)  {

   setSeatsController(
      reservation.numberOfGuests.toString(),
    );




    currentState = currentState.copyWith(
      selectedDate: DateTime(
        reservation.startDate.year,
        reservation.startDate.month,
        reservation.startDate.day,
      ),
    );



    print(currentState.actualSlot);

    print(currentState.tableSlots);

    ref
        .read(notifier)
        .openEditReservation(reservation, notifier);

  }

  Future<void> loadAdminAllManagingReservations() async {
    final user = ref.read(userProvider);

    if (user == null) {
      currentState = currentState.copyWith(allReservations: []);
      return;
    }
    if (user.role != UserRole.hote && user.role != UserRole.admin) {
      return;
    }
    try {
      final reservations = await _manager.adminGetAll();
      print('Loaded all reservations: $reservations');
      currentState = currentState.copyWith(allReservations: reservations);
    } catch (e) {
      // En cas d'erreur, on affiche une liste vide plutôt que de bloquer
      currentState = currentState.copyWith(allReservations: []);
    }
  }

  void openEditReservation(
    Reservation reservation,
    Refreshable<ReservationNotifier> notifier,
  ) {
    router.push(
      EditReservation(notifier: notifier, reservation: reservation),
      EditReservation.route,
    );
  }

  Future<void> acceptOrRefuseReservation({
    required int id,
    required bool accept,
  }) async {
    try {
      final status =
          accept ? ReservationStatus.confirmed : ReservationStatus.rejected;
      await _manager.changeStatus(id: id, status: status);
      await loadAdminAllManagingReservations();
    } catch (e) {
      rethrow;
    }
  }

  void openLogin() {
    router.pushReplacement(Auth(), Auth.route);
  }

  List<int> getTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return [hour, minute];
  }

  bool isNumber(String str) {
    if (str.isEmpty) {
      return false;
    }
    final number = num.tryParse(str);
    return number != null;
  }

  Future<void> createReservation({required int tableId}) async {
    final start = DateTime(
      currentState.selectedDate!.year,
      currentState.selectedDate!.month,
      currentState.selectedDate!.day,
      getTime(currentState.actualSlot['startTime'])[0],
      getTime(currentState.actualSlot['startTime'])[1],
    );

    final end = DateTime(
      currentState.selectedDate!.year,
      currentState.selectedDate!.month,
      currentState.selectedDate!.day,
      getTime(currentState.actualSlot['endTime'])[0],
      getTime(currentState.actualSlot['endTime'])[1],
    );

    print('Creating reservation with:  $end');
    print('Creating reservation with:  $start');
    try {
      await _manager.create(
        dto: ReservationCreateDTO(
          tableId: tableId,
          timeSlotId: currentState.actualSlot['id'],
          numberOfGuests: int.parse(currentState.seatsController.text),
          startDate: start,
          endDate: end,
        ),
      );
      if (!router.routerContext.mounted) {
        return;
      }
      currentState = currentState.copyWith(
        seatsController: TextEditingController(),
        selectedDate: null,
        availableTables: [],
        hasChecked: false,
      );
      loadUserReservations();
    } catch (e) {
      if (!router.routerContext.mounted) {
        return;
      }
      ScaffoldMessenger.of(router.routerContext).showSnackBar(
        SnackBar(
          content: Text(
            'Une erreur est survenue lors de la création de la réservation',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> updateReservation({required int tableId, required int reservationId}) async {
    final start = DateTime(
      currentState.selectedDate!.year,
      currentState.selectedDate!.month,
      currentState.selectedDate!.day,
      getTime(currentState.actualSlot['startTime'])[0],
      getTime(currentState.actualSlot['startTime'])[1],
    );

    final end = DateTime(
      currentState.selectedDate!.year,
      currentState.selectedDate!.month,
      currentState.selectedDate!.day,
      getTime(currentState.actualSlot['endTime'])[0],
      getTime(currentState.actualSlot['endTime'])[1],
    );

    print('Creating reservation with:  $end');
    print('Creating reservation with:  $start');

    print( ReservationUpdateDTO(
      tableId: tableId,
      numberOfGuests: int.parse(currentState.seatsController.text),
      startDate: start,
      endDate: end,
    ).toJson());
    try {
      await _manager.edit(
        dto: ReservationUpdateDTO(
          tableId: tableId,
          numberOfGuests: int.parse(currentState.seatsController.text),
          startDate: start,
          endDate: end,
        ),
        id: reservationId,
      );
      if (!router.routerContext.mounted) {
        return;
      }
      currentState = currentState.copyWith(
        seatsController: TextEditingController(),
        selectedDate: null,
        availableTables: [],
        hasChecked: false,
      );
      Navigator.pop(router.routerContext);
      loadUserReservations();


    } catch (e) {
      print(e);
      if (!router.routerContext.mounted) {
        return;
      }
      ScaffoldMessenger.of(router.routerContext).showSnackBar(
        SnackBar(
          content: Text(
            'Une erreur est survenue lors de la mise à jour de la réservation',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> checkAvailability() async {
    currentState = currentState.copyWith(error: null);

    if (currentState.seatsController.text.trim() == '') {
      currentState = currentState.copyWith(
        error: "Veuillez entrer le nombre de places",
      );
      return;
    }

    if (!isNumber(currentState.seatsController.text.trim())) {
      currentState = currentState.copyWith(
        error: "Veuillez entrer un nombre valide pour les places",
      );
      return;
    }

    if (currentState.selectedDate == null) {
      currentState = currentState.copyWith(
        error: "Veuillez sélectionner une date",
      );
      return;
    }

    try {
      final availabilityQuery = AvailableTableRequestDto(
        date: DateFormat('yyyy-MM-dd').format(currentState.selectedDate!).toString(),
        timeSlotId: currentState.actualSlot['id'].toString(),
        seats: currentState.seatsController.text.toString(),
      );

      print('Checking availability with: ${availabilityQuery.toJson()}');
      currentState = currentState.copyWith(checkingAvailability: true);

      final result = await _tableManager.getAvailableTables(
        availableTableRequestDto: availabilityQuery,
      );

      currentState = currentState.copyWith(
        availableTables: result,
        hasChecked: true,
        checkingAvailability: false,
      );
    } catch (e) {
      currentState = currentState.copyWith(checkingAvailability: false);
      rethrow;
    }
  }

  /// Crée une nouvelle réservation

  /// Modifie une réservation existante

  /*Future<void> updateReservation({
    required int id,
    required int tableId,
    required int numberOfGuests,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final dto = ReservationUpdateDTO(
        tableId: tableId,
        numberOfGuests: numberOfGuests,
        startDate: startDate,
        endDate: endDate,
      );

      await _manager.edit(id: id, dto: dto);
      await loadUserReservations();
    } catch (e) {
      rethrow;
    }
  }*/

  /// Annule une réservation
  Future<void> cancelReservation(int id) async {
    try {
      await _manager.changeStatus(id: id, status: ReservationStatus.cancelled);
      await loadUserReservations();
    } catch (e) {
      rethrow;
    }
  }

  /// Supprime une réservation
  Future<void> deleteReservation(int id) async {
    try {
      await _manager.remove(id);
      await loadUserReservations();
    } catch (e) {
      rethrow;
    }
  }

  /// Sélectionne une réservation pour modification
  void selectReservation(Reservation? reservation) {
    currentState = currentState.copyWith(selectedReservation: reservation);
  }

  void openReservation() {}
}
