import 'package:json_annotation/json_annotation.dart';

part 'table.g.dart';

@JsonSerializable()
class RestaurantTable {
  final int id;
  final int number;
  final int seats;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RestaurantTable({
    required this.id,
    required this.number,
    required this.seats,
    this.createdAt,
    this.updatedAt,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) =>
      _$RestaurantTableFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantTableToJson(this);

  RestaurantTable copyWith({
    int? id,
    int? number,
    int? seats,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantTable(
      id: id ?? this.id,
      number: number ?? this.number,
      seats: seats ?? this.seats,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
