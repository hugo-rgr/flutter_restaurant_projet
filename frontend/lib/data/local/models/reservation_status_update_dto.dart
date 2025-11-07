import 'reservation.dart';

class ReservationStatusUpdateDTO {
  final ReservationStatus status;
  ReservationStatusUpdateDTO({required this.status});

  Map<String, dynamic> toJson() => {
        'status': _statusToString(status),
      };

  String _statusToString(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return 'pending';
      case ReservationStatus.confirmed:
        return 'confirmed';
      case ReservationStatus.cancelled:
        return 'cancelled';
      case ReservationStatus.rejected:
        return 'rejected';
    }
  }
}

