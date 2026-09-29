import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/support_hub_repository.dart';
import '../state/support_hub_state.dart';

part 'support_view_model.g.dart';

/// Last-used list arguments, so lists can be refreshed after a mutation.
class _ListArgs {
  final String? id;
  final String? ticketNo;
  final String? appointmentType;
  final String? appointmentStatus;
  final String? startDate;
  final String? endDate;
  final int page;
  final int limit;

  const _ListArgs({
    this.id,
    this.ticketNo,
    this.appointmentType,
    this.appointmentStatus,
    this.startDate,
    this.endDate,
    this.page = 1,
    this.limit = 10,
  });
}

@Riverpod(keepAlive: true)
class SupportHubViewModel extends _$SupportHubViewModel {
  _ListArgs? _serviceArgs;
  _ListArgs? _legalArgs;
  _ListArgs? _remarksArgs;

  @override
  SupportHubState build() => const SupportHubState();

  SupportHubRepository get _repo => ref.read(supportHubRepositoryProvider);

  String _errorMessage(Object e) {
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring('Exception: '.length) : s;
  }

  // ───────────────────────────────────────────────────────────────────────
  // Create ticket
  // ───────────────────────────────────────────────────────────────────────

  Future<bool> addTicket({
    required String ticketType,
    required String queryType,
    required String commonQuery,
    required String preferredContact,
    required String priority,
    required String description,
    required String legalType,
  }) async {
    if (description.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'Please enter description for your query',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: null,
      createdTicket: null,
    );

    try {
      final resp = await _repo.addSupportTicket(
        ticketType: ticketType,
        queryType: queryType,
        commonQuery: commonQuery,
        preferredContact: preferredContact,
        priority: priority,
        description: description.trim(),
        legalType: legalType,
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        createdTicket: resp,
      );

      await _refreshLoadedLists();
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

  // ───────────────────────────────────────────────────────────────────────
  // Add remark
  // ───────────────────────────────────────────────────────────────────────

  Future<bool> addRemark({
    required String ticketId,
    required String remark,
    String attachment = '',
  }) async {
    if (remark.trim().isEmpty && attachment.isEmpty) {
      state = state.copyWith(
        isSuccess: false,
        error: 'Please enter a remark or attach a file',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, isSuccess: false, error: null);

    try {
      await _repo.addSupportRemark(
        ticketId: ticketId,
        remark: remark.trim(),
        attachment: attachment,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);

      // Reload the conversation for this ticket.
      final args = _remarksArgs;
      if (args != null && args.id == ticketId) {
        await fetchRemarks(
          id: ticketId,
          ticketNo: args.ticketNo,
          appointmentType: args.appointmentType,
          appointmentStatus: args.appointmentStatus,
          startDate: args.startDate,
          endDate: args.endDate,
          page: args.page,
          limit: args.limit,
        );
      } else {
        await fetchRemarks(id: ticketId);
      }
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

  // ───────────────────────────────────────────────────────────────────────
  // Update ticket
  // ───────────────────────────────────────────────────────────────────────

  Future<bool> updateTicket({
    required String id,
    String? description,
    String? priority,
  }) async {
    final hasDescription = description != null && description.trim().isNotEmpty;
    final hasPriority = priority != null && priority.isNotEmpty;

    if (!hasDescription && !hasPriority) {
      state = state.copyWith(
        isSuccess: false,
        error: 'Nothing to update',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, isSuccess: false, error: null);

    try {
      await _repo.updateSupportTicket(
        id: id,
        description: hasDescription ? description.trim() : null,
        priority: hasPriority ? priority : null,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);
      await _refreshLoadedLists();
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

  // ───────────────────────────────────────────────────────────────────────
  // Cancel ticket
  // ───────────────────────────────────────────────────────────────────────

  Future<bool> cancelTicket(int supportId) async {
    state = state.copyWith(
      cancellingTicketId: supportId,
      isSuccess: false,
      error: null,
    );

    try {
      await _repo.cancelAppointment(supportId: supportId);

      state = state.copyWith(cancellingTicketId: null, isSuccess: true);
      await _refreshLoadedLists();
      return true;
    } catch (e) {
      state = state.copyWith(
        cancellingTicketId: null,
        isSuccess: false,
        error: _errorMessage(e),
      );
      return false;
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Lists
  // ───────────────────────────────────────────────────────────────────────

  Future<void> fetchServiceTickets({
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    _serviceArgs = _ListArgs(
      ticketNo: ticketNo,
      appointmentType: appointmentType,
      appointmentStatus: appointmentStatus,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    state = state.copyWith(
      isFetchingServiceTickets: true,
      serviceTicketsError: null,
    );

    try {
      final resp = await _repo.serviceTicketList(
        ticketNo: ticketNo,
        appointmentType: appointmentType,
        appointmentStatus: appointmentStatus,
        startDate: startDate,
        endDate: endDate,
        page: page,
        limit: limit,
      );
      state = state.copyWith(
        isFetchingServiceTickets: false,
        serviceTickets: resp,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingServiceTickets: false,
        serviceTicketsError: _errorMessage(e),
      );
    }
  }

  Future<void> refreshServiceTickets() {
    final a = _serviceArgs;
    if (a == null) return fetchServiceTickets();
    return fetchServiceTickets(
      ticketNo: a.ticketNo,
      appointmentType: a.appointmentType,
      appointmentStatus: a.appointmentStatus,
      startDate: a.startDate,
      endDate: a.endDate,
      page: a.page,
      limit: a.limit,
    );
  }

  Future<void> fetchLegalTickets({
    required String id,
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    _legalArgs = _ListArgs(
      id: id,
      ticketNo: ticketNo,
      appointmentType: appointmentType,
      appointmentStatus: appointmentStatus,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    state = state.copyWith(
      isFetchingLegalTickets: true,
      legalTicketsError: null,
    );

    try {
      final resp = await _repo.legalTicketList(
        id: id,
        ticketNo: ticketNo,
        appointmentType: appointmentType,
        appointmentStatus: appointmentStatus,
        startDate: startDate,
        endDate: endDate,
        page: page,
        limit: limit,
      );
      state = state.copyWith(
        isFetchingLegalTickets: false,
        legalTickets: resp,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingLegalTickets: false,
        legalTicketsError: _errorMessage(e),
      );
    }
  }

  Future<void> refreshLegalTickets() {
    final a = _legalArgs;
    if (a == null || a.id == null) return Future.value();
    return fetchLegalTickets(
      id: a.id!,
      ticketNo: a.ticketNo,
      appointmentType: a.appointmentType,
      appointmentStatus: a.appointmentStatus,
      startDate: a.startDate,
      endDate: a.endDate,
      page: a.page,
      limit: a.limit,
    );
  }

  Future<void> fetchRemarks({
    required String id,
    String? ticketNo,
    String? appointmentType,
    String? appointmentStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
  }) async {
    _remarksArgs = _ListArgs(
      id: id,
      ticketNo: ticketNo,
      appointmentType: appointmentType,
      appointmentStatus: appointmentStatus,
      startDate: startDate,
      endDate: endDate,
      page: page,
      limit: limit,
    );

    state = state.copyWith(
      isFetchingRemarks: true,
      remarksError: null,
      // Different ticket -> don't flash the previous ticket's remarks.
      ticketRemarks: null,
    );

    try {
      final resp = await _repo.supportTicketRemarks(
        id: id,
        ticketNo: ticketNo,
        appointmentType: appointmentType,
        appointmentStatus: appointmentStatus,
        startDate: startDate,
        endDate: endDate,
        page: page,
        limit: limit,
      );
      state = state.copyWith(isFetchingRemarks: false, ticketRemarks: resp);
    } catch (e) {
      state = state.copyWith(
        isFetchingRemarks: false,
        remarksError: _errorMessage(e),
      );
    }
  }

  /// Refresh whichever lists the user has already opened.
  Future<void> _refreshLoadedLists() async {
    await Future.wait([
      if (_serviceArgs != null) refreshServiceTickets(),
      if (_legalArgs != null) refreshLegalTickets(),
    ]);
  }

  void resetState() {
    state = state.copyWith(isSuccess: false, error: null, createdTicket: null);
  }
}