enum ReferralStatus { joined, pending }

class ReferralEntry {
  final String id;
  final String doctorName;
  final DateTime date;
  final ReferralStatus status;
  final int pointsEarned;

  const ReferralEntry({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.status,
    this.pointsEarned = 0,
  });

  factory ReferralEntry.fromJson(Map<String, dynamic> json) {
    return ReferralEntry(
      id: json['id']?.toString() ?? '',
      doctorName: (json['doctorName'] ?? json['name'] ?? '').toString(),
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      status: json['status']?.toString().toLowerCase() == 'joined'
          ? ReferralStatus.joined
          : ReferralStatus.pending,
      pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctorName': doctorName,
    'date': date.toIso8601String(),
    'status': status == ReferralStatus.joined ? 'joined' : 'pending',
    'pointsEarned': pointsEarned,
  };
}

class ReferralSummary {
  final String referralLink;
  final int peersReferredCount;
  final List<ReferralEntry> referrals;

  const ReferralSummary({
    required this.referralLink,
    required this.peersReferredCount,
    required this.referrals,
  });

  factory ReferralSummary.empty() => const ReferralSummary(
    referralLink: '',
    peersReferredCount: 0,
    referrals: [],
  );

  factory ReferralSummary.fromJson(Map<String, dynamic> json) {
    return ReferralSummary(
      referralLink: json['referralLink']?.toString() ?? '',
      peersReferredCount: (json['peersReferredCount'] as num?)?.toInt() ?? 0,
      referrals: (json['referrals'] as List<dynamic>? ?? [])
          .map((e) => ReferralEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReferralFormData {
  final String name;
  final String speciality;
  final String number;
  final String? email;
  final String? remark;

  const ReferralFormData({
    required this.name,
    required this.speciality,
    required this.number,
    this.email,
    this.remark,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'speciality': speciality,
    'number': number,
    if (email != null && email!.trim().isNotEmpty) 'email': email!.trim(),
    if (remark != null && remark!.trim().isNotEmpty) 'remark': remark!.trim(),
  };
}