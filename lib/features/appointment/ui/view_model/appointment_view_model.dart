import 'dart:async';
import 'package:Doctors_App/features/appointment/ui/state/appointment_state.dart';
import 'package:Doctors_App/features/appointment/repository/appointment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_view_model.g.dart';

@Riverpod(keepAlive: true)
class AppointmentViewModel extends _$AppointmentViewModel {
  AppointmentRepository get _repo => ref.read(appointmentRepositoryProvider);

  @override
  FutureOr<AppointmentState> build() async {
    try {
      final resp = await _repo.appointmentList();
      return AppointmentState(appointmentResp: resp);
    } catch (e) {
      return AppointmentState(errorMessage: e.toString());
    }
  }

  AppointmentState get _current => state.value ?? const AppointmentState();

  void _emit(AppointmentState s) => state = AsyncData(s);

  Future<void> fetchAppointments({
    required String appointmentNo,
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    _emit(_current.copyWith(isLoading: true, errorMessage: null));
    try {
      final resp = await _repo.appointmentList(
        appointmentNo: appointmentNo,
        appointmentType: appointmentType,
        appointmentStatus: appointmentStatus,
        startDate: startDate,
        endDate: endDate,
        page: page,
        limit: limit,
      );
      _emit(_current.copyWith(isLoading: false, appointmentResp: resp));
    } catch (e) {
      _emit(_current.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> fetchRemarks({
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    _emit(_current.copyWith(isLoading: true, errorMessage: null));
    try {
      final resp = await _repo.appointmentRemarks(
        ticketNo: ticketNo,
        appointmentType: appointmentType,
        appointmentStatus: appointmentStatus,
        startDate: startDate,
        endDate: endDate,
        page: page,
        limit: limit,
      );
      _emit(_current.copyWith(isLoading: false, remarksResp: resp));
    } catch (e) {
      _emit(_current.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Shared runner for write actions. Returns true on success, refreshes list.
  Future<bool> _run(Future<void> Function() action) async {
    _emit(_current.copyWith(isActionLoading: true, errorMessage: null));
    try {
      await action();
      _emit(_current.copyWith(isActionLoading: false));
      await fetchAppointments(appointmentNo: '');
      return true;
    } catch (e) {
      _emit(
        _current.copyWith(isActionLoading: false, errorMessage: e.toString()),
      );
      return false;
    }
  }

  Future<bool> cancelAppointment(int appointmentId) =>
      _run(() => _repo.cancelAppointment(appointmentId: appointmentId));

  Future<bool> requestReschedule(String appointmentId) =>
      _run(() => _repo.rescheduleRequest(appointmentId: appointmentId));

  Future<bool> addAppointment(String appointmentId) =>
      _run(() => _repo.addAppointment(appointmentId: appointmentId));

  Future<bool> addRemark({
    required String appointmentId,
    required String remark,
    required String attachment,
  }) => _run(
    () => _repo.addAppointmentRemark(
      appointmentId: appointmentId,
      remark: remark,
      attachment: attachment,
    ),
  );
}
