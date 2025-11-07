import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dao/reservation_dao.dart';
import '../data/local/models/reservation.dart';
import '../data/local/models/reservation_create_dto.dart';
import '../data/local/models/reservation_update_dto.dart';
import '../data/local/models/reservation_availability_query.dart';
import '../data/services/reservation_service.dart';
import '../data/local/models/reservation_status_update_dto.dart';

final reservationManagerProvider = Provider(ReservationManager.new);

class ReservationManager {
  ReservationManager(this.ref);
  final Ref ref;
  ReservationDao get _dao => ref.read(reservationDaoProvider);

  Future<Reservation> create({required ReservationCreateDTO dto}) => _dao.create(dto: dto);
  Future<List<Reservation>> list({int? userId, ReservationStatus? status}) =>
      _dao.getAll(userId: userId, status: status);
  Future<Reservation> detail(int id) => _dao.getById(id);
  Future<Reservation> edit({required int id, required ReservationUpdateDTO dto}) =>
      _dao.update(id: id, dto: dto);
  Future<Reservation> changeStatus({required int id, required ReservationStatus status}) =>
      _dao.updateStatus(id: id, status: status);
  Future<Map<String, dynamic>> remove(int id) => _dao.delete(id);
  Future<ReservationAvailabilityResult> availability({required ReservationAvailabilityQuery query}) =>
      _dao.checkAvailability(query: query);
  Future<AvailabilitySummary> availabilitySummary({required AvailabilitySummaryQuery query}) =>
      _dao.availabilitySummary(query: query);
  Future<Reservation> changeStatusDTO({required int id, required ReservationStatusUpdateDTO dto}) =>
      _dao.updateStatusDTO(id: id, dto: dto);

  Future<List<Reservation>> adminGetAll() => _dao.adminGetAll();
}
