import 'dart:io';

import 'package:Doctors_App/features/appointment/repository/appointment_repository.dart';
import 'package:Doctors_App/features/appointment/ui/state/appointment_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_view_model.g.dart';

class _ListArgs {
  final String? id;
  final String? appointmentNo;
  final String? appointmentType;
  final String? appointmentStatus;
  final String? startDate;
  final String? endDate;
  final int page;
  final int limit;

  const _ListArgs({
    this.id,
    this.appointmentNo,
    this.appointmentType,
    this.appointmentStatus,
    this.startDate,
    this.endDate,
    this.page = 1,
    this.limit = 10,
  });
}

@Riverpod(keepAlive: true)
class AppointmentViewModel extends _$AppointmentViewModel {
  _ListArgs? _listArgs;
  _ListArgs? _remarksArgs;

  @override
  AppointmentState build() => const AppointmentState();

  AppointmentRepository get _repo => ref.read(appointmentRepositoryProvider);

  String _errorMessage(Object e) {
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring('Exception: '.length) : s;
  }

  Future<void> fetchAppointments({
    String? appointmentNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
    bool append = false,
  }) async {
    _listArgs = _ListArgs(
      appointmentNo: appointmentNo,
      appointmentType: appointmentType,
      appointmentStatus: appointmentStatus,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    state = state.copyWith(
      isFetchingAppointments: true,
      appointmentsError: null,
    );

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
      final current = state.appointments;
      state = state.copyWith(
        isFetchingAppointments: false,
        appointments: append && current != null
            ? resp.copyWith(
                data: resp.data.copyWith(
                  appointments: [
                    ...current.data.appointments,
                    ...resp.data.appointments,
                  ],
                ),
              )
            : resp,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingAppointments: false,
        appointmentsError: _errorMessage(e),
      );
    }
  }

  Future<void> loadMoreAppointments() async {
    final current = state.appointments;
    final args = _listArgs;
    if (current == null ||
        args == null ||
        state.isFetchingAppointments ||
        current.data.currentPage >= current.data.lastPage) {
      return;
    }
    await fetchAppointments(
      appointmentNo: args.appointmentNo,
      appointmentType: args.appointmentType,
      appointmentStatus: args.appointmentStatus,
      startDate: args.startDate,
      endDate: args.endDate,
      page: current.data.currentPage + 1,
      limit: args.limit,
      append: true,
    );
  }

  Future<void> refreshAppointments() {
    final a = _listArgs;
    if (a == null) return fetchAppointments();
    return fetchAppointments(
      appointmentNo: a.appointmentNo,
      appointmentType: a.appointmentType,
      appointmentStatus: a.appointmentStatus,
      startDate: a.startDate,
      endDate: a.endDate,
      page: 1,
      limit: a.limit,
    );
  }

  Future<void> fetchRemarks({
    required String appointmentId,
    int page = 1,
    int limit = 10,
  }) async {
    state = state.copyWith(
      isFetchingRemarks: true,
      remarksError: null,
      appointmentRemarks: null,
    );
    try {
      final resp = await ref
          .read(appointmentRepositoryProvider)
          .appointmentRemarks(
            appointmentId: appointmentId,
            page: page,
            limit: limit,
          );
      state = state.copyWith(
        isFetchingRemarks: false,
        appointmentRemarks: resp,
      );
    } catch (e, st) {
      debugPrint('fetchRemarks ERROR => $e\n$st');
      state = state.copyWith(
        isFetchingRemarks: false,
        remarksError: e.toString(),
      );
    }
  }

  Future<bool> addRemark({
    required String appointmentId,
    required String remark,
    File? file,
  }) async {
    if (remark.trim().isEmpty && file == null) {
      state = state.copyWith(isSuccess: false, error: 'Please enter a remark');
      return false;
    }

    state = state.copyWith(isLoading: true, isSuccess: false, error: null);

    try {
      await _repo.addAppointmentRemark(
        appointmentId: appointmentId,
        remark: remark.trim(),
        file: file,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);

      await fetchRemarks(appointmentId: appointmentId);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: _errorMessage(e),
      );
      return false;
    }
  }

  Future<bool> updateAppointment({
    required String id,
    String? description,
    String? priority,
  }) async {
    final hasDescription = description != null && description.trim().isNotEmpty;
    final hasPriority = priority != null && priority.isNotEmpty;

    if (!hasDescription && !hasPriority) {
      state = state.copyWith(isSuccess: false, error: 'Nothing to update');
      return false;
    }

    state = state.copyWith(isLoading: true, isSuccess: false, error: null);

    try {
      await _repo.updateAppointment(
        appointmentId: id,
        description: hasDescription ? description.trim() : null,
        priority: hasPriority ? priority : null,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);
      await refreshAppointments();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: _errorMessage(e),
      );
      return false;
    }
  }

  Future<bool> cancelAppointment(int appointmentId) async {
    state = state.copyWith(
      cancellingId: appointmentId,
      isSuccess: false,
      error: null,
    );

    try {
      await _repo.cancelAppointment(appointmentId: appointmentId);

      state = state.copyWith(cancellingId: null, isSuccess: true);
      await refreshAppointments();
      return true;
    } catch (e) {
      state = state.copyWith(
        cancellingId: null,
        isSuccess: false,
        error: _errorMessage(e),
      );
      return false;
    }
  }

  Future<bool> rescheduleAppointment(String id) async {
    state = state.copyWith(isSuccess: false, error: null);

    try {
      await _repo.rescheduleRequest(appointmentId: id);

      // instant local update
      final resp = state.appointments;
      if (resp != null) {
        final updated = resp.data.appointments
            .map(
              (a) => a.id.toString() == id
                  ? a.copyWith(scheduleRequest: 'Reschedule requested')
                  : a,
            )
            .toList();

        state = state.copyWith(
          isSuccess: true,
          appointments: resp.copyWith(
            data: resp.data.copyWith(appointments: updated),
          ),
        );
      } else {
        state = state.copyWith(isSuccess: true);
      }

      refreshAppointments(); // sync with server, no await
      return true;
    } catch (e) {
      state = state.copyWith(isSuccess: false, error: _errorMessage(e));
      return false;
    }
  }

  void resetState() {
    state = state.copyWith(isSuccess: false, error: null);
  }
}
