import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../model/chat_message_model.dart';

part 'chat_view_model.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  @override
  List<ChatMessageModel> build() {
    return [
      ChatMessageModel(
        id: '0',
        text: 'Hi! How can we help you today?',
        sender: ChatSender.support,
        timestamp: DateTime.now(),
      ),
    ];
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: trimmed,
      sender: ChatSender.user,
      timestamp: DateTime.now(),
    );

    state = [...state, userMessage];

    // TODO: Replace this block with a real API/socket call once backend is ready.
    // Kept here only so the UI has something to show while wiring the rest.
    Future.delayed(const Duration(milliseconds: 700), () {
      final reply = ChatMessageModel(
        id: '${DateTime.now().millisecondsSinceEpoch}_r',
        text: 'Thanks for your message! Our team will get back to you shortly.',
        sender: ChatSender.support,
        timestamp: DateTime.now(),
      );

      state = [...state, reply];
    });
  }
}