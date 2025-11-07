import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/data/dao/tables_dao.dart';
import 'package:flutter_restaurant_app/data/local/models/table.dart';
import 'package:flutter_restaurant_app/data/local/models/table_create_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/table_update_dto.dart';

import '../data/local/models/available_table_request_dto.dart';

final tableManagerProvider = Provider(TableManager.new);

class TableManager {
  TableManager(this.ref);
  final Ref ref;
  TablesDao get _dao => ref.read(tablesDaoProvider);

  Future<RestaurantTable> create({required TableCreateDTO dto}) => _dao.create(dto: dto);
  Future<List<RestaurantTable>> list() => _dao.getAll();
  Future<RestaurantTable> detail(int id) => _dao.getById(id);
  Future<RestaurantTable> edit({required int id, required TableUpdateDTO dto}) => _dao.update(id: id, dto: dto);
  Future<Map<String, dynamic>> remove(int id) => _dao.delete(id);
  Future<List<RestaurantTable>> getAvailableTables({
    required AvailableTableRequestDto availableTableRequestDto,
  }) => _dao.getAvailableTables(
        availableTableRequestDto: availableTableRequestDto,
      );
}

