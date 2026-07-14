import 'dart:io';

/// Represents a single certificate/document.
/// - `file` is set when the user has just picked it locally (not yet uploaded).
/// - `url` is set when it's already been uploaded and is coming from the backend.
class CertificateModel {
  final String id;
  final String name;
  final File? file;
  final String? url;
  final String? uploadedAt;

  CertificateModel({
    required this.id,
    required this.name,
    this.file,
    this.url,
    this.uploadedAt,
  });

  bool get isUploaded => url != null && url!.isNotEmpty;

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      url: json['url'],
      uploadedAt: json['uploadedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'uploadedAt': uploadedAt,
    };
  }

  CertificateModel copyWith({
    String? id,
    String? name,
    File? file,
    String? url,
    String? uploadedAt,
  }) {
    return CertificateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
      url: url ?? this.url,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}