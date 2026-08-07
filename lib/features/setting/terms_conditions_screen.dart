import 'package:flutter/material.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../extensions/build_context_extension.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Terms & Conditions', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context, "KALS360 – Terms & Conditions"),
              _subtitle(context, "Effective Date: 01 January 2026"),
              const SizedBox(height: 16),

              _paragraph(
                context,
                'These Terms & Conditions ("Terms") govern the access and use of KALS360, a Human Resource Management System (HRMS) software platform ("KALS360", "we", "our", "us"). By accessing or using KALS360, you agree to be bound by these Terms.',
              ),

              _divider(context),

              _section(context, "1. Definitions"),
              _definitionItem(
                context,
                '"Client"',
                "means any organization subscribing to KALS360.",
              ),
              _definitionItem(
                context,
                '"User"',
                "means employees, candidates, contractors, consultants, or authorized representatives.",
              ),
              _definitionItem(
                context,
                '"Services"',
                "include HRMS features such as payroll, attendance, compliance, onboarding, and reporting.",
              ),

              _section(context, "2. Eligibility & Access"),
              _bullets(context, [
                "Users must be 18 years or older",
                "Access is limited to authorized users approved by the Client",
                "Clients are responsible for maintaining credential confidentiality",
              ]),

              _section(context, "3. Scope of Services"),
              _paragraph(
                context,
                "KALS360 provides a technology platform for HR operations. KALS360 does not provide legal, tax, or financial advice.",
              ),

              _section(context, "4. User Obligations"),
              _paragraph(context, "Users agree to:"),
              _bullets(context, [
                "Provide accurate information",
                "Comply with applicable laws",
                "Not misuse, copy, reverse engineer, or disrupt the platform",
              ]),

              _section(context, "5. Data Protection & Privacy"),
              _paragraph(
                context,
                "Use of KALS360 is subject to the Privacy Policy. Clients act as Data Controllers and KALS360 as Data Processor under applicable data protection laws, including the DPDP Act, 2023.",
              ),

              _section(context, "6. Intellectual Property"),
              _paragraph(
                context,
                "All intellectual property rights in KALS360 belong exclusively to KALS360. Users receive a limited, non-exclusive, non-transferable right to use the Services.",
              ),

              _section(context, "7. Fees & Payments"),
              _paragraph(
                context,
                "Commercial terms shall be governed by separate agreements. Non-payment may result in suspension or termination.",
              ),

              _section(context, "8. Third-Party Services"),
              _paragraph(
                context,
                "KALS360 may integrate with third-party platforms. KALS360 is not responsible for third-party availability or actions.",
              ),

              _section(context, "9. Limitation of Liability"),
              _bullets(context, [
                "KALS360 shall not be liable for indirect or consequential damages",
                "Total liability shall not exceed fees paid in the previous 12 months",
              ]),

              _section(context, "10. Indemnity"),
              _paragraph(
                context,
                "Clients agree to indemnify KALS360 against claims arising from data inaccuracies, legal violations, or misuse.",
              ),

              _section(context, "11. Suspension & Termination"),
              _paragraph(
                context,
                "KALS360 may suspend or terminate access for breach or legal non-compliance.",
              ),

              _section(context, "12. Force Majeure"),
              _paragraph(
                context,
                "KALS360 shall not be liable for delays caused by events beyond reasonable control.",
              ),

              _section(context, "13. Governing Law & Jurisdiction"),
              _paragraph(
                context,
                "These Terms are governed by Indian law. Courts of Mumbai, Maharashtra shall have exclusive jurisdiction.",
              ),

              _section(context, "14. Amendments"),
              _paragraph(
                context,
                "KALS360 may modify these Terms. Continued use constitutes acceptance.",
              ),

              _section(context, "15. Contact Information"),
              _paragraph(
                context,
                "For any queries or concerns regarding these Terms, please contact:",
              ),
              const SizedBox(height: 8),
              _contactBox(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: context.primaryTextColor,
      ),
    ),
  );

  Widget _subtitle(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: context.primaryTextColor.withOpacity(0.7),
      ),
    ),
  );

  Widget _section(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: context.secondaryTextColor,
      ),
    ),
  );

  Widget _paragraph(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.6,
        color: context.primaryTextColor,
      ),
      textAlign: TextAlign.justify,
    ),
  );

  Widget _definitionItem(
    BuildContext context,
    String term,
    String definition,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$term ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
            height: 1.5,
          ),
        ),
        Expanded(
          child: Text(
            definition,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: context.primaryTextColor,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
  );

  Widget _bullets(BuildContext context, List<String> items) => Column(
    children: items
        .map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: context.secondaryTextColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: context.primaryTextColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList(),
  );

  Widget _divider(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    height: 1,
    color: context.secondaryTextColor.withOpacity(0.2),
  );

  Widget _contactBox(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.secondaryTextColor.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: context.secondaryTextColor.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.support_agent_outlined,
              size: 18,
              color: context.secondaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              "KALS360 Support",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
          ],
        ),
        height(10),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              size: 18,
              color: context.secondaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              "support@kals360.com",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
