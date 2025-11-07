import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/reservation_service.dart';
import '../local/models/reservation.dart';
import '../local/models/reservation_create_dto.dart';
import '../local/models/reservation_update_dto.dart';
import '../local/models/reservation_availability_query.dart';
import '../local/models/reservation_status_update_dto.dart';

final reservationDaoProvider = Provider(ReservationDao.new);

class ReservationDao {
  ReservationDao(this.ref);
  final Ref ref;
  ReservationService get _service => ref.read(reservationServiceProvider);

  Future<Reservation> create({required ReservationCreateDTO dto}) =>
      _service.create(dto: dto);

  Future<List<Reservation>> getAll({int? userId, ReservationStatus? status}) =>
      _service.getAll(userId: userId, status: status);

  Future<Reservation> getById(int id) => _service.getById(id);

  Future<Reservation> update({required int id, required ReservationUpdateDTO dto}) =>
      _service.update(id: id, dto: dto);

  Future<Reservation> updateStatus({required int id, required ReservationStatus status}) =>
      _service.updateStatus(id: id, status: status);

  Future<Reservation> updateStatusDTO({required int id, required ReservationStatusUpdateDTO dto}) =>
      _service.updateStatusDTO(id: id, dto: dto);

  Future<Map<String, dynamic>> delete(int id) => _service.delete(id);

  Future<ReservationAvailabilityResult> checkAvailability({required ReservationAvailabilityQuery query}) =>
      _service.checkAvailability(query: query);

  Future<AvailabilitySummary> availabilitySummary({required AvailabilitySummaryQuery query}) =>
      _service.availabilitySummary(query: query);

  Future<List<Reservation>> adminGetAll() => _service.adminGetAll();
}
