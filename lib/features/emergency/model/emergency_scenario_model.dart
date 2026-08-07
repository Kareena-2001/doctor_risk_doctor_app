class EmergencyScenarioModel {
  final String id;
  final String title;
  final String subtitle;
  final String sopPdfUrl;
  final List<String> checklistSteps;

  const EmergencyScenarioModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.sopPdfUrl,
    required this.checklistSteps,
  });
}

final List<EmergencyScenarioModel> emergencyScenariosList = [
  const EmergencyScenarioModel(
    id: 'scen_1',
    title: "A patient's family is threatening me",
    subtitle: "De‑escalation steps and who to call first.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/de_escalation.pdf',
    checklistSteps: [
      'Remain calm and maintain a non-confrontational posture.',
      'Alert clinic security or senior staff immediately.',
      'Do not engage in arguments or admit liability verbally.',
      'Move to a secure room with CCTV coverage if safety is compromised.',
      'Contact DoctorsRisk 24x7 Legal Hotline.',
    ],
  ),
  const EmergencyScenarioModel(
    id: 'scen_2',
    title: "Police have arrived at my clinic",
    subtitle: "What documents to show, what to never say.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/police_visit.pdf',
    checklistSteps: [
      'Ask for the officer’s name, designation, and official ID.',
      'Request the specific copy of the complaint or FIR.',
      'Do not provide verbal statements without legal representation.',
      'Hand over requested medical records only against a signed acknowledgment.',
      'Notify your medico-legal team immediately.',
    ],
  ),
  const EmergencyScenarioModel(
    id: 'scen_3',
    title: "Media has arrived at my hospital",
    subtitle: "Approved statements and escalation contacts.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/media_protocol.pdf',
    checklistSteps: [
      'Designate a single official spokesperson; prohibit unauthorized staff interviews.',
      'Provide a standard holding statement: "We are reviewing the matter with authorities."',
      'Never share patient personal health information (PHI) with reporters.',
      'Direct journalists to wait in a designated non-clinical area.',
    ],
  ),
  const EmergencyScenarioModel(
    id: 'scen_4',
    title: "What documents should I preserve?",
    subtitle: "The exact records to secure within 24 hours.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/document_preservation.pdf',
    checklistSteps: [
      'Lock electronic health records (EHR) to prevent edits or retroactive changes.',
      'Secure physical treatment charts, consent forms, and nursing notes.',
      'Preserve diagnostic logs, OT registers, and CCTV footage of the date in question.',
      'Create verified duplicate copies of all original documents.',
    ],
  ),
  const EmergencyScenarioModel(
    id: 'scen_5',
    title: "I've received a negligence allegation",
    subtitle: "First 48 hours: what to do and not do.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/negligence_allegation.pdf',
    checklistSteps: [
      'Do not reply directly to the patient or notice issuer without legal vetting.',
      'Document a complete, chronological event summary while memory is fresh.',
      'Notify DoctorsRisk legal department immediately with the notice copy.',
      'Refrain from discussing the incident on social media or group chats.',
    ],
  ),
  const EmergencyScenarioModel(
    id: 'scen_6',
    title: "I'm being asked to sign a statement",
    subtitle: "Know your rights before you put pen to paper.",
    sopPdfUrl: 'https://doctorsrisk.com/sops/signing_statements.pdf',
    checklistSteps: [
      'Read every sentence carefully before signing any paper.',
      'Ensure you are given a complete copy of anything you sign.',
      'Write "Signed under review with counsel" if compelled under pressure.',
      'Consult your legal expert before providing formal written statements.',
    ],
  ),
];