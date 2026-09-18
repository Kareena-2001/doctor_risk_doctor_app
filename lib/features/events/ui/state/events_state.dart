import 'package:Doctors_App/features/events/model/collaboration_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events_state.freezed.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState({
    @Default(AsyncValue.data(null)) AsyncValue<void> addCollaboration,

    @Default(AsyncLoading())
    AsyncValue<CollaborationResponse> collaborationList,
  }) = _EventsState;
}
