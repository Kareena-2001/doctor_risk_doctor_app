// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$environmentConfigHash() => r'cd6fd30b1aa3dead110bfdfd20017c313561a502';

/// See also [environmentConfig].
@ProviderFor(environmentConfig)
final environmentConfigProvider = Provider<EnvironmentConfig>.internal(
  environmentConfig,
  name: r'environmentConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$environmentConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EnvironmentConfigRef = ProviderRef<EnvironmentConfig>;
String _$baseUrlHash() => r'524e661291a3c11ec5160577df67370ada340f50';

/// See also [baseUrl].
@ProviderFor(baseUrl)
final baseUrlProvider = AutoDisposeProvider<String>.internal(
  baseUrl,
  name: r'baseUrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$baseUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BaseUrlRef = AutoDisposeProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
