// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationViewModelHash() =>
    r'ab3dcc1a74302027794f524f940a32b0e3ffd110';

/// See also [NotificationViewModel].
@ProviderFor(NotificationViewModel)
final notificationViewModelProvider =
    AutoDisposeAsyncNotifierProvider<
      NotificationViewModel,
      List<NotificationGroup>
    >.internal(
      NotificationViewModel.new,
      name: r'notificationViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationViewModel =
    AutoDisposeAsyncNotifier<List<NotificationGroup>>;
String _$notificationAlertHash() => r'2f67189375bd3fc7c775ef6088d8f25e658bed59';

/// See also [NotificationAlert].
@ProviderFor(NotificationAlert)
final notificationAlertProvider =
    AutoDisposeAsyncNotifierProvider<NotificationAlert, bool>.internal(
      NotificationAlert.new,
      name: r'notificationAlertProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationAlertHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationAlert = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
