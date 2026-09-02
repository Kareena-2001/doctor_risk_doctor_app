import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';
import '../../home/ui/widgets/social_link_widget.dart';

class NewsAdvisoryScreen extends StatefulWidget {
  const NewsAdvisoryScreen({super.key});

  @override
  State<NewsAdvisoryScreen> createState() => _NewsAdvisoryScreenState();
}

class _NewsAdvisoryScreenState extends State<NewsAdvisoryScreen> {
  final List<_NewsItem> _news = const [
    _NewsItem(
      source: 'Supreme Court of India',
      date: '25 May 2026',
      title:
          'Independent expert opinion now mandatory before prosecuting doctors',
      description:
          'The Supreme Court held that criminal prosecution of a doctor for alleged negligence first requires an independent opinion from a qualified specialist in the same field — reinforcing a higher threshold before a case can proceed as a criminal matter rather than a treatment dispute.',

      url:
          'https://lawbeat.in/supreme-court-judgments/medical-negligence-supreme-court-says-criminal-cases-need-independent-expert-opinion-1610302',
      icon: Icons.gavel_rounded,
    ),
    _NewsItem(
      source: 'Supreme Court of India',
      date: '12 Apr 2026',
      title:
          '"Surgeon is the best judge" of procedure, rules Court in 20-year-old case',
      description:
          'The Supreme Court quashed a two-decade-old criminal case against a paediatric surgeon, observing that the operating surgeon is best placed to decide which surgical approach to take during a procedure.',
      url:
          'https://lawbeat.in/supreme-court-judgments/medical-negligence-supreme-court-says-criminal-cases-need-independent-expert-opinion-1610302',
      icon: Icons.local_hospital_outlined,
    ),
    _NewsItem(
      source: 'Supreme Court of India',
      date: '04 May 2026',
      title: 'Legal heirs may now be party to ongoing medical negligence cases',
      description:
          'In a case involving alleged vision loss from an earlier procedure, the Supreme Court ruled that a doctor’s death does not end a pending negligence case and that legal heirs can be brought in to continue it.',
      url:
          'https://lawbeat.in/supreme-court-judgments/medical-negligence-supreme-court-says-criminal-cases-need-independent-expert-opinion-1610302',
      icon: Icons.family_restroom_outlined,
    ),
    _NewsItem(
      source: 'Supreme Court of India',
      date: '11 Mar 2026',
      reference: '2026 SCC OnLine SC 358',
      title:
          'Harish Rana v. Union of India: Court clarifies passive euthanasia & end-of-life care',
      description:
          'The Supreme Court permitted withdrawal of life-sustaining treatment for a patient in a persistent vegetative state for over 13 years, clarifying that artificial nutrition and hydration may constitute medical intervention.',
      url:
          'https://lawbeat.in/supreme-court-judgments/medical-negligence-supreme-court-says-criminal-cases-need-independent-expert-opinion-1610302',
      icon: Icons.health_and_safety_outlined,
    ),
    _NewsItem(
      source: 'National Medical Commission',
      date: '08 Jul 2026',
      reference: 'Gazette Notification',
      title:
          'NMC proposes amendments to medical institution & assessment regulations',
      description:
          'The National Medical Commission issued a Gazette notification proposing amendments to its 2023 regulations governing new medical institutions, courses and seat increases.',
      url:
          'https://lawbeat.in/supreme-court-judgments/medical-negligence-supreme-court-says-criminal-cases-need-independent-expert-opinion-1610302',
      icon: Icons.account_balance_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'News & Advisories'),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        itemCount: _news.length + 1,
        separatorBuilder: (_, index) {
          if (index == _news.length - 1) {
            return const SizedBox(height: 24);
          }

          return const SizedBox(height: 12);
        },
        itemBuilder: (context, index) {
          if (index == _news.length) {
            return Column(children: [SocialLinkWidget(), height(50)]);
          }

          final item = _news[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _openSource(item.url),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                item.source,
                                overflow: TextOverflow.ellipsis,
                                style: customTextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.newPri,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Text(
                                '•',
                                style: customTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.newPri,
                                ),
                              ),
                            ),

                            Text(
                              item.date,
                              style: customTextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.newPri,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  height(14),

                  Text(
                    item.title,
                    style: customTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ).copyWith(height: 1.35),
                  ),

                  height(9),

                  Text(
                    item.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade700,
                    ).copyWith(height: 1.5),
                  ),

                  height(14),

                  Row(
                    children: [
                      if (item.reference != null) ...[
                        Text(
                          item.reference!,
                          style: customTextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                      ] else
                        const Spacer(),

                      Text(
                        'Read source',
                        style: customTextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.newPri,
                        ),
                      ),

                      width(5),

                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                        color: AppColors.newPri,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openSource(String url) async {
    final uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the source website')),
        );
      }
    } catch (e) {
      debugPrint('Could not launch URL: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the source website')),
        );
      }
    }
  }
}

class _NewsItem {
  final String source;
  final String date;
  final String title;
  final String description;
  final String? reference;
  final String url;
  final IconData icon;

  const _NewsItem({
    required this.source,
    required this.date,
    required this.title,
    required this.description,
    required this.url,
    this.reference,
    required this.icon,
  });
}
