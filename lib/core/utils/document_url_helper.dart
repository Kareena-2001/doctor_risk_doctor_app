import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Used only when the API returns a relative path like "uploads/doctor_documents/1/a.jpg".
/// Full http(s) URLs (what your web app shows) are used as they are.
const String kDocumentBaseUrl =
    'https://medicolegalsupport.in/doctors_risk_api/';

String? resolveDocumentUrl(String? raw) {
  final value = raw?.trim();
  if (value == null || value.isEmpty) return null;
  if (value.startsWith('http://') || value.startsWith('https://')) {
    return value;
  }
  return '$kDocumentBaseUrl${value.startsWith('/') ? value.substring(1) : value}';
}

String? documentFileName(String? raw) {
  final value = raw?.trim();
  if (value == null || value.isEmpty) return null;
  return value.split('/').last;
}

Future<void> openUrl(BuildContext context, String? raw) async {
  final url = resolveDocumentUrl(raw);
  final uri = url == null ? null : Uri.tryParse(url);

  var opened = false;
  if (uri != null) {
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
  }

  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Unable to open link')));
  }
}
