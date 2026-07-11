enum PlanStatus { active, expired, pendingRenewal, inactive }

extension PlanStatusX on PlanStatus {
  String get label {
    switch (this) {
      case PlanStatus.active:
        return 'Active';
      case PlanStatus.expired:
        return 'Expired';
      case PlanStatus.pendingRenewal:
        return 'Renewal Due';
      case PlanStatus.inactive:
        return 'Inactive';
    }
  }
}

class MyPlan {
  final int srNo;
  final String id;
  final String planName;
  final String duration;
  final double sumAssured;
  final double premium;
  final double payable;
  final PlanStatus status;
  final DateTime fromDate;
  final DateTime toDate;
  final String policyNumber;

  const MyPlan({
    required this.srNo,
    required this.id,
    required this.planName,
    required this.duration,
    required this.sumAssured,
    required this.premium,
    required this.payable,
    required this.status,
    required this.fromDate,
    required this.toDate,
    required this.policyNumber,
  });

  bool get isRenewable =>
      status == PlanStatus.expired || status == PlanStatus.pendingRenewal;

  int get daysToExpiry => toDate.difference(DateTime.now()).inDays;
}