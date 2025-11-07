class ReservationAvailabilityQuery {
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfGuests;

  ReservationAvailabilityQuery({
    required this.startDate,
    required this.endDate,
    required this.numberOfGuests,
  });

  Map<String, dynamic> toQuery() => {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'numberOfGuests': numberOfGuests.toString(),
      };
}

class AvailabilitySummaryQuery {
  final DateTime startDate;
  final DateTime endDate;

  AvailabilitySummaryQuery({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toQuery() => {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };
}

