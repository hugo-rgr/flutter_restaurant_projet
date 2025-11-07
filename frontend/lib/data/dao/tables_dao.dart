import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/data/services/table_service.dart';
import 'package:flutter_restaurant_app/data/local/models/table.dart';
import 'package:flutter_restaurant_app/data/local/models/table_create_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/table_update_dto.dart';

final tablesDaoProvider = Provider(TablesDao.new);

class TablesDao {
  TablesDao(this.ref);
  final Ref ref;
  TableService get _service => ref.read(tableServiceProvider);

  Future<RestaurantTable> create({required TableCreateDTO dto}) => _service.create(dto: dto);
  Future<List<RestaurantTable>> getAll() => _service.getAll();
  Future<RestaurantTable> getById(int id) => _service.getById(id);
  Future<RestaurantTable> update({required int id, required TableUpdateDTO dto}) => _service.update(id: id, dto: dto);
  Future<Map<String, dynamic>> delete(int id) => _service.delete(id);
}

