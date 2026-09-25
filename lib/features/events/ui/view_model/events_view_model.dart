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
    state = state.copyWith(upcomingEvents: const AsyncLoading());

    final result = await AsyncValue.guard(
      () => ref
          .read(eventsRepositoryProvider)
          .eventList(search: 'upcoming', tab: type, title: query),
    );

    state = state.copyWith(upcomingEvents: result);
  }

  Future<void> fetchPastEvents({String type = '', String query = ''}) async {
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
}
