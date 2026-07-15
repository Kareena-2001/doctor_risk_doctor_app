import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/section_card.dart';
import 'package:Doctors_App/features/profile/model/certificate_model.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_data.dart';
import 'package:Doctors_App/features/profile/model/policy_model.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/dimensions.dart';
import '../../../theme/app_colors.dart';

class ProfileViewScreen extends StatelessWidget {
  final DoctorProfileData data;
  final List<PolicyModel> policies;

  const ProfileViewScreen({
    super.key,
    required this.data,
    this.policies = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBack: false,
        showEdit: true,
        onEdit: () {
          context.push(Routes.editProfile);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionCard(
              title: 'Personal Details',
              icon: Icons.person,
              children: [
                _InfoRow(label: 'Name', value: data.fullName),
                _InfoRow(label: 'Email ID', value: data.email),
                _InfoRow(label: 'Mobile number', value: data.mobile),
                if ((data.alternateMobile ?? '').isNotEmpty)
                  _InfoRow(
                    label: 'Alternate number',
                    value: data.alternateMobile!,
                  ),
                _InfoRow(label: 'Degree', value: data.degree),
                if (data.category.isNotEmpty)
                  _InfoRow(label: 'Category', value: data.category),
                if (data.organisation.isNotEmpty)
                  _InfoRow(
                    label: 'Organisation/Association',
                    value: data.organisation,
                  ),
                if (data.speciality.isNotEmpty)
                  _InfoRow(label: 'Speciality', value: data.speciality),
                _InfoRow(
                  label: 'Date of birth',
                  value: data.dob != null
                      ? DateFormat('dd/MM/yyyy').format(data.dob!)
                      : '-',
                ),
                if (data.gender.isNotEmpty)
                  _InfoRow(label: 'Gender', value: data.gender),
                if (data.religion.isNotEmpty)
                  _InfoRow(label: 'Religion', value: data.religion),
              ],
            ),
            height(10),
            SectionCard(
              title: 'Clinic/Hospital Addresses',
              icon: Icons.location_on,
              children: data.addresses.isEmpty
                  ? [const _EmptyState(text: 'No addresses added yet')]
                  : List.generate(data.addresses.length, (index) {
                      final a = data.addresses[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Address ${index + 1}',
                                  style: customTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.newPri.withValues(
                                        alpha: .08,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.edit_outlined,
                                          size: 16,
                                          color: AppColors.newPri,
                                        ),
                                        width(4),
                                        Text(
                                          "Edit",
                                          style: customTextStyle(
                                            color: AppColors.newPri,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height(6),
                            _InfoRow(
                              label: 'Address Line 1',
                              value: a.address1,
                            ),
                            if (a.address2.isNotEmpty)
                              _InfoRow(
                                label: 'Address Line 2',
                                value: a.address2,
                              ),
                            if (a.landmark.isNotEmpty)
                              _InfoRow(label: 'Landmark', value: a.landmark),
                            _InfoRow(label: 'Pincode', value: a.pinCode),
                            _InfoRow(label: 'City', value: a.city),
                            _InfoRow(label: 'State', value: a.state),
                          ],
                        ),
                      );
                    }),
            ),
            height(10),
            SectionCard(
              title: 'Doctor Certificates',
              icon: Icons.badge_outlined,
              children: [
                _CertificateList(certificates: data.doctorCertificates),
              ],
            ),
            height(10),
            SectionCard(
              title: 'Organisation Certification',
              icon: Icons.apartment_outlined,
              children: [
                _CertificateList(certificates: data.organisationCertificates),
              ],
            ),
            // height(10),
            // SectionCard(
            //   title: 'Policy Information',
            //   icon: Icons.health_and_safety_outlined,
            //   children: policies.isEmpty
            //       ? [const _EmptyState(text: 'No policy purchased yet')]
            //       : List.generate(policies.length, (index) {
            //           return _PolicyCard(policy: policies[index]);
            //         }),
            // ),
            height(100),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Responsive.w(150),
            child: Text(
              label,
              style: customTextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: customTextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;

  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Text(
        text,
        style: customTextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}

class _CertificateList extends StatelessWidget {
  final List<CertificateModel> certificates;

  const _CertificateList({required this.certificates});

  IconData _iconFor(String name) {
    final ext = name.split('.').last.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf;
    if (['jpg', 'jpeg', 'png'].contains(ext)) return Icons.image;
    return Icons.insert_drive_file;
  }

  Future<void> _open(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewCertificates = certificates.isEmpty
        ? [
            CertificateModel(
              name: 'MBBS_Certificate.pdf',
              url: 'https://example.com/file.pdf',
              id: '',
            ),
            CertificateModel(
              name: 'Medical_Council_Registration.pdf',
              url: 'https://example.com/file2.pdf',
              id: '',
            ),
          ]
        : certificates;
    return Column(
      children: previewCertificates.map((cert) {
        return InkWell(
          onTap: () => _open(cert.url),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(_iconFor(cert.name), color: AppColors.newPri),
                width(8),
                Expanded(
                  child: Text(
                    cert.name,
                    overflow: TextOverflow.ellipsis,
                    style: customTextStyle(fontSize: 13),
                  ),
                ),
                if (cert.url != null && cert.url!.isNotEmpty)
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  final PolicyModel policy;

  const _PolicyCard({required this.policy});

  Color get _statusColor {
    switch (policy.status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  policy.planName,
                  style: customTextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  policy.status,
                  style: customTextStyle(
                    color: _statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          height(8),
          _InfoRow(label: 'Insurer', value: policy.insurerName),
          _InfoRow(label: 'Policy number', value: policy.policyNumber),
          _InfoRow(
            label: 'Purchase date',
            value: DateFormat('dd/MM/yyyy').format(policy.purchaseDate),
          ),
          _InfoRow(
            label: 'Retroactive date',
            value: policy.retroactiveDate != null
                ? DateFormat('dd/MM/yyyy').format(policy.retroactiveDate!)
                : '-',
          ),
          if (policy.expiryDate != null)
            _InfoRow(
              label: 'Expiry date',
              value: DateFormat('dd/MM/yyyy').format(policy.expiryDate!),
            ),
          if (policy.premiumAmount != null)
            _InfoRow(
              label: 'Premium',
              value: '\u20b9 ${policy.premiumAmount!.toStringAsFixed(2)}',
            ),
        ],
      ),
    );
  }
}
