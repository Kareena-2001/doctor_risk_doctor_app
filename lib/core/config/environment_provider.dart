import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'environment.dart';

part 'environment_provider.g.dart';

@Riverpod(keepAlive: true)
EnvironmentConfig environmentConfig(EnvironmentConfigRef ref) {
  // return EnvironmentConfig.development();
  return EnvironmentConfig.production();
}

@riverpod
String baseUrl(BaseUrlRef ref) {
  return ref.watch(environmentConfigProvider).baseUrl;
}
