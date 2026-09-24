// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_wizard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$purchaseWizardControllerHash() =>
    r'3ccd533be19e2c6c293da1ffda4d50d47686f2d1';

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

abstract class _$PurchaseWizardController
    extends BuildlessAutoDisposeNotifier<PurchaseWizardState> {
  late final Product product;
  late final TierPlan tier;
  late final String duration;
  late final double sumAssured;
  late final double premium;

  PurchaseWizardState build(
    Product product,
    TierPlan tier,
    String duration,
    double sumAssured,
    double premium,
  );
}

/// See also [PurchaseWizardController].
@ProviderFor(PurchaseWizardController)
const purchaseWizardControllerProvider = PurchaseWizardControllerFamily();

/// See also [PurchaseWizardController].
class PurchaseWizardControllerFamily extends Family<PurchaseWizardState> {
  /// See also [PurchaseWizardController].
  const PurchaseWizardControllerFamily();

  /// See also [PurchaseWizardController].
  PurchaseWizardControllerProvider call(
    Product product,
    TierPlan tier,
    String duration,
    double sumAssured,
    double premium,
  ) {
    return PurchaseWizardControllerProvider(
      product,
      tier,
      duration,
      sumAssured,
      premium,
    );
  }

  @override
  PurchaseWizardControllerProvider getProviderOverride(
    covariant PurchaseWizardControllerProvider provider,
  ) {
    return call(
      provider.product,
      provider.tier,
      provider.duration,
      provider.sumAssured,
      provider.premium,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'purchaseWizardControllerProvider';
}

/// See also [PurchaseWizardController].
class PurchaseWizardControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          PurchaseWizardController,
          PurchaseWizardState
        > {
  /// See also [PurchaseWizardController].
  PurchaseWizardControllerProvider(
    Product product,
    TierPlan tier,
    String duration,
    double sumAssured,
    double premium,
  ) : this._internal(
        () => PurchaseWizardController()
          ..product = product
          ..tier = tier
          ..duration = duration
          ..sumAssured = sumAssured
          ..premium = premium,
        from: purchaseWizardControllerProvider,
        name: r'purchaseWizardControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$purchaseWizardControllerHash,
        dependencies: PurchaseWizardControllerFamily._dependencies,
        allTransitiveDependencies:
            PurchaseWizardControllerFamily._allTransitiveDependencies,
        product: product,
        tier: tier,
        duration: duration,
        sumAssured: sumAssured,
        premium: premium,
      );

  PurchaseWizardControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
    required this.tier,
    required this.duration,
    required this.sumAssured,
    required this.premium,
  }) : super.internal();

  final Product product;
  final TierPlan tier;
  final String duration;
  final double sumAssured;
  final double premium;

  @override
  PurchaseWizardState runNotifierBuild(
    covariant PurchaseWizardController notifier,
  ) {
    return notifier.build(product, tier, duration, sumAssured, premium);
  }

  @override
  Override overrideWith(PurchaseWizardController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PurchaseWizardControllerProvider._internal(
        () => create()
          ..product = product
          ..tier = tier
          ..duration = duration
          ..sumAssured = sumAssured
          ..premium = premium,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
        tier: tier,
        duration: duration,
        sumAssured: sumAssured,
        premium: premium,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    PurchaseWizardController,
    PurchaseWizardState
  >
  createElement() {
    return _PurchaseWizardControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseWizardControllerProvider &&
        other.product == product &&
        other.tier == tier &&
        other.duration == duration &&
        other.sumAssured == sumAssured &&
        other.premium == premium;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);
    hash = _SystemHash.combine(hash, tier.hashCode);
    hash = _SystemHash.combine(hash, duration.hashCode);
    hash = _SystemHash.combine(hash, sumAssured.hashCode);
    hash = _SystemHash.combine(hash, premium.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PurchaseWizardControllerRef
    on AutoDisposeNotifierProviderRef<PurchaseWizardState> {
  /// The parameter `product` of this provider.
  Product get product;

  /// The parameter `tier` of this provider.
  TierPlan get tier;

  /// The parameter `duration` of this provider.
  String get duration;

  /// The parameter `sumAssured` of this provider.
  double get sumAssured;

  /// The parameter `premium` of this provider.
  double get premium;
}

class _PurchaseWizardControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          PurchaseWizardController,
          PurchaseWizardState
        >
    with PurchaseWizardControllerRef {
  _PurchaseWizardControllerProviderElement(super.provider);

  @override
  Product get product => (origin as PurchaseWizardControllerProvider).product;
  @override
  TierPlan get tier => (origin as PurchaseWizardControllerProvider).tier;
  @override
  String get duration => (origin as PurchaseWizardControllerProvider).duration;
  @override
  double get sumAssured =>
      (origin as PurchaseWizardControllerProvider).sumAssured;
  @override
  double get premium => (origin as PurchaseWizardControllerProvider).premium;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
