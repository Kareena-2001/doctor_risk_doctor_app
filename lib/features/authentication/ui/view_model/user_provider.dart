import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/values/app_constants.dart';

part 'user_provider.freezed.dart';

part 'user_provider.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required int doctorId,
    required String doctorNo,
    required String prefix,
    required String firstName,
    String? middleName,
    required String lastName,
    String? email,
    required String mobile,
  }) = _UserData;

  const UserData._();

  String get fullName {
    return [
      prefix,
      firstName,
      middleName,
      lastName,
    ].where((value) => value != null && value.trim().isNotEmpty).join(' ');
  }
}

@Riverpod(keepAlive: true)
class UserProvider extends _$UserProvider {
  @override
  Future<UserData?> build() async {
    return _getUserFromToken();
  }

  Future<UserData?> _getUserFromToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        debugPrint('[USER] No token found');
        return null;
      }

      if (JwtDecoder.isExpired(token)) {
        debugPrint('[USER] Token is expired');
        return null;
      }

      final decodedToken = JwtDecoder.decode(token);

      debugPrint('[USER] JWT decoded successfully');

      final doctorId = decodedToken['doctor_id'];

      return UserData(
        doctorId: doctorId is int
            ? doctorId
            : int.tryParse(doctorId?.toString() ?? '') ?? 0,
        doctorNo: decodedToken['doctor_no']?.toString() ?? '',
        prefix: decodedToken['prifix']?.toString() ?? '',
        firstName: decodedToken['first_name']?.toString() ?? '',
        middleName: decodedToken['middle_name']?.toString(),
        lastName: decodedToken['last_name']?.toString() ?? '',
        email: decodedToken['email']?.toString(),
        mobile: decodedToken['mobile_no']?.toString() ?? '',
      );
    } catch (e, stackTrace) {
      debugPrint('[USER] Error decoding JWT: $e');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth_token');
    await prefs.setBool(AppConstants.isLoginKey, false);

    state = const AsyncData(null);

    debugPrint('[USER] Session cleared');
  }

  Future<void> refreshUserData() async {
    state = const AsyncLoading();

    final user = await _getUserFromToken();

    state = AsyncData(user);
  }

  void clearUserData() {
    state = const AsyncData(null);
  }
}
