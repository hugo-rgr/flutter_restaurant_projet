import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_restaurant_app/presentation/reservation/widgets/reservation_card.dart';

class ReservationManaging extends StatelessWidget {
  const ReservationManaging({super.key, required this.state});
  final ReservationState state;

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
          isAdmin: true,
        );
      },
    );
  }
}
