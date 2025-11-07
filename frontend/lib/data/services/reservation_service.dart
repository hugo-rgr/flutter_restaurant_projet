import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/data/services/base_service.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_create_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_update_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_availability_query.dart';
import 'package:flutter_restaurant_app/data/local/models/table.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation_status_update_dto.dart';

final reservationServiceProvider = Provider(ReservationService.new);

class ReservationService extends BaseService {
  @override
  final Ref ref;
  ReservationService(this.ref) : super(ref);

  /// Crée une réservation
  Future<Reservation> create({required ReservationCreateDTO dto}) async {
    try {
      final response = await client.post(
        path: '/reservations',
        args: dto.toJson(),
      );
      return Reservation.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }


  Future<List<Reservation>> adminGetAll() async {
    try {
      final response = await client.get(
        path: '/reservations/all',

      );
      print(response);
      print('ici');
      final list = response.data as List<dynamic>;

      return list
          .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }



  /// Liste des réservations (userId & status optionnels) – DTO filtre supprimé car pas d'autres filtres prévus.
  Future<List<Reservation>> getAll({
    int? userId,
    ReservationStatus? status,
  }) async {
    try {
      final response = await client.get(
        path: '/reservations',
        args: {
          if (userId != null) 'userId': userId.toString(),
          if (status != null) 'status': _statusToString(status),
        },
      );
      print(response);
      print('ici');
      final list = response.data as List<dynamic>;

      return list
          .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Récupère une réservation par son identifiant
  Future<Reservation> getById(int id) async {
    try {
      final response = await client.get(path: '/reservations/$id');
      return Reservation.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Met à jour une réservation (propriétaire seulement)
  Future<Reservation> update({
    required int id,
    required ReservationUpdateDTO dto,
  }) async {
    try {
      final response = await client.put(
        path: '/reservations/$id',
        args: dto.toJson(),
      );
      return Reservation.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Met à jour uniquement le statut (hôte / admin)
  Future<Reservation> updateStatus({
    required int id,
    required ReservationStatus status,
  }) async {
    try {
      final response = await client.patch(
        path: '/reservations/$id/status',
        args: {'status': _statusToString(status)},
      );
      return Reservation.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Supprime une réservation (propriétaire seulement)
  Future<Map<String, dynamic>> delete(int id) async {
    try {
      final response = await client.delete(path: '/reservations/$id');
      return (response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Vérifie la disponibilité des tables sur un créneau
  Future<ReservationAvailabilityResult> checkAvailability({
    required ReservationAvailabilityQuery query,
  }) async {
    try {
      final response = await client.get(
        path: '/reservations/availability',
        args: query.toQuery(),
      );
      final data = response.data as Map<String, dynamic>;
      final tables =
          (data['tables'] as List<dynamic>)
              .map((e) => RestaurantTable.fromJson(e as Map<String, dynamic>))
              .toList();
      return ReservationAvailabilityResult(
        available: data['available'] as bool,
        tables: tables,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Résumé global de disponibilité sur une plage de dates
  Future<AvailabilitySummary> availabilitySummary({
    required AvailabilitySummaryQuery query,
  }) async {
    try {
      final response = await client.get(
        path: '/reservations/availability-summary',
        args: query.toQuery(),
      );
      return AvailabilitySummary.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Met à jour le statut avec un DTO status (facultatif, peut être simplifié en passant directement l'enum)
  Future<Reservation> updateStatusDTO({
    required int id,
    required ReservationStatusUpdateDTO dto,
  }) async {
    try {
      final response = await client.patch(
        path: '/reservations/$id/status',
        args: dto.toJson(),
      );
      return Reservation.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
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

class ReservationAvailabilityResult {
  final bool available;
  final List<RestaurantTable> tables;
  ReservationAvailabilityResult({
    required this.available,
    required this.tables,
  });
}

class AvailabilitySummary {
  final int totalTables;
  final int totalSeats;
  final int reservedSeats;
  final int availableSeats;
  final int reservedTables;
  final int availableTables;

  AvailabilitySummary({
    required this.totalTables,
    required this.totalSeats,
    required this.reservedSeats,
    required this.availableSeats,
    required this.reservedTables,
    required this.availableTables,
  });

  factory AvailabilitySummary.fromJson(Map<String, dynamic> json) =>
      AvailabilitySummary(
        totalTables: json['totalTables'] as int,
        totalSeats: json['totalSeats'] as int,
        reservedSeats: json['reservedSeats'] as int,
        availableSeats: json['availableSeats'] as int,
        reservedTables: json['reservedTables'] as int,
        availableTables: json['availableTables'] as int,
      );
}
