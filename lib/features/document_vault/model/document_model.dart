enum DocumentType { uploaded, companyIssued }

enum DocumentStatus { uploaded, notUploaded, issued, notYetIssued }

class DocumentItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? fileName;
  final String? uploadDate;
  final DocumentType type;
  final DocumentStatus status;
  final String? downloadUrl;
  final String? validityPeriod;

  const DocumentItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.fileName,
    this.uploadDate,
    required this.type,
    required this.status,
    this.downloadUrl,
    this.validityPeriod,
  });
}

// Data loaded from your account summary
final List<DocumentItem> userUploadedDocuments = [
  const DocumentItem(
    id: 'doc_1',
    title: 'Medical Registration Certificate — Self',
    fileName: 'medicalregisterationcert.jpg',
    uploadDate: '28 Aug 2025',
    type: DocumentType.uploaded,
    status: DocumentStatus.uploaded,
  ),
  const DocumentItem(
    id: 'doc_2',
    title: 'Medical Registration Certificate — Establishment',
    subtitle: 'for your Establishment plan',
    fileName: 'clinicregisterationcert.pdf',
    uploadDate: '22 Dec 2025',
    type: DocumentType.uploaded,
    status: DocumentStatus.uploaded,
  ),
  const DocumentItem(
    id: 'doc_3',
    title: 'Aadhaar Card',
    subtitle: 'Required for identity verification',
    type: DocumentType.uploaded,
    status: DocumentStatus.notUploaded,
  ),
  const DocumentItem(
    id: 'doc_4',
    title: 'Previous Policy Document',
    subtitle: 'Uploaded when switching from a previous insurer',
    fileName: 'NIAPareshMathur.pdf',
    type: DocumentType.uploaded,
    status: DocumentStatus.uploaded,
  ),
];

final List<DocumentItem> companyIssuedDocuments = [
  const DocumentItem(
    id: 'doc_5',
    title: 'Agreement / MOU',
    subtitle: 'Membership terms & conditions',
    type: DocumentType.companyIssued,
    status: DocumentStatus.issued,
  ),
  const DocumentItem(
    id: 'doc_6',
    title: 'Invoice — Product A (Personal Plan)',
    subtitle: '₹ 44,880',
    uploadDate: '28 Aug 2025',
    type: DocumentType.companyIssued,
    status: DocumentStatus.issued,
  ),
  const DocumentItem(
    id: 'doc_7',
    title: 'Invoice — Product C (Establishment Plan)',
    subtitle: '₹ 64,260',
    uploadDate: '22 Dec 2025',
    type: DocumentType.companyIssued,
    status: DocumentStatus.issued,
  ),
  const DocumentItem(
    id: 'doc_8',
    title: 'Policy Certificate — Product A, Year 1',
    validityPeriod: '01 Sep 2025 – 31 Aug 2026',
    type: DocumentType.companyIssued,
    status: DocumentStatus.issued,
  ),
  const DocumentItem(
    id: 'doc_9',
    title: 'Policy Certificate — Product A, Year 2',
    subtitle: 'Will be issued 01 Sep 2026, at the start of your second policy year',
    type: DocumentType.companyIssued,
    status: DocumentStatus.notYetIssued,
  ),
  const DocumentItem(
    id: 'doc_10',
    title: 'Policy Certificate — Product C (Establishment)',
    validityPeriod: '01 Jan 2026 – 31 Dec 2026',
    type: DocumentType.companyIssued,
    status: DocumentStatus.issued,
  ),
];