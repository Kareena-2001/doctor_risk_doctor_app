import '../widgets/tier_helper.dart';

class TierPlan {
  final String name;
  final String tagline;
  final double premiumPerYear;
  final double sumInsured;
  final int maxMembers;
  final int validityYears;
  final List<TierFeatureItem> features;
  final TierStyle style;
  final bool isBestValue;

  const TierPlan({
    required this.name,
    required this.tagline,
    required this.premiumPerYear,
    required this.sumInsured,
    required this.maxMembers,
    required this.validityYears,
    required this.features,
    required this.style,
    this.isBestValue = false,
  });
}

class TierFeatureItem {
  final String label;
  final bool included;

  const TierFeatureItem(this.label, {this.included = true});
}
