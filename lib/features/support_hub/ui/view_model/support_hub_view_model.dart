import 'dart:io';

import 'package:Doctors_App/features/support_hub/model/query_detail_model.dart';
import 'package:Doctors_App/features/support_hub/model/query_list_model.dart';
import 'package:Doctors_App/features/support_hub/repository/support_hub_repository.dart';
import 'package:Doctors_App/features/support_hub/ui/state/support_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'support_hub_view_model.g.dart';

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

  Future<bool> addTicket({
    required String ticketType,
    required String queryType,
    required String commonQuery,
    required String preferredContact,
    required String priority,
    required String description,
    required String legalType,
    File? file,
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
        file: file,
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        createdTicket: resp,
        tktNumber: resp.msg,
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
  Future<bool> addRemark({
    required String ticketId,
    required String remark,
    File? file,
  }) async {
    if (remark.trim().isEmpty && file == null) {
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
        file: file,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);

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

  Future<bool> updateTicket({
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
      state = state.copyWith(isFetchingLegalTickets: false, legalTickets: resp);
    } catch (e) {
      state = state.copyWith(
        isFetchingLegalTickets: false,
        legalTicketsError: _errorMessage(e),
      );
    }
  }

  void setLegalCategory(LegalCategory category) {
    state = state.copyWith(legalCategory: category);
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

  Future<void> _refreshLoadedLists() async {
    await Future.wait([
      if (_serviceArgs != null) refreshServiceTickets(),
      if (_legalArgs != null) refreshLegalTickets(),
    ]);
  }

  void resetState() {
    state = state.copyWith(isSuccess: false, error: null, createdTicket: null);
  }

  Future<void> registerQuery({
    required dynamic queryType,
    required dynamic requestType,
    required dynamic priority,
    String details = '',
    File? userAttachment,
  }) async {
    await addTicket(
      ticketType: queryType.toString().split('.').last,
      queryType: requestType.toString().split('.').last,
      commonQuery: '',
      preferredContact: '',
      priority: priority.toString().split('.').last,
      description: details,
      legalType: '',
    );
  }

  Future<void> fetchQueries() async {
    state = state.copyWith(isFetchingQueries: true, error: null);
    try {
      final resp = await _repo.serviceTicketList();
      final items = resp.data.tickets.map((t) {
        return QueryListItem(
          id: t.id.toString(),
          ticketNumber: t.ticketNo,
          question: t.queryType,
          category: t.commonQuery ?? t.queryType,
          description: t.description ?? '',
          ticketStatus: t.ticketStatus,
          querySubmit: t.createdOn,
        );
      }).toList();
      state = state.copyWith(
        isFetchingQueries: false,
        serviceTickets: resp,
        queries: items,
      );
    } catch (e) {
      state = state.copyWith(isFetchingQueries: false, error: _errorMessage(e));
    }
  }

  Future<void> fetchQueryDetail(String id) async {
    state = state.copyWith(
      isFetchingQueryDetail: true,
      queryDetailError: null,
      queryDetail: null,
    );
    try {
      final resp = await _repo.supportTicketRemarks(id: id);
      final ticket = resp.data.ticket;
      final remarks = resp.data.remarks;

      final adminRemark = remarks.isNotEmpty ? remarks.first : null;

      final detail = QueryDetailItem(
        ticketNumber: ticket.ticketNo,
        ticketStatus: ticket.ticketStatus,
        querySubmit: '',
        category: ticket.ticketStatus,
        question: ticket.description ?? '',
        description: ticket.description ?? '',
        replied: adminRemark?.remark,
        repliedDate: adminRemark?.dateTime,
        replyAttachment: adminRemark?.attachment,
      );

      state = state.copyWith(
        isFetchingQueryDetail: false,
        ticketRemarks: resp,
        queryDetail: detail,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingQueryDetail: false,
        queryDetailError: _errorMessage(e),
      );
    }
  }
}
