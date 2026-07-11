
import 'app_exception.dart';

extension ExceptionMessage on Object {
  String get readableMessage {
    if (this is ApiException) return (this as ApiException).message;
    return toString().replaceFirst('Exception: ', '');
  }
}