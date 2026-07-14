import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../model/certificate_model.dart';

class CertificateUploadField extends StatelessWidget {
  final String title;
  final List<CertificateModel> certificates;
  final ValueChanged<List<CertificateModel>> onChanged;
  final bool isRequired;

  const CertificateUploadField({
    super.key,
    required this.title,
    required this.certificates,
    required this.onChanged,
    this.isRequired = false,
  });

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null) return;

    final picked = result.files
        .where((f) => f.path != null)
        .map(
          (f) => CertificateModel(
        id: '${DateTime.now().millisecondsSinceEpoch}_${f.name}',
        name: f.name,
        file: File(f.path!),
      ),
    )
        .toList();

    onChanged([...certificates, ...picked]);
  }

  void _removeAt(int index) {
    final updated = [...certificates]..removeAt(index);
    onChanged(updated);
  }

  IconData _iconFor(String name) {
    final ext = name.split('.').last.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf;
    if (['jpg', 'jpeg', 'png'].contains(ext)) return Icons.image;
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            if (isRequired)
              const Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        if (certificates.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'No documents uploaded yet',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
        ...List.generate(certificates.length, (index) {
          final cert = certificates[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(_iconFor(cert.name), color: AppColors.newPri),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    cert.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                if (cert.isUploaded)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.check_circle, color: Colors.green, size: 18),
                  ),
                IconButton(
                  onPressed: () => _removeAt(index),
                  icon: const Icon(Icons.close, size: 18, color: Colors.red),
                ),
              ],
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: _pickFiles,
          icon: const Icon(Icons.upload_file),
          label: Text('Upload $title'),
          style: OutlinedButton.styleFrom(foregroundColor: AppColors.newPri),
        ),
      ],
    );
  }
}