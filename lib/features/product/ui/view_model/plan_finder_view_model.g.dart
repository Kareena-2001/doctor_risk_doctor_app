// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_finder_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$planFinderViewModelHash() =>
    r'a93e48f3a32b10f90c006424883101aaca2c87cb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PlanFinderViewModel
    extends BuildlessAutoDisposeNotifier<PlanFinderState> {
  late final PlanFinderArgs args;

  PlanFinderState build(PlanFinderArgs args);
}

/// See also [PlanFinderViewModel].
@ProviderFor(PlanFinderViewModel)
const planFinderViewModelProvider = PlanFinderViewModelFamily();

/// See also [PlanFinderViewModel].
class PlanFinderViewModelFamily extends Family<PlanFinderState> {
  /// See also [PlanFinderViewModel].
  const PlanFinderViewModelFamily();

  /// See also [PlanFinderViewModel].
  PlanFinderViewModelProvider call(PlanFinderArgs args) {
    return PlanFinderViewModelProvider(args);
  }

  @override
  PlanFinderViewModelProvider getProviderOverride(
    covariant PlanFinderViewModelProvider provider,
  ) {
    return call(provider.args);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'planFinderViewModelProvider';
}

/// See also [PlanFinderViewModel].
class PlanFinderViewModelProvider
    extends
        AutoDisposeNotifierProviderImpl<PlanFinderViewModel, PlanFinderState> {
  /// See also [PlanFinderViewModel].
  PlanFinderViewModelProvider(PlanFinderArgs args)
    : this._internal(
        () => PlanFinderViewModel()..args = args,
        from: planFinderViewModelProvider,
        name: r'planFinderViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$planFinderViewModelHash,
        dependencies: PlanFinderViewModelFamily._dependencies,
        allTransitiveDependencies:
            PlanFinderViewModelFamily._allTransitiveDependencies,
        args: args,
      );

  PlanFinderViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final PlanFinderArgs args;

  @override
  PlanFinderState runNotifierBuild(covariant PlanFinderViewModel notifier) {
    return notifier.build(args);
  }

  @override
  Override overrideWith(PlanFinderViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlanFinderViewModelProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PlanFinderViewModel, PlanFinderState>
  createElement() {
    return _PlanFinderViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanFinderViewModelProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlanFinderViewModelRef
    on AutoDisposeNotifierProviderRef<PlanFinderState> {
  /// The parameter `args` of this provider.
  PlanFinderArgs get args;
}

class _PlanFinderViewModelProviderElement
    extends
        AutoDisposeNotifierProviderElement<PlanFinderViewModel, PlanFinderState>
    with PlanFinderViewModelRef {
  _PlanFinderViewModelProviderElement(super.provider);

  @override
  PlanFinderArgs get args => (origin as PlanFinderViewModelProvider).args;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
