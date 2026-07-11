import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/ai/kals360_ai_context.dart';
import '../../model/chat_model.dart';
import '../state/chat_state.dart';

part 'chat_view_model.g.dart';

@Riverpod(keepAlive: true)
class ChatViewModel extends _$ChatViewModel {
  @override
  ChatState build() {
    return ChatState.initial();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatModel(role: 'user', text: text),
      ],
      isLoading: true,
    );
  }

  void clearChat() {
    state = ChatState.initial();
  }

  String _buildContextualPrompt(String userMessage, context) {
    final context = kals360AIContext;

    return """
You are an AI assistant for an application called "${context.appName}".

About the app:
${context.description}

Main features of the app:
${context.features.map((e) => "- $e").join("\n")}

User Question:
$userMessage

Instructions:
- Respond clearly and concisely
- If the question is about app usage, guide step by step
- If the question is unclear, ask a follow-up question
- Keep the tone friendly and professional
""";
  }
}
