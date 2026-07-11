import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../extensions/build_context_extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Privacy Policy', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context, "KALS360 – Privacy Policy"),
              _subtitle(context, "Effective Date: 01 January 2026"),
              const SizedBox(height: 16),

              _paragraph(
                context,
                'This Privacy Policy ("Policy") governs the collection, use, storage, disclosure, and protection of personal data by KALS360, a Human Resource Management System (HRMS) platform ("KALS360", "we", "our", "us"). This Policy is applicable to all users including employers, employees, candidates, consultants, contractors, and authorized users accessing or using KALS360.',
              ),

              _divider(context),

              _subtitle(context, "This Policy is framed in accordance with:"),
              _bullets(context, [
                "Information Technology Act, 2000",
                "Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011",
                "Digital Personal Data Protection Act, 2023 (India)",
              ]),

              _highlightBox(
                context,
                "By accessing or using KALS360, you agree to the terms of this Privacy Policy.",
              ),

              _divider(context),

              _section(context, "1. Scope of Application"),
              _paragraph(
                context,
                "This Policy applies to all personal data processed by KALS360 on behalf of its client organizations and users, whether through web application, mobile application, APIs, or integrations.",
              ),

              _section(context, "2. Categories of Data Collected"),
              _subsection(context, "a) Personal Data:"),
              _bullets(context, [
                "Name, address, email ID, phone number, date of birth, gender",
                "Employee ID, designation, department",
                "Educational and employment details",
              ]),
              _subsection(context, "b) Sensitive Personal Data:"),
              _bullets(context, [
                "Bank account details, salary information, tax data",
                "PAN, Aadhaar (where legally permitted)",
                "UAN, ESIC, biometric/attendance data",
                "Login credentials",
              ]),
              _subsection(context, "c) Technical & Usage Data:"),
              _bullets(context, [
                "IP address, device information, browser details",
                "Access logs, timestamps, cookies",
              ]),

              _section(context, "3. Purpose of Processing"),
              _paragraph(
                context,
                "Data is processed strictly for legitimate HR and business purposes including:",
              ),
              _bullets(context, [
                "Employee onboarding and lifecycle management",
                "Payroll processing and statutory compliance (PF, ESIC, TDS, labor laws)",
                "Attendance, leave, and performance management",
                "Communication and notifications",
                "Audit, security, analytics, and system improvement",
              ]),

              _section(context, "4. Lawful Basis for Processing"),
              _paragraph(context, "Personal data is processed based on:"),
              _bullets(context, [
                "Consent of the data principal",
                "Contractual obligations with employers/clients",
                "Compliance with legal and regulatory requirements",
                "Legitimate business interests",
              ]),

              _section(context, "5. Data Sharing and Disclosure"),
              _paragraph(
                context,
                "KALS360 does not sell or trade personal data. Data may be shared only with:",
              ),
              _bullets(context, [
                "Authorized client representatives",
                "Government authorities as mandated by law",
                "Statutory bodies (PF, ESIC, Income Tax, etc.)",
                "Trusted third-party service providers under confidentiality and data protection agreements",
              ]),

              _section(context, "6. Data Storage and Retention"),
              _paragraph(
                context,
                "Data is stored on secure servers located in India or other legally permitted jurisdictions. Data is retained only for the duration required to fulfill contractual, statutory, or legal obligations and is securely deleted or anonymized thereafter.",
              ),

              _section(context, "7. Data Security Measures"),
              _paragraph(
                context,
                "KALS360 implements reasonable and industry-standard security measures including:",
              ),
              _bullets(context, [
                "Role-based access controls",
                "Encryption of data at rest and in transit",
                "Secure authentication mechanisms",
                "Periodic audits and monitoring",
                "Restricted access to sensitive data",
              ]),

              _section(context, "8. Rights of Data Principals"),
              _paragraph(
                context,
                "Subject to applicable laws, users have the right to:",
              ),
              _bullets(context, [
                "Access their personal data",
                "Request correction or updation",
                "Withdraw consent where applicable",
                "Request erasure or anonymization (subject to statutory retention)",
              ]),
              _noteBox(
                context,
                "Requests may be routed through the employer administrator or official support channels.",
              ),

              _section(context, "9. Cookies and Tracking"),
              _paragraph(
                context,
                "Cookies are used for session management, authentication, analytics, and improving user experience. Users may control cookies through browser settings.",
              ),

              _section(context, "10. Children's Data"),
              _paragraph(
                context,
                "KALS360 is not intended for use by individuals below 18 years of age. We do not knowingly process children's personal data.",
              ),

              _section(context, "11. Policy Updates"),
              _paragraph(
                context,
                "This Privacy Policy may be updated periodically. Continued use of KALS360 constitutes acceptance of the updated Policy.",
              ),

              _section(context, "12. Grievance & Contact Information"),
              _paragraph(
                context,
                "For any queries, concerns, or grievances related to data protection, please contact:",
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
        color: context.primaryTextColor.withValues(alpha: 0.7),
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

  Widget _subsection(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 6),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: context.primaryTextColor,
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
    color: context.secondaryTextColor.withValues(alpha: 0.2),
  );

  Widget _highlightBox(BuildContext context, String text) => Container(
    margin: const EdgeInsets.only(top: 12, bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: context.secondaryTextColor.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: context.secondaryTextColor.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 18, color: context.secondaryTextColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.primaryTextColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _noteBox(BuildContext context, String text) => Container(
    margin: const EdgeInsets.only(top: 8, bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: context.secondaryBackgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: context.primaryTextColor.withValues(alpha: 0.8),
        height: 1.4,
      ),
    ),
  );

  Widget _contactBox(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.secondaryTextColor.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: context.secondaryTextColor.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outline,
              size: 18,
              color: context.secondaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Data Protection Officer",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.business_outlined,
              size: 18,
              color: context.secondaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              "KALS360",
              style: TextStyle(fontSize: 13, color: context.primaryTextColor),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
