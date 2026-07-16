import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum PolicyStatus { active, expired, renewal }

extension PolicyStatusX on PolicyStatus {
  String get label {
    switch (this) {
      case PolicyStatus.active:
        return 'Membership Active';
      case PolicyStatus.expired:
        return 'Membership Expired';
      case PolicyStatus.renewal:
        return 'Renewal Due';
    }
  }

  Color get color {
    switch (this) {
      case PolicyStatus.active:
        return const Color(0xFF12B76A);
      case PolicyStatus.expired:
        return const Color(0xFFF04438);
      case PolicyStatus.renewal:
        return const Color(0xFFF79009);
    }
  }

  List<Color> get gradient {
    switch (this) {
      case PolicyStatus.active:
        return [AppColors.newPri, AppColors.primary];

      // case PolicyStatus.expired:
      //   return [
      //     // const Color(0xFFE53935), // Rich Red
      //     // const Color(0xFFB71C1C), // Deep Crimson
      //     const Color(0xFF6E7480), // Soft Faded Grey-Slate
      //     const Color(0xFF3E434D),
      //   ];

      case PolicyStatus.expired:
        return [
          const Color(0xFFB06A6A), // Muted Faded Red
          const Color(0xFF5C3333), // Deep Dark Brick
        ];
      case PolicyStatus.renewal:
        return [
          const Color(0xFFFFB300),
          const Color(0xFFF57C00),
          // AppColors.accent,
          // AppColors.orange,
        ];
    }
  }

  IconData get icon {
    switch (this) {
      case PolicyStatus.active:
        return Icons.verified;
      case PolicyStatus.expired:
        return Icons.error_outline_rounded;
      case PolicyStatus.renewal:
        return Icons.autorenew_rounded;
    }
  }

  static PolicyStatus fromString(String? value) {
    switch (value) {
      case 'expired':
        return PolicyStatus.expired;
      case 'renewal':
        return PolicyStatus.renewal;
      case 'active':
      default:
        return PolicyStatus.active;
    }
  }
}

class PolicyModel {
  final String title;
  final String planName;
  final String policyType;
  final String coverageAmount;
  final String policyNumber;
  final String duration;
  final String validFrom;
  final String validTo;
  final PolicyStatus status;

  const PolicyModel({
    required this.title,
    required this.planName,
    required this.policyType,
    required this.coverageAmount,
    required this.policyNumber,
    required this.duration,
    required this.validFrom,
    required this.validTo,
    this.status = PolicyStatus.active,
  });

  bool get canRenew =>
      status == PolicyStatus.expired || status == PolicyStatus.renewal;

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      title: json['title'] ?? '',
      planName: json['plan_name'] ?? '',
      policyType: json['policy_type'] ?? '',
      coverageAmount: json['coverage_amount'] ?? '',
      policyNumber: json['policy_number'] ?? '',
      duration: json['duration'] ?? '',
      validFrom: json['valid_from'] ?? '',
      validTo: json['valid_to'] ?? '',
      status: PolicyStatusX.fromString(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'plan_name': planName,
      'policy_type': policyType,
      'coverage_amount': coverageAmount,
      'policy_number': policyNumber,
      'duration': duration,
      'valid_from': validFrom,
      'valid_to': validTo,
      'status': status.name,
    };
  }
}
