import 'dart:async';

import 'package:Doctors_App/features/community/model/refer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// TODO: point this at the Dio instance / interceptor stack the rest of the
// app already uses (e.g. the shared `dioProvider` in core/network). Wiring
// a fresh Dio() here so this file compiles standalone — swap it out.
final _referralDioProvider = Provider<Dio>((ref) {
  return Dio();
});

abstract class ReferralRepository {
  Future<ReferralSummary> getReferralSummary();
  Future<void> submitReferral(ReferralFormData data);
}

class ReferralRepositoryImpl implements ReferralRepository {
  ReferralRepositoryImpl(this._dio);

  final Dio _dio;

  // TODO: confirm these against the actual backend routes.
  static const String _summaryEndpoint = '/referrals/summary';
  static const String _submitEndpoint = '/referrals';

  @override
  Future<ReferralSummary> getReferralSummary() async {
    final response = await _dio.get(_summaryEndpoint);
    return ReferralSummary.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> submitReferral(ReferralFormData data) async {
    await _dio.post(_submitEndpoint, data: data.toJson());
  }
}

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  return ReferralRepositoryImpl(ref.read(_referralDioProvider));
});

final referralSummaryProvider =
AsyncNotifierProvider<ReferralViewModel, ReferralSummary>(
  ReferralViewModel.new,
);

class ReferralViewModel extends AsyncNotifier<ReferralSummary> {
  late final ReferralRepository _repository;

  @override
  FutureOr<ReferralSummary> build() {
    _repository = ref.read(referralRepositoryProvider);
    return _repository.getReferralSummary();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<ReferralSummary>().copyWithPrevious(state);
    state = await AsyncValue.guard(_repository.getReferralSummary);
  }

  /// Returns null on success, or an error message to show the user.
  Future<String?> submitReferral(ReferralFormData data) async {
    try {
      await _repository.submitReferral(data);
      await refresh();
      return null;
    } on DioException catch (e) {
      return e.response?.data is Map && (e.response?.data['message'] != null)
          ? e.response!.data['message'].toString()
          : 'Could not submit referral. Please try again.';
    } catch (_) {
      return 'Could not submit referral. Please try again.';
    }
  }
}