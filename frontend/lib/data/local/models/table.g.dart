// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantTable _$RestaurantTableFromJson(Map<String, dynamic> json) =>
    RestaurantTable(
      id: (json['id'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      seats: (json['seats'] as num).toInt(),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RestaurantTableToJson(RestaurantTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'seats': instance.seats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
