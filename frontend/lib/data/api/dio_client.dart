import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/prefs/prefs_service.dart';
import 'base_rest_client.dart';
import 'dart:io' show Platform;

final dioProvider = Provider<DioClient>(
      (ref) => DioClient(
    ref,
    dotenv.env[Platform.isIOS ? "API_LOCAL_URL" : "API_BASE_URL"]!,
  ),
);

class DioClient implements BaseRestClient {
  DioClient(this.ref, this.baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _initializeInterceptors();
  }
  PreferencesService get preferences => ref.read(prefsProvider);
  final Ref ref;
  final String baseUrl;
  late Dio _dio;
  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await preferences.getString(PersistStoreKey.token);
          options.headers.addAll({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
          return handler.next(options);
        },
        onResponse: (response, handler) {

          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<Response> delete({
    required String path,
    dynamic args,
    Map<String, dynamic>? headers,
  }) async {
    return _dio.delete(path, data: args, options: Options(headers: headers));
  }

  @override
  Future<Response> post({
    required String path,
    dynamic args,
    Map<String, dynamic>? headers,
  }) async {
    return _dio.post(path, data: args, options: Options(headers: headers));
  }

  @override
  Future<Response> get({
    required String path,
    dynamic args,
    Map<String, dynamic>? headers,
  }) async {
    return _dio.get(
      path,
      queryParameters: args,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> patch({
    required String path,
    dynamic args,
    Map<String, dynamic>? headers,
  }) async {
    return _dio.patch(path, data: args, options: Options(headers: headers));
  }

  @override
  Future<Response> put({
    required String path,
    dynamic args,
    Map<String, dynamic>? headers,
  }) async {
    return _dio.put(path, data: args, options: Options(headers: headers));
  }
}
