import 'reservation.dart';

class ReservationFilterDTO {
  final int? userId;
  final ReservationStatus? status;
  ReservationFilterDTO({this.userId, this.status});

  Map<String, dynamic> toQuery() {
    final map = <String, String>{};
    if (userId != null) map['userId'] = userId.toString();
    if (status != null) map['status'] = _statusToString(status!);
    return map;
  }

  String _statusToString(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return 'pending';
      case ReservationStatus.confirmed:
        return 'confirmed';
      case ReservationStatus.cancelled:
        return 'cancelled';
    }
  }
}

