import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum PolicyStatus { active, expired, renewal, noPlan }

extension PolicyStatusX on PolicyStatus {
  String get label {
    switch (this) {
      case PolicyStatus.active:
        return 'Membership Active';
      case PolicyStatus.expired:
        return 'Membership Expired';
      case PolicyStatus.renewal:
        return 'Renewal Due';
      case PolicyStatus.noPlan:
        return 'No Active Membership';
    }
  }

  Color get color {
    switch (this) {
      case PolicyStatus.active:
        return const Color(0xFF166C3F); // --brand-700
      case PolicyStatus.expired:
        return const Color(0xFFE15C48); // --coral-500
      case PolicyStatus.renewal:
        return const Color(0xFFEF9F2E); // --amber-500
      case PolicyStatus.noPlan:
        return const Color(0xFF71847C); // --ink-400
    }
  }

  List<Color> get gradient {
    switch (this) {
      case PolicyStatus.active:
        return [const Color(0xFF1F8B4C), const Color(0xFF124430)]; // brand-600 -> brand-800
      case PolicyStatus.expired:
        return [const Color(0xFFE15C48), const Color(0xFFA13A29)];
      case PolicyStatus.renewal:
        return [const Color(0xFFEF9F2E), const Color(0xFF8A5B0E)];
      case PolicyStatus.noPlan:
        return [const Color(0xFF9AA5A0), const Color(0xFF616B66)];
    }
  }

  /// Same glass-card tint drives BOTH the hero header and the policy
  /// card for a given status — mirrors `[data-mstate="..."] .hero-card`.
  Color get heroBg {
    switch (this) {
      case PolicyStatus.active:
        return const Color(0xFFE9F7EC); // --mint-100
      case PolicyStatus.expired:
        return const Color(0xFFFBE6E2); // --coral-100
      case PolicyStatus.renewal:
        return const Color(0xFFFCEFD9); // --amber-100
      case PolicyStatus.noPlan:
        return const Color(0xFFF1F2F1);
    }
  }

  Color get heroBorder {
    switch (this) {
      case PolicyStatus.active:
        return const Color(0xFFD5F0DC); // --mint-200
      case PolicyStatus.expired:
        return const Color(0xFFF3C9C0);
      case PolicyStatus.renewal:
        return const Color(0xFFF3DFAE);
      case PolicyStatus.noPlan:
        return const Color(0xFFE3E6E4);
    }
  }

  // List<Color> get gradient {
  //   switch (this) {
  //     case PolicyStatus.active:
  //       return [AppColors.newPri, AppColors.primary];
  //
  //     case PolicyStatus.expired:
  //       return [
  //         const Color(0xFFB06A6A), // Muted Faded Red
  //         const Color(0xFF5C3333), // Deep Dark Brick
  //       ];
  //     case PolicyStatus.renewal:
  //       return [const Color(0xFFFFB300), const Color(0xFFF57C00)];
  //     case PolicyStatus.noPlan:
  //       // Neutral slate-grey — deliberately desaturated so it never
  //       // reads as "active" or "urgent" like the other 3 states.
  //       return [const Color(0xFF9AA5A0), const Color(0xFF616B66)];
  //   }
  // }

  IconData get icon {
    switch (this) {
      case PolicyStatus.active:
        return Icons.verified;
      case PolicyStatus.expired:
        return Icons.error_outline_rounded;
      case PolicyStatus.renewal:
        return Icons.autorenew_rounded;
      case PolicyStatus.noPlan:
        return Icons.lock_outline_rounded;
    }
  }

  Color get lightBg {
    switch (this) {
      case PolicyStatus.active:
        return AppColors.primary.withValues(alpha: 0.08);
      case PolicyStatus.expired:
        return AppColors.error.withValues(alpha: 0.08);
      case PolicyStatus.renewal:
        return AppColors.warning.withValues(alpha: 0.10);
      case PolicyStatus.noPlan:
        return AppColors.white;
    }
  }

  Color get lightBorder {
    switch (this) {
      case PolicyStatus.active:
        return AppColors.primary.withValues(alpha: 0.25);
      case PolicyStatus.expired:
        return AppColors.error.withValues(alpha: 0.25);
      case PolicyStatus.renewal:
        return AppColors.warning.withValues(alpha: 0.30);
      case PolicyStatus.noPlan:
        return AppColors.mono40.withValues(alpha: 0.4);
    }
  }

  static PolicyStatus fromString(String? value) {
    switch (value) {
      case 'expired':
        return PolicyStatus.expired;
      case 'renewal':
        return PolicyStatus.renewal;
      case 'none':
      case 'no_plan':
      case 'noPlan':
        return PolicyStatus.noPlan;
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

  /// True only when the doctor has never purchased/secured a plan.
  bool get hasNoPlan => status == PolicyStatus.noPlan;

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
