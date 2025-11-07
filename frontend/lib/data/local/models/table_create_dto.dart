class TableCreateDTO {
  final int number;
  final int seats;
  TableCreateDTO({required this.number, required this.seats});
  Map<String, dynamic> toJson() => {
        'number': number,
        'seats': seats,
      };
}

