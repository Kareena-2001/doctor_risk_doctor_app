import '../../model/plan_finder_models.dart';
import '../../model/product_model.dart';

class PlanFinderArgs {
  final String? orgName;
  final String? staffCode;
  final ProductType category;

  const PlanFinderArgs({this.orgName, this.staffCode, required this.category});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanFinderArgs &&
          runtimeType == other.runtimeType &&
          orgName == other.orgName &&
          staffCode == other.staffCode &&
          category == other.category;

  @override
  int get hashCode => Object.hash(orgName, staffCode, category);
}

class PlanFinderState {
  final String? orgName;
  final String? staffCode;
  final ProductType category;

  final MembershipType? membership;
  final PlanTier? plan;
  final PolicyDuration? duration;
  final SumAssured? sumAssured;

  final PlanQuote? quote;
  final bool showComparison;

  final bool hasActivePolicy;

  const PlanFinderState({
    this.orgName,
    this.staffCode,
    required this.category,
    this.membership,
    this.plan,
    this.duration,
    this.sumAssured,
    this.quote,
    this.showComparison = false,
    this.hasActivePolicy = false,
  });

  bool get canSearch =>
      membership != null &&
      plan != null &&
      duration != null &&
      sumAssured != null;

  PlanFinderState copyWith({
    MembershipType? membership,
    bool clearMembership = false,
    PlanTier? plan,
    bool clearPlan = false,
    PolicyDuration? duration,
    bool clearDuration = false,
    SumAssured? sumAssured,
    bool clearSumAssured = false,
    PlanQuote? quote,
    bool clearQuote = false,
    bool? showComparison,
    bool? hasActivePolicy,
  }) {
    return PlanFinderState(
      orgName: orgName,
      staffCode: staffCode,
      category: category,
      membership: clearMembership ? null : (membership ?? this.membership),
      plan: clearPlan ? null : (plan ?? this.plan),
      duration: clearDuration ? null : (duration ?? this.duration),
      sumAssured: clearSumAssured ? null : (sumAssured ?? this.sumAssured),
      quote: clearQuote ? null : (quote ?? this.quote),
      showComparison: showComparison ?? this.showComparison,
      hasActivePolicy: hasActivePolicy ?? this.hasActivePolicy,
    );
  }
}
