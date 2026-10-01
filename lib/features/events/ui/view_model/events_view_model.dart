import 'package:Doctors_App/features/events/model/payment_summary_model.dart';
import 'package:Doctors_App/features/events/repository/events_repository.dart';
import 'package:Doctors_App/features/events/ui/state/events_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_view_model.g.dart';

String _cleanError(Object error) =>
    error.toString().replaceFirst('Exception: ', '');

@riverpod
class EventsViewModel extends _$EventsViewModel {
  String _upcomingType = '';
  String _upcomingQuery = '';
  String _pastType = '';
  String _pastQuery = '';
  bool _loadingMoreUpcoming = false;
  bool _loadingMorePast = false;
  bool _loadingMoreCollaborations = false;

  @override
  EventsState build() {
    return const EventsState();
  }

  Future<bool> addCollaboration({
    required String collaborationTarget,
    required String fullName,
    String? emailId,
    required String mobileNo,
    required String organisation,
    String? modeOfEvent,
    String? preferredDate,
    String? preferredTime,
    String? stateId,
    String? cityId,
    String? area,
    String? purpose,
  }) async {
    state = state.copyWith(addCollaboration: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .addCollaboration(
            collaborationTarget: collaborationTarget,
            fullName: fullName,
            emailId: emailId,
            mobileNo: mobileNo,
            organisation: organisation,
            modeOfEvent: modeOfEvent,
            preferredDate: preferredDate,
            preferredTime: preferredTime,
            stateId: stateId,
            cityId: cityId,
            area: area,
            purpose: purpose,
          ),
    );

    if (result.hasError) {
      state = state.copyWith(
        addCollaboration: AsyncValue<void>.error(
          result.error!,
          result.stackTrace!,
        ),
      );
      return false;
    }

    final response = result.value!;

    if (!response.status) {
      state = state.copyWith(
        addCollaboration: AsyncValue<void>.error(
          Exception(response.msg),
          StackTrace.current,
        ),
      );
      return false;
    }

    state = state.copyWith(addCollaboration: const AsyncValue<void>.data(null));

    return true;
  }

  Future<void> collaborationList() async {
    _loadingMoreCollaborations = false;
    state = state.copyWith(collaborationList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).collaborationList(),
    );

