import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'table.dart';

part 'reservation.g.dart';

enum ReservationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Reservation {
  final int id;
  final int userId;
  final int tableId;
  final int numberOfGuests;
  final DateTime startDate;
  final DateTime endDate;
  final ReservationStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final RestaurantTable? table;

  Reservation({
    required this.id,
    required this.userId,
    required this.tableId,
    required this.numberOfGuests,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.table,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  Reservation copyWith({
    int? id,
    int? userId,
    int? tableId,
    int? numberOfGuests,
    DateTime? startDate,
    DateTime? endDate,
    ReservationStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    RestaurantTable? table,
  }) {
    return Reservation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      table: table ?? this.table,
    );
  }

  String get statusLabel {
    switch (status) {
      case ReservationStatus.pending:
        return 'En attente';
      case ReservationStatus.confirmed:
        return 'Confirmée';
      case ReservationStatus.cancelled:
        return 'Annulée';
    }
  }
}
