import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/dio_client.dart';
final baseServiceProvider = Provider(BaseService.new);
class BaseService  {
  BaseService(this.ref);
  final Ref ref;
  DioClient get client => ref.read(dioProvider);
}