    state = state.copyWith(collaborationList: result);
  }

  Future<void> refreshCollaborationList() => collaborationList();

  Future<void> loadMoreCollaborations() async {
    final current = state.collaborationList.valueOrNull;
    final lastPage = current?.lastPage;
    if (current == null ||
        _loadingMoreCollaborations ||
        lastPage == null ||
        current.currentPage == null ||
        current.currentPage! >= lastPage) {
      return;
    }

    _loadingMoreCollaborations = true;
    try {
      final next = await ref
          .read(eventsRepositoryProvider)
          .collaborationList(page: current.currentPage! + 1);
      state = state.copyWith(
        collaborationList: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      _loadingMoreCollaborations = false;
    }
  }

  Future<void> fetchDoctorDetails() async {
    state = state.copyWith(doctorDetails: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).getDoctorDetails(),
    );

    state = state.copyWith(doctorDetails: result);
  }

  Future<void> fetchUpcomingEvents({
    String type = '',
    String query = '',
  }) async {
    _upcomingType = type;
    _upcomingQuery = query;
    _loadingMoreUpcoming = false;
    state = state.copyWith(upcomingEvents: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .eventList(search: 'upcoming', tab: type, title: query),
    );

    state = state.copyWith(upcomingEvents: result);
  }

  Future<void> fetchPastEvents({String type = '', String query = ''}) async {
    _pastType = type;
    _pastQuery = query;
    _loadingMorePast = false;
    state = state.copyWith(pastEvents: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .eventList(search: 'past', tab: type, title: query),
    );

    state = state.copyWith(pastEvents: result);
  }

  Future<void> refreshUpcomingEvents({String type = '', String query = ''}) =>
      fetchUpcomingEvents(type: type, query: query);

  Future<void> refreshPastEvents({String type = '', String query = ''}) =>
      fetchPastEvents(type: type, query: query);

  Future<void> loadMoreUpcomingEvents() async {
    final current = state.upcomingEvents.valueOrNull;
    if (current == null ||
        _loadingMoreUpcoming ||
        current.currentPage >= current.lastPage) {
      return;
    }

    _loadingMoreUpcoming = true;
    try {
      final next = await ref
          .read(eventsRepositoryProvider)
          .eventList(
            search: 'upcoming',
            tab: _upcomingType,
            title: _upcomingQuery,
            page: current.currentPage + 1,
          );
      state = state.copyWith(
        upcomingEvents: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      _loadingMoreUpcoming = false;
    }
  }

  Future<void> loadMorePastEvents() async {
    final current = state.pastEvents.valueOrNull;
    if (current == null ||
        _loadingMorePast ||
        current.currentPage >= current.lastPage) {
      return;
    }

    _loadingMorePast = true;
    try {
      final next = await ref
          .read(eventsRepositoryProvider)
          .eventList(
            search: 'past',
            tab: _pastType,
            title: _pastQuery,
            page: current.currentPage + 1,
          );
      state = state.copyWith(
        pastEvents: AsyncData(
          next.copyWith(data: [...current.data, ...next.data]),
        ),
      );
    } finally {
      _loadingMorePast = false;
    }
  }

  Future<bool> submitEventRegistration({
    required int eventId,
    required int doctorId,
    required String fullName,
    required String emailId,
    required String mobileNo,
    required String membershipStatus,
  }) async {
    state = state.copyWith(registerEvent: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .registerEvent(
            eventId: eventId,
            doctorId: doctorId,
            fullName: fullName,
            emailId: emailId,
            mobileNo: mobileNo,
            membershipStatus: membershipStatus,
          ),
    );

    if (result.hasError) {
      state = state.copyWith(
        registerEvent: AsyncValue.error(result.error!, result.stackTrace!),
      );
      return false;
    }

    final response = result.value!;

    if (!response.status) {
      state = state.copyWith(
        registerEvent: AsyncValue.error(
          Exception(response.msg?.toString() ?? 'Registration failed'),
          StackTrace.current,
        ),
      );
      return false;
    }

    state = state.copyWith(registerEvent: AsyncValue.data(response));
    return true;
  }

  Future<void> initPayment(String eventRegistrationId) async {
    state = state.copyWith(
      redeemPoints: false,
      applyingCoupon: false,
      paying: false,
      appliedCoupon: null,
      couponError: null,
      availableRewardPoints: null,
    );

    final error = await _reloadSummary(eventRegistrationId, reset: true);
    if (error != null) return;

    state = state.copyWith(
      availableRewardPoints:
          state.paymentList.valueOrNull?.data.availableRewardPoints ?? 0,
    );
  }

  /// Returns null on success, else error message (reverts the toggle).
  Future<String?> toggleRewards(String eventRegistrationId, bool value) async {
    final previous = state.redeemPoints;
    state = state.copyWith(redeemPoints: value);

    final error = await _reloadSummary(eventRegistrationId);
    if (error != null) state = state.copyWith(redeemPoints: previous);
    return error;
  }

  Future<void> applyCoupon(String eventRegistrationId, String code) async {
    state = state.copyWith(applyingCoupon: true, couponError: null);

    final error = await _reloadSummary(eventRegistrationId, coupon: code);
    if (error != null) {
      state = state.copyWith(applyingCoupon: false, couponError: error);
      return;
    }

    final data = state.paymentList.valueOrNull?.data;
    final discount =
        double.tryParse(
          (data?.couponDiscountAmount ?? '').replaceAll(',', '').trim(),
        ) ??
        0;
    final applied = (data?.couponCode?.isNotEmpty ?? false) || discount > 0;

    state = state.copyWith(
      applyingCoupon: false,
      appliedCoupon: applied ? code : null,
      couponError: applied ? null : 'Invalid or expired coupon',
    );
  }

  /// Returns null on success, else error message (restores the coupon).
  Future<String?> removeCoupon(String eventRegistrationId) async {
    final previous = state.appliedCoupon;
    state = state.copyWith(appliedCoupon: null, couponError: null);

    final error = await _reloadSummary(eventRegistrationId);
    if (error != null) state = state.copyWith(appliedCoupon: previous);
    return error;
  }

  void setCouponError(String? message) =>
      state = state.copyWith(couponError: message);

  void clearCouponError() => state = state.copyWith(couponError: null);

  /// Runs the payment [action] with the `paying` flag on.
  /// Returns null on success, else error message.
  Future<String?> runPayment(Future<void> Function() action) async {
    state = state.copyWith(paying: true);
    try {
      await action();
      return null;
    } catch (e) {
      return _cleanError(e);
    } finally {
      state = state.copyWith(paying: false);
    }
  }

  Future<String?> _reloadSummary(
    String eventRegistrationId, {
    String? coupon,
    bool reset = false,
  }) {
    final points = state.availableRewardPoints ?? 0;

    return fetchPaymentSummary(
      eventRegistrationId: eventRegistrationId,
      rewardPointsUsed: state.redeemPoints && points > 0
          ? points.toString()
          : null,
      couponCode: coupon ?? state.appliedCoupon,
      reset: reset,
    );
  }

  /// Fetches the event payment summary.
  ///
  /// - [reset] = true: first load (clears any stale summary, shows full loader).
  /// - [reset] = false: refresh (reward toggle / coupon). Previous summary is
  ///   kept on screen while loading, and restored if the call fails.
  ///
  /// Returns null on success, or an error message on failure.
  Future<String?> fetchPaymentSummary({
    required String eventRegistrationId,
    String? rewardPointsUsed,
    String? couponCode,
    bool reset = false,
  }) async {
    final previous = state.paymentList;
    final hasPrevious = !reset && previous.valueOrNull != null;

    state = state.copyWith(
      paymentList: hasPrevious
          ? const AsyncLoading<PaymentSummaryResponse>().copyWithPrevious(
              previous,
            )
          : const AsyncLoading<PaymentSummaryResponse>(),
    );

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .eventPaymentSummary(
            eventRegistrationId: eventRegistrationId,
            rewardPointsUsed: rewardPointsUsed,
            couponCode: couponCode,
          ),
    );

    if (result.hasError) {
      _restoreOrFail(hasPrevious, previous, result.error!, result.stackTrace!);
      return _cleanError(result.error!);
    }

    final response = result.requireValue;

    if (!response.status) {
      final message = response.msg.isNotEmpty
          ? response.msg
          : 'Could not load payment summary';
      _restoreOrFail(
        hasPrevious,
        previous,
        Exception(message),
        StackTrace.current,
      );
      return message;
    }

    state = state.copyWith(paymentList: AsyncValue.data(response));
    return null;
  }

  void _restoreOrFail(
    bool hasPrevious,
    AsyncValue<PaymentSummaryResponse> previous,
    Object error,
    StackTrace stackTrace,
  ) {
    if (hasPrevious) {
      state = state.copyWith(
        paymentList: AsyncValue.data(previous.requireValue),
      );
    } else {
      state = state.copyWith(paymentList: AsyncValue.error(error, stackTrace));
    }
  }
}
