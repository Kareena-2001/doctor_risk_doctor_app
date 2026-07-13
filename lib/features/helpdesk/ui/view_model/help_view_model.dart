import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/query_list_model.dart';
import '../../model/suppport_enums.dart';
import '../../repository/help_repository.dart';
import '../state/help_state.dart';

part 'help_view_model.g.dart';

@Riverpod(keepAlive: true)
class HelpViewModel extends _$HelpViewModel {
  @override
  HelpState build() {
    return const HelpState();
  }

  /// Support Hub > Register/Request a Query
  Future<void> registerQuery({
    required QueryType queryType,
    required RequestType requestType,
    required PriorityLevel priority,
    required String details,
    File? userAttachment,
  }) async {
    if (details.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please enter description for your query',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final resp = await ref
          .read(helpRepositoryProvider)
          .addRequest(
            category: queryType.displayName,
            question: requestType.displayName,
            description: details,
            priority: priority.displayName,
            userAttachment: userAttachment,
          );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        tktNumber: resp.data?.ticketNumber,
      );

      await fetchQueries();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> bookAppointment({
    required QueryType queryType,
    required AppointmentMode mode,
    required DateTime date,
    required TimeOfDay time,
    required PriorityLevel priority,
    required String details,
    File? userAttachment,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

      final resp = await ref
          .read(helpRepositoryProvider)
          .addRequest(
            category: queryType.displayName,
            question: 'Book Appointment - ${mode.displayName}',
            description:
                'Preferred Date: ${date.day}/${date.month}/${date.year}\n'
                'Preferred Time: $formattedTime\n$details',
            priority: priority.displayName,
            userAttachment: userAttachment,
          );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        tktNumber: resp.data?.ticketNumber,
      );

      await fetchQueries();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Service Support > Chat Support
  Future<void> submitChatSupport({
    required ChatSupportCategory category,
    required String details,
    File? userAttachment,
  }) async {
    if (details.trim().isEmpty) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please enter description for your query',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final resp = await ref
          .read(helpRepositoryProvider)
          .addRequest(
            category: 'Service Support',
            question: category.displayName,
            description: details,
            priority: '',
            userAttachment: userAttachment,
          );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        tktNumber: resp.data?.ticketNumber,
      );

      await fetchQueries();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchQueries() async {
    state = state.copyWith(isFetchingQueries: true, error: null);

    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(
      isFetchingQueries: false,
      queries: const [
        QueryListItem(
          id: '1',
          userId: '101',
          ticketNumber: 'DR-2026001',
          category: 'Medico Legal',
          question: 'Claim Settlement',
          description:
              'Need assistance regarding claim settlement for my indemnity policy.',
          ticketStatus: 'Open',
          querySubmit: 'Today, 10:30 AM',
        ),
        QueryListItem(
          id: '2',
          userId: '101',
          ticketNumber: 'DR-2026002',
          category: 'Legal',
          question: 'Policy Renewal',
          description:
              'I would like to know the renewal process and premium details.',
          ticketStatus: 'In Progress',
          querySubmit: 'Yesterday, 04:15 PM',
        ),
        QueryListItem(
          id: '3',
          userId: '101',
          ticketNumber: 'DR-2026003',
          category: 'Medico Legal',
          question: 'Book Appointment',
          description:
              'Need to book an appointment with the medico-legal advisor.',
          ticketStatus: 'Resolved',
          querySubmit: '09 Jul 2026',
        ),
        QueryListItem(
          id: '4',
          userId: '101',
          ticketNumber: 'DR-2026004',
          category: 'Legal',
          question: 'Policy Cancellation',
          description:
              'Need guidance regarding policy cancellation and refund.',
          ticketStatus: 'Pending',
          querySubmit: '07 Jul 2026',
        ),
        QueryListItem(
          id: '5',
          userId: '101',
          ticketNumber: 'DR-2026005',
          category: 'Service Support',
          question: 'Unable to Upload Documents',
          description:
              'Document upload is failing while submitting my request.',
          ticketStatus: 'Open',
          querySubmit: '05 Jul 2026',
        ),
      ],
    );
  }

  Future<void> fetchQueryDetail(String id) async {
    state = state.copyWith(
      isFetchingQueryDetail: true,
      queryDetailError: null,
      queryDetail: null,
    );
    try {
      final res = await ref.read(helpRepositoryProvider).fetchQueryDetail(id);
      state = state.copyWith(
        isFetchingQueryDetail: false,
        queryDetail: res.data,
      );
    } catch (e) {
      state = state.copyWith(
        isFetchingQueryDetail: false,
        queryDetailError: e.toString(),
      );
    }
  }

  void resetState() {
    state = state.copyWith(isSuccess: false, error: null);
  }

  void addRequestSupport({
    required String category,
    required String question,
    required String details,
    File? userAttachment,
  }) {}
}
