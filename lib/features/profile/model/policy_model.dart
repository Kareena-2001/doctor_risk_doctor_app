class PolicyModel {
  final String policyNumber;
  final String planName;
  final String insurerName;
  final DateTime purchaseDate;
  final DateTime? retroactiveDate;
  final DateTime? expiryDate;
  final String status; // Active, Expired, Pending, Renewed
  final double? premiumAmount;

  const PolicyModel({
    required this.policyNumber,
    required this.planName,
    required this.insurerName,
    required this.purchaseDate,
    this.retroactiveDate,
    this.expiryDate,
    required this.status,
    this.premiumAmount,
  });

  bool get isActive => status.toLowerCase() == 'active';

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      policyNumber: json['policyNumber'] ?? '',
      planName: json['planName'] ?? '',
      insurerName: json['insurerName'] ?? '',
      purchaseDate:
      DateTime.tryParse(json['purchaseDate'] ?? '') ?? DateTime.now(),
      retroactiveDate: json['retroactiveDate'] != null
          ? DateTime.tryParse(json['retroactiveDate'])
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.tryParse(json['expiryDate'])
          : null,
      status: json['status'] ?? 'Active',
      premiumAmount: (json['premiumAmount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'policyNumber': policyNumber,
      'planName': planName,
      'insurerName': insurerName,
      'purchaseDate': purchaseDate.toIso8601String(),
      'retroactiveDate': retroactiveDate?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'status': status,
      'premiumAmount': premiumAmount,
    };
  }
}