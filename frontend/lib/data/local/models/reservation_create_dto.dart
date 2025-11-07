class ReservationCreateDTO {
  final int tableId;
  final int numberOfGuests;
  final DateTime startDate;
  final DateTime endDate;
  final String timeSlotId;

  ReservationCreateDTO({
    required this.tableId,
    required this.numberOfGuests,
    required this.startDate,
    required this.endDate,
    required this.timeSlotId,
  });

  Map<String, dynamic> toJson() => {
        'tableId': tableId,
        'numberOfGuests': numberOfGuests,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'timeSlotId': timeSlotId,
      };
}

