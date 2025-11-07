import 'reservation.dart';

class ReservationUpdateDTO {
  final int? tableId;
  final int? numberOfGuests;
  final DateTime? startDate;
  final DateTime? endDate;
  final ReservationStatus? status;

  ReservationUpdateDTO({
    this.tableId,
    this.numberOfGuests,
    this.startDate,
    this.endDate,
    this.status,
  });

  ReservationUpdateDTO copyWith({
    int? tableId,
    int? numberOfGuests,
    DateTime? startDate,
    DateTime? endDate,
    ReservationStatus? status,
  }) => ReservationUpdateDTO(
        tableId: tableId ?? this.tableId,
        numberOfGuests: numberOfGuests ?? this.numberOfGuests,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tableId != null) map['tableId'] = tableId;
    if (numberOfGuests != null) map['numberOfGuests'] = numberOfGuests;
    if (startDate != null) map['startDate'] = startDate!.toIso8601String();
    if (endDate != null) map['endDate'] = endDate!.toIso8601String();
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
      case ReservationStatus.rejected:
        return 'rejected';
    }
  }
}

