import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MedicoLegalFaqScreen extends StatefulWidget {
  const MedicoLegalFaqScreen({super.key});

  @override
  State<MedicoLegalFaqScreen> createState() => _MedicoLegalFaqScreenState();
}

class _MedicoLegalFaqScreenState extends State<MedicoLegalFaqScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<FaqItem> _faqs = const [
    FaqItem(
      number: '01',
      question: 'What counts as "medical negligence" under Indian law?',
      answer:
          'Indian courts apply the Bolam standard as adopted in Jacob Mathew v. State of Punjab — a doctor isn\'t negligent simply because treatment failed or a better alternative existed. Liability requires showing you lacked the skill you claimed to have, or didn\'t exercise reasonable competence you did possess, judged against an ordinary skilled practitioner in that field — not the best in the profession.',
    ),
    FaqItem(
      number: '02',
      question:
          'Civil claim, criminal case, or NMC complaint — what\'s the difference?',
      answer:
          'The same incident can trigger three separate proceedings: a civil/consumer complaint (compensation, decided on balance of probabilities), a criminal case under BNS Section 106 — formerly IPC 304A — (requires proof of "gross" negligence), and a professional conduct complaint before your medical council (can affect your registration). Each has a different standard of proof, and one doesn\'t automatically follow from another.',
    ),
    FaqItem(
      number: '03',
      question:
          'I\'ve just received a legal notice alleging negligence. What first?',
      answer:
          'Don\'t respond directly to the patient or family, and don\'t alter or add to the medical records. Preserve the original case file exactly as it stands, note your own recollection of events while it\'s fresh, and contact Legal Support immediately so a reply can be drafted within the notice period.',
      isAlert: true,
    ),
    FaqItem(
      number: '04',
      question:
          'Why does an "independent expert opinion" matter before prosecution?',
      answer:
          'In a ruling, the Supreme Court reiterated that before a doctor can be criminally prosecuted for negligence, investigators must first obtain an independent opinion from a qualified doctor in the same specialty — a safeguard meant to filter out cases that are really about treatment outcomes rather than gross negligence. If this step was skipped in a case against you, flag it to your legal counsel immediately.',
    ),
    FaqItem(
      number: '05',
      question: 'What documents should I preserve if a complaint is filed?',
      answer:
          'Original case sheets, consent forms, nursing notes, OT/procedure notes, investigation reports, discharge summary, correspondence with the patient/family, and any internal incident reports. Preserve them exactly as they are — do not edit, backdate, or add retrospective notes, as this can seriously undermine an otherwise defensible case.',
    ),
    FaqItem(
      number: '06',
      question: 'What are my rights if police arrive over a patient complaint?',
      answer:
          'You\'re entitled to see the complaint/FIR if one exists, to have legal representation present, and you\'re not obligated to hand over original patient records without a proper written requisition — certified copies are usually sufficient. Avoid making any statement beyond basic facts until you\'ve spoken with legal counsel.',
      isAlert: true,
    ),
    FaqItem(
      number: '07',
      question: 'Am I liable for a junior doctor or resident\'s mistake?',
      answer:
          'Possibly, under supervisory/vicarious liability — especially in a clinic or nursing home you control, or where you had a duty to supervise. It typically depends on whether you exercised reasonable supervision and whether the error was foreseeable and preventable given your oversight role.',
    ),
    FaqItem(
      number: '08',
      question:
          'What counts as valid "informed consent," and how do I document it?',
      answer:
          'Consent must be specific to the procedure, cover material risks a reasonable patient would want to know, and be free of coercion. Generic pre‑printed forms with no procedure‑specific detail offer weak protection. Best practice: a dated, timed, signed consent note in plain language, ideally witnessed for high‑risk procedures.',
    ),
    FaqItem(
      number: '09',
      question:
          'A patient\'s family is threatening to post about me online. Now what?',
      answer:
          'It can amount to defamation depending on whether the statements are false and damaging — but pursuing that while a genuine grievance is unresolved can backfire publicly. Document the posts, avoid engaging online yourself, and route your response through Legal Support rather than replying personally.',
    ),
    FaqItem(
      number: '10',
      question:
          'If I switch insurers, does my new policy cover older incidents?',
      answer:
          'Only if you specifically secure retroactive coverage back to your original practice start date — most professional indemnity policies only cover incidents from the retroactive date forward. This is why staying continuously covered, even when changing insurers, matters so much.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqs.where((faq) {
      final query = _searchQuery.toLowerCase();
      return faq.question.toLowerCase().contains(query) ||
          faq.answer.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(title: 'Medical Law 101'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Common medico‑legal questions, answered in plain language for Indian practice.',
                    style: customTextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ).copyWith(height: 1.4),
                  ),
                  height(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFCD34D)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Color(0xFF92400E),
                        ),
                        width(8),
                        Expanded(
                          child: Text(
                            'Educational only — not a substitute for legal advice on your specific situation.',
                            style: customTextStyle(
                              fontSize: 11,
                              color: const Color(0xFF92400E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height(16),

                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: 'Search legal topics, BNS, consent...',
                      hintStyle: customTextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            // FAQ Accordion List
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: filteredFaqs.isEmpty
                  ? Center(
                      // padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'No matching legal topics found.',
                        style: customTextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredFaqs.length,
                      separatorBuilder: (_, __) => height(12),
                      itemBuilder: (context, index) {
                        return _buildFaqTile(filteredFaqs[index]);
                      },
                    ),
            ),

            // Urgent Legal Support Callout
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.newPri.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.newPri.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.newPri,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.gavel,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                    width(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Facing an active notice or police inquiry?',
                            style: customTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.newPri,
                            ),
                          ),
                          height(2),
                          Text(
                            'Connect with our Medico-Legal Cell directly.',
                            style: customTextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Action for Legal Cell Hotline
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.newPri,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: const Text('Contact'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile(FaqItem item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isAlert
              ? const Color(0xFFFCA5A5)
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Text(
            item.number,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: item.isAlert ? const Color(0xFFDC2626) : AppColors.newPri,
            ),
          ),
          title: Text(
            item.question,
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
          children: [
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            height(12),
            Text(
              item.answer,
              style: customTextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem {
  final String number;
  final String question;
  final String answer;
  final bool isAlert;

  const FaqItem({
    required this.number,
    required this.question,
    required this.answer,
    this.isAlert = false,
  });
}
