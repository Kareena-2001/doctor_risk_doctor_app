import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';

enum ChatSender { user, support }

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required String text,
    required ChatSender sender,
    required DateTime timestamp,
    @Default(false) bool isSending,
  }) = _ChatMessageModel;
}