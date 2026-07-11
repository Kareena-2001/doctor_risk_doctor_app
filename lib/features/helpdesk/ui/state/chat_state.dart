import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/chat_model.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatModel> messages,
    @Default(false) bool isLoading,
  }) = _ChatState;

  factory ChatState.initial() => ChatState(
    messages: const [
      ChatModel(
        role: 'bot',
        text:
            "Hello! 👋 I’m your AI assistant for Kals 360.\n\n"
            "I can help you with:\n"
            "• Employee onboarding\n"
            "• Documents & approvals\n"
            "• Attendance\n"
            "• Support & helpdesk\n\n"
            "How can I help you today?",
      ),
    ],
  );
}
