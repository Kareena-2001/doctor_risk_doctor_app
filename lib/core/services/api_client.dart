import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routing/routes.dart';
import '../../routing/router.dart';

import '../config/environment_provider.dart';
import '../exceptions/app_exception.dart';

part 'api_client.g.dart';

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final includeAuth = options.extra['includeAuth'] as bool? ?? true;

    if (includeAuth) {
      final token = await _getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['token'] = token;
      }
    }

    handler.next(options);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

class _SessionInterceptor extends Interceptor {
  bool _isHandlingExpiry = false;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final jsonStatus = data['status'];

      if (jsonStatus == 401 && !_isHandlingExpiry) {
        debugPrint(' Session expired - status 401');
        _handleSessionExpired();
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 && !_isHandlingExpiry) {
      debugPrint(' HTTP 401 Unauthorized');
      _handleSessionExpired();
    }
    handler.next(err);
  }

  Future<void> _handleSessionExpired() async {
    if (_isHandlingExpiry) return;
    _isHandlingExpiry = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('auth_token');
      await prefs.remove('user_id');
      await prefs.remove('user_vendor_employee_code');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
      await prefs.remove('user_mobile');
      await prefs.remove('user_image');
      await prefs.remove('user_application_status');
      await prefs.remove('user_ol_generate');
      await prefs.setBool('isLogin', false);

      debugPrint(' Session data cleared');

      router.go(Routes.login);
      debugPrint(' Navigated to login screen');
    } catch (e) {
      debugPrint(' Error handling session expiry: $e');
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
        _isHandlingExpiry = false;
      });
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌── REQUEST ──────────────────────────────────────');
    debugPrint('│ ${options.method} ${options.uri}');
    debugPrint('│ Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('│ Body: ${options.data}');
    }
    debugPrint('└─────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌── RESPONSE ─────────────────────────────────────');
    debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('│ Data: ${response.data}');
    debugPrint('└─────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌── ERROR ────────────────────────────────────────');
    debugPrint('│ ${err.requestOptions.method} ${err.requestOptions.uri}');
    debugPrint('│ ${err.type}');
    debugPrint('│ ${err.message}');
    if (err.response != null) {
      debugPrint('│ Status: ${err.response?.statusCode}');
      debugPrint('│ Data: ${err.response?.data}');
    }
    debugPrint('└─────────────────────────────────────────────────');
    handler.next(err);
  }
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
}

class ApiClient {
  final Dio _dio;
  final String baseUrl;

  ApiClient({Dio? dio, required this.baseUrl}) : _dio = dio ?? Dio() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      validateStatus: (status) => true,
    );

    _dio.interceptors.add(_AuthInterceptor());
    _dio.interceptors.add(_SessionInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(_LoggingInterceptor());
    }
  }

  Future<Map<String, dynamic>> post({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? formData,
    bool includeAuth = true,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: formData ?? body,
        options: Options(
          headers: headers,
          contentType: formData != null
              ? Headers.formUrlEncodedContentType
              : Headers.jsonContentType,
          extra: {'includeAuth': includeAuth},
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    bool includeAuth = true,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers, extra: {'includeAuth': includeAuth}),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> put({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers, extra: {'includeAuth': includeAuth}),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> delete({
    required String url,
    Map<String, String>? headers,
    bool includeAuth = true,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(headers: headers, extra: {'includeAuth': includeAuth}),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> patch({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers, extra: {'includeAuth': includeAuth}),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> postMultipart({
    required String url,
    required Map<String, String> fields,
    required Map<String, File> files,
    Map<String, List<File>>? fileArrays,
    Map<String, String>? headers,
    bool includeAuth = true,
  }) async {
    try {
      final formData = FormData();

      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });

      for (var entry in files.entries) {
        formData.files.add(
          MapEntry(
            entry.key,
            await MultipartFile.fromFile(
              entry.value.path,
              filename: entry.value.path.split('/').last,
            ),
          ),
        );
      }

      if (fileArrays != null) {
        for (var entry in fileArrays.entries) {
          for (var file in entry.value) {
            formData.files.add(
              MapEntry(
                entry.key,
                await MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
            if (kDebugMode) {
              debugPrint('Added ${entry.key}: ${file.path.split('/').last}');
            }
          }
        }
      }

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
          extra: {'includeAuth': includeAuth},
          sendTimeout: const Duration(seconds: 60),
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        statusCode: 0,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    try {
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return data;
      } else {
        throw ApiException(
          statusCode: response.statusCode ?? 0,
          message: data['msg'] ?? data['message'] ?? 'Request failed',
          data: data,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        statusCode: response.statusCode ?? 0,
        message: 'Failed to parse response: ${e.toString()}',
      );
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          statusCode: 408,
          message: 'Request timeout. Please check your connection.',
        );

      case DioExceptionType.connectionError:
        return ApiException(
          statusCode: 0,
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        final response = error.response;
        if (response?.data is Map<String, dynamic>) {
          final data = response!.data as Map<String, dynamic>;
          return ApiException(
            statusCode: response.statusCode ?? 0,
            message: data['msg'] ?? data['message'] ?? 'Server error occurred',
            data: data,
          );
        }
        return ApiException(
          statusCode: response?.statusCode ?? 0,
          message: 'Server error occurred',
        );

      case DioExceptionType.cancel:
        return ApiException(statusCode: 0, message: 'Request cancelled');

      case DioExceptionType.badCertificate:
        return ApiException(
          statusCode: 0,
          message: 'Security certificate error',
        );

      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return ApiException(statusCode: 0, message: 'No internet connection');
        }
        return ApiException(
          statusCode: 0,
          message: error.message ?? 'Network error occurred',
        );
    }
  }

  void dispose() {
    _dio.close();
  }
}
