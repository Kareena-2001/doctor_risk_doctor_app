import 'dart:convert';
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
    // validateStatus is set to always return true (see below), so 401s
    // arrive here, not in onError. Decode the body defensively — some
    // endpoints don't send application/json content-type.
    dynamic rawData = response.data;
    if (rawData is String) {
      try {
        rawData = rawData.trim().isEmpty ? null : jsonDecode(rawData);
      } catch (_) {
        rawData = null;
      }
    }

    final bodyLooksUnauthorized =
        rawData is Map<String, dynamic> &&
        (rawData['status'] == 401 ||
            rawData['code'] == 401 ||
            ((rawData['status'] == false || rawData['success'] == false) &&
                response.statusCode == 401));

    if ((response.statusCode == 401 || bodyLooksUnauthorized) &&
        !_isHandlingExpiry) {
      debugPrint(' Session expired - 401');
      _handleSessionExpired();
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
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
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
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
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
    } catch (e, stackTrace) {
      if (e is ApiException) rethrow;
      debugPrint('Unexpected Error in ApiClient: $e');
      debugPrint('Stack Trace:\n$stackTrace');
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
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
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
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
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
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
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 0, message: _friendlyMessage(0, null));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Response handling
  // ─────────────────────────────────────────────────────────────

  /// Parses the raw response, decodes it if the server didn't send
  /// proper JSON content-type, and throws a friendly [ApiException]
  /// for every failure case: business failure (status/success == false),
  /// HTTP error status, validation errors, or an unparseable body.
  Map<String, dynamic> _handleResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    dynamic rawData = response.data;

    if (rawData is String) {
      if (rawData.trim().isEmpty) {
        throw ApiException(
          statusCode: statusCode,
          message: _friendlyMessage(statusCode, null),
        );
      }
      try {
        rawData = jsonDecode(rawData);
      } catch (_) {
        throw ApiException(
          statusCode: statusCode,
          message: _friendlyMessage(statusCode, null),
        );
      }
    }

    if (rawData is! Map<String, dynamic>) {
      throw ApiException(
        statusCode: statusCode,
        message: _friendlyMessage(statusCode, null),
      );
    }

    final data = rawData;

    // Backend is inconsistent: some endpoints use {"status": true, "msg": ...},
    // others use {"success": true, "message": ...}. Accept either.
    final bodyOk = data['status'] == true || data['success'] == true;
    final httpOk = statusCode >= 200 && statusCode < 300;

    if (bodyOk && httpOk) {
      return data;
    }

    final serverMessage = _extractServerMessage(data);
    final validationMessage = _extractValidationMessage(data);

    throw ApiException(
      statusCode: statusCode,
      message: _friendlyMessage(statusCode, validationMessage ?? serverMessage),
      data: data,
    );
  }

  String? _extractServerMessage(Map<String, dynamic> data) {
    final message = data['msg'] ?? data['message'] ?? data['error'];
    if (message is String && message.trim().isNotEmpty) return message;
    return null;
  }

  /// Handles Laravel-style validation error bodies:
  /// {"errors": {"email": ["The email field is required."]}}
  String? _extractValidationMessage(Map<String, dynamic> data) {
    final errors = data['errors'];
    if (errors is Map) {
      for (final value in errors.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
        if (value is String && value.trim().isNotEmpty) {
          return value;
        }
      }
    }
    return null;
  }

  /// Server message wins when present; otherwise falls back to a
  /// consistent, user-facing message per status code.
  String _friendlyMessage(int statusCode, String? serverMessage) {
    if (serverMessage != null && serverMessage.trim().isNotEmpty) {
      return serverMessage;
    }
    switch (statusCode) {
      case 0:
        return 'No internet connection. Please check your network and try again.';
      case 400:
        return 'Something went wrong with that request. Please try again.';
      case 401:
        return 'Your session has expired. Please log in again.';
      case 403:
        return "You don't have permission to do that.";
      case 404:
        return "We couldn't find what you were looking for.";
      case 408:
        return 'Request timed out. Please check your connection and try again.';
      case 422:
        return 'Please check the information you entered and try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      default:
        if (statusCode >= 500) {
          return 'Something went wrong on our end. Please try again in a moment.';
        }
        return 'Something went wrong. Please try again.';
    }
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          statusCode: 408,
          message: _friendlyMessage(408, null),
        );

      case DioExceptionType.connectionError:
        return ApiException(statusCode: 0, message: _friendlyMessage(0, null));

      case DioExceptionType.badResponse:
        // With validateStatus always true, this branch rarely fires —
        // 4xx/5xx go through _handleResponse instead. Kept as a safety net.
        final response = error.response;
        final statusCode = response?.statusCode ?? 0;
        dynamic rawData = response?.data;

        if (rawData is String) {
          try {
            rawData = rawData.trim().isEmpty ? null : jsonDecode(rawData);
          } catch (_) {
            rawData = null;
          }
        }

        if (rawData is Map<String, dynamic>) {
          final serverMessage = _extractServerMessage(rawData);
          final validationMessage = _extractValidationMessage(rawData);
          return ApiException(
            statusCode: statusCode,
            message: _friendlyMessage(
              statusCode,
              validationMessage ?? serverMessage,
            ),
            data: rawData,
          );
        }

        return ApiException(
          statusCode: statusCode,
          message: _friendlyMessage(statusCode, null),
        );

      case DioExceptionType.cancel:
        return ApiException(statusCode: 0, message: 'Request cancelled');

      case DioExceptionType.badCertificate:
        return ApiException(
          statusCode: 0,
          message: 'Security certificate error. Please try again later.',
        );

      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return ApiException(
            statusCode: 0,
            message: _friendlyMessage(0, null),
          );
        }
        return ApiException(statusCode: 0, message: _friendlyMessage(0, null));
    }
  }

  void dispose() {
    _dio.close();
  }
}
