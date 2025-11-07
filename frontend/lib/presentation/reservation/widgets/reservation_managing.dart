import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_notifier.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_restaurant_app/presentation/reservation/widgets/reservation_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationManaging extends StatelessWidget {
  const ReservationManaging({super.key, required this.state, required this.notifier});
  final ReservationState state;
  final Refreshable<ReservationNotifier> notifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: state.allReservations.length,
      itemBuilder: (context, index) {
        final reservation = state.allReservations[index];
        return ReservationCard(
          key: ValueKey(reservation.id),
          reservation: reservation,
          isAdmin: true, notifier: notifier,
        );
      },
    );
  }
}
