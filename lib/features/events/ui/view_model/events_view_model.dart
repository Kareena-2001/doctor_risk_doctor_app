import 'package:Doctors_App/features/events/repository/events_repository.dart';
import 'package:Doctors_App/features/events/ui/state/events_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_view_model.g.dart';

@riverpod
class EventsViewModel extends _$EventsViewModel {
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
    state = state.copyWith(collaborationList: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref.read(eventsRepositoryProvider).collaborationList(),
    );

    state = state.copyWith(collaborationList: result);
  }

  Future<void> refreshCollaborationList() => collaborationList();
}
