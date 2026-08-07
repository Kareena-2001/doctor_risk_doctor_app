enum TransactionType { earn, redeem }

class RewardTransactionModel {
  final String id;
  final String title;
  final String date;
  final int points;
  final TransactionType type;

  const RewardTransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.points,
    this.type = TransactionType.earn,
  });
}

class RewardsSummaryModel {
  final int availablePoints;
  final List<RewardTransactionModel> transactions;

  const RewardsSummaryModel({
    required this.availablePoints,
    required this.transactions,
  });
}

final rewardsData = RewardsSummaryModel(
  availablePoints: 320,
  transactions: [
    const RewardTransactionModel(
      id: 'tx_1',
      title: 'Referral converted — Dr. Kunal Bhatt became a member',
      date: '15 Jul 2026',
      points: 2400,
    ),
    const RewardTransactionModel(
      id: 'tx_2',
      title: 'Peer Forum post approved',
      date: '11 Jul 2026',
      points: 25,
    ),
    const RewardTransactionModel(
      id: 'tx_3',
      title: 'Referral converted — Dr. Priya Nair became a member',
      date: '10 Jul 2026',
      points: 3150,
    ),
    const RewardTransactionModel(
      id: 'tx_4',
      title: 'Testimonial published — "How DoctorsRisk Helped Me…"',
      date: '02 Jul 2026',
      points: 15,
    ),
    const RewardTransactionModel(
      id: 'tx_5',
      title: 'Experience published — "Defending a Split‑Second Call…"',
      date: '20 Jun 2026',
      points: 15,
    ),
    const RewardTransactionModel(
      id: 'tx_6',
      title: 'Blog published — "Defensive Charting After Adverse Drug Reactions"',
      date: '15 Jun 2026',
      points: 100,
    ),
  ],
);