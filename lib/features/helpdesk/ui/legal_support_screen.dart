import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../theme/app_colors.dart';
import '../model/suppport_enums.dart';

const _medicoLegalCallNumber = '+911234567890';
const _legalCallNumber = '+911234567891';

class LegalSupportScreen extends ConsumerStatefulWidget {
  const LegalSupportScreen({super.key});

  @override
  ConsumerState<LegalSupportScreen> createState() => _LegalSupportScreenState();
}

class _LegalSupportScreenState extends ConsumerState<LegalSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Legal Support'),
      body: Column(
        children: [
          _OnCallSupportView(
            medicoLegalNumber: _medicoLegalCallNumber,
            legalNumber: _legalCallNumber,
          ),
        ],
      ),
    );
  }
}

class _OnCallSupportView extends StatefulWidget {
  final String medicoLegalNumber;
  final String legalNumber;

  const _OnCallSupportView({
    required this.medicoLegalNumber,
    required this.legalNumber,
  });

  @override
  State<_OnCallSupportView> createState() => _OnCallSupportViewState();
}

class _OnCallSupportViewState extends State<_OnCallSupportView> {
  QueryType? _queryType;

  Future<void> _call() async {
    if (_queryType == null) return;
    final number = _queryType == QueryType.medicoLegal
        ? widget.medicoLegalNumber
        : widget.legalNumber;
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.support_agent_rounded, size: 48, color: AppColors.newPri),
          height(12),
          Text(
            'Emergency Expert Support',
            style: customTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          height(4),
          Text(
            'Select the type of support you need — you\'ll be connected to the right line',
            style: customTextStyle(),
          ),
          height(20),
          CustomDropdownField<QueryType>(
            hint: 'Select type',
            label: 'Support Type',
            value: _queryType,
            items: QueryType.values,
            itemBuilder: (v) => v.displayName,
            onChanged: (v) => setState(() => _queryType = v),
          ),
          height(24),
          PrimaryButton(
            text: 'Call Now',
            backgroundColor: AppColors.newPri,
            onPressed: _queryType == null ? null : _call,
          ),
        ],
      ),
    );
  }
}
