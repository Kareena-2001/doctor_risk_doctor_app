import 'app_exception.dart';

extension ExceptionMessage on Object {
  String get readableMessage {
    const fallback = 'Something went wrong. Please try again.';

    if (this is ApiException) {
      final apiMessage = (this as ApiException).message.trim();
      return apiMessage.isEmpty ? fallback : apiMessage;
    }

    final message = switch (this) {
      String value => value.replaceFirst(RegExp(r'^Exception:\s*'), '').trim(),
      Exception _ =>
        toString().replaceFirst(RegExp(r'^Exception:\s*'), '').trim(),
      _ => '',
    };

    if (message.isEmpty || message.startsWith('Instance of ')) {
      return fallback;
    }

    return message;
  }
}
