enum MembershipType { basic, essential, comprehensive }

extension MembershipTypeX on MembershipType {
  String get label => switch (this) {
    MembershipType.basic => 'Basic',
    MembershipType.essential => 'Essential',
    MembershipType.comprehensive => 'Comprehensive',
  };

  String get tagline => switch (this) {
    MembershipType.basic =>
    'Core policy cover and legal defense — no proactive extras.',
    MembershipType.essential =>
    'Everything in Basic, plus proactive risk reviews.',
    MembershipType.comprehensive =>
    'Our fullest cover with priority support and audits.',
  };

  /// Proactive add-ons included at this membership level, applied across
  /// every plan tier (Starter/Standard/Premium) within it.
  /// TODO: replace with real product-catalog data once available.
  List<String> get addOns => switch (this) {
    MembershipType.basic => const [],
    MembershipType.essential => const [
      'Proactive risk reviews',
    ],
    MembershipType.comprehensive => const [
      'Proactive risk reviews',
      'Priority support',
      'Compliance audits',
    ],
  };
}

enum PlanTier { starter, standard, premium }

extension PlanTierX on PlanTier {
  String get label => switch (this) {
    PlanTier.starter => 'Starter',
    PlanTier.standard => 'Standard',
    PlanTier.premium => 'Premium',
  };

  String consultationAccess(MembershipType m) => switch (this) {
    PlanTier.starter => 'Phone consultation with our medico-legal team',
    PlanTier.standard => 'Phone + in-person consultation',
    PlanTier.premium =>
    'Phone + in-person consultation, with priority same-day response '
        'and Bail Cost Coverage',
  };
}

enum PolicyDuration { oneYear, twoYear, threeYear, fiveYear }

extension PolicyDurationX on PolicyDuration {
  String get label => switch (this) {
    PolicyDuration.oneYear => '1 Year',
    PolicyDuration.twoYear => '2 Years',
    PolicyDuration.threeYear => '3 Years',
    PolicyDuration.fiveYear => '5 Years',
  };
  String get shortLabel => switch (this) {
    PolicyDuration.oneYear => '1 Yr',
    PolicyDuration.twoYear => '2 Yrs',
    PolicyDuration.threeYear => '3 Yrs',
    PolicyDuration.fiveYear => '5 Yrs',
  };
  double get multiplier => switch (this) {
    PolicyDuration.oneYear => 1.0,
    PolicyDuration.twoYear => 1.9,
    PolicyDuration.threeYear => 2.7,
    PolicyDuration.fiveYear => 4.2,
  };
}

enum SumAssured { l25, l50, l75, cr1 }

extension SumAssuredX on SumAssured {
  String get label => switch (this) {
    SumAssured.l25 => '₹25L',
    SumAssured.l50 => '₹50L',
    SumAssured.l75 => '₹75L',
    SumAssured.cr1 => '₹1Cr',
  };
  double get amount => switch (this) {
    SumAssured.l25 => 2500000,
    SumAssured.l50 => 5000000,
    SumAssured.l75 => 7500000,
    SumAssured.cr1 => 10000000,
  };
  double get multiplier => switch (this) {
    SumAssured.l25 => 1.0,
    SumAssured.l50 => 1.6,
    SumAssured.l75 => 2.1,
    SumAssured.cr1 => 2.6,
  };
}

/// Base annual premium at 1 Year duration & ₹25L sum assured.
/// TODO: replace with real pricing table / API response.
const Map<MembershipType, Map<PlanTier, double>> kBasePremiums = {
  MembershipType.basic: {
    PlanTier.starter: 16200,
    PlanTier.standard: 18600,
    PlanTier.premium: 21900,
  },
  MembershipType.essential: {
    PlanTier.starter: 24300,
    PlanTier.standard: 27900,
    PlanTier.premium: 32850,
  },
  MembershipType.comprehensive: {
    PlanTier.starter: 32400,
    PlanTier.standard: 37200,
    PlanTier.premium: 43800,
  },
};

double calculatePremium({
  required MembershipType membership,
  required PlanTier plan,
  required PolicyDuration duration,
  required SumAssured sumAssured,
}) {
  final base = kBasePremiums[membership]![plan]!;
  return base * duration.multiplier * sumAssured.multiplier;
}

class PlanQuote {
  final MembershipType membership;
  final PlanTier plan;
  final PolicyDuration duration;
  final SumAssured sumAssured;
  final double premium;

  const PlanQuote({
    required this.membership,
    required this.plan,
    required this.duration,
    required this.sumAssured,
    required this.premium,
  });
}

String formatRupees(double amount) {
  final n = amount.round();
  final s = n.toString();
  if (s.length <= 3) return s;
  final last3 = s.substring(s.length - 3);
  var r = s.substring(0, s.length - 3);
  final groups = <String>[];
  while (r.length > 2) {
    groups.insert(0, r.substring(r.length - 2));
    r = r.substring(0, r.length - 2);
  }
  if (r.isNotEmpty) groups.insert(0, r);
  return '${groups.join(',')},$last3';
}