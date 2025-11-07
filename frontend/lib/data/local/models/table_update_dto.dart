class TableUpdateDTO {
  final int? number;
  final int? seats;
  TableUpdateDTO({this.number, this.seats});
  TableUpdateDTO copyWith({int? number, int? seats}) => TableUpdateDTO(
        number: number ?? this.number,
        seats: seats ?? this.seats,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (number != null) map['number'] = number;
    if (seats != null) map['seats'] = seats;
    return map;
  }
}

