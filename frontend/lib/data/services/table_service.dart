import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/data/services/base_service.dart';
import 'package:flutter_restaurant_app/data/local/models/table.dart';
import 'package:flutter_restaurant_app/data/local/models/table_create_dto.dart';
import 'package:flutter_restaurant_app/data/local/models/table_update_dto.dart';

final tableServiceProvider = Provider(TableService.new);

class TableService extends BaseService {
  @override
  final Ref ref;
  TableService(this.ref) : super(ref);

  Future<RestaurantTable> create({required TableCreateDTO dto}) async {
    try {
      final response = await client.post(path: '/tables', args: dto.toJson());
      return RestaurantTable.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RestaurantTable>> getAll() async {
    try {
      final response = await client.get(path: '/tables');
      final list = response.data as List<dynamic>;
      return list.map((e) => RestaurantTable.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantTable> getById(int id) async {
    try {
      final response = await client.get(path: '/tables/$id');
      return RestaurantTable.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantTable> update({required int id, required TableUpdateDTO dto}) async {
    try {
      final response = await client.put(path: '/tables/$id', args: dto.toJson());
      return RestaurantTable.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(int id) async {
    try {
      final response = await client.delete(path: '/tables/$id');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}

