import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/prefs/prefs_service.dart';
import 'base_rest_client.dart';
import 'dart:io' show Platform;

final dioProvider = Provider<DioClient>(
  (ref) {
    // Utiliser API_BASE_URL pour Android (10.0.2.2) et API_LOCAL_URL pour iOS
    final baseUrl = Platform.isIOS
        ? (dotenv.env["API_LOCAL_URL"] ?? "http://localhost:3000")
        : (dotenv.env["API_BASE_URL"] ?? "http://10.0.2.2:3000");

    print('🌐 API Base URL: $baseUrl');
    return DioClient(ref, baseUrl);
  },
);

class DioClient implements BaseRestClient {
  DioClient(this.ref, this.baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    ));
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
              'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
            });
          print('📤 ${options.method} ${options.baseUrl}${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 Response: ${response.data}');
          print('✅ ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print('❌ Error: ${error.type}');
          return handler.next(error);
        },

        /*onRequest: (options, handler) async {

          final token = await preferences.getString(PersistStoreKey.token);
          options.headers.addAll({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

          // N'ajouter le token que s'il existe
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('📤 ${options.method} ${options.baseUrl}${options.path}');
          print('📝 Headers: ${options.headers}');
          if (options.data != null) {
            print('📦 Data: ${options.data}');
          }
          if (options.queryParameters.isNotEmpty) {
            print('🔍 Query: ${options.queryParameters}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ ${response.statusCode} ${response.requestOptions.path}');
          print('📥 Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print('❌ Error: ${error.type}');
          print('📍 URL: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
          print('💬 Message: ${error.message}');
          if (error.response != null) {
            print('📥 Response: ${error.response?.data}');
            print('🔢 Status: ${error.response?.statusCode}');
          }
          return handler.next(error);
        },
      ),*/
      )
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
