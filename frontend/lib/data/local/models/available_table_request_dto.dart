class AvailableTableRequestDto {
  final String date;
  final String timeSlotId;
  final String seats;

  AvailableTableRequestDto({
    required this.date,
    required this.timeSlotId,
    required this.seats,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timeSlotId': timeSlotId,
      'seats': seats,
    };
  }
}
