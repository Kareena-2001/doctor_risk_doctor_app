import 'package:Doctors_App/features/events/model/collaboration_response.dart';
import 'package:Doctors_App/features/events/model/doctor_no_response.dart';
import 'package:Doctors_App/features/events/model/event_list_response.dart';
import 'package:Doctors_App/features/events/model/event_registration_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_state.freezed.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState({
    @Default(AsyncValue.data(null)) AsyncValue<void> addCollaboration,
    @Default(AsyncLoading())
    AsyncValue<CollaborationResponse> collaborationList,

    @Default(AsyncValue.data(null)) AsyncValue<DoctorNoResponse?> doctorDetails,

    @Default(AsyncLoading()) AsyncValue<EventListResponse> upcomingEvents,
    @Default(AsyncLoading()) AsyncValue<EventListResponse> pastEvents,

    @Default(AsyncValue.data(null))
    AsyncValue<EventRegistrationResponse?> registerEvent,
  }) = _EventsState;
}
