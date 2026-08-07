// Add these alongside your existing suppport_enums.dart (or merge into it).
// Reuses your existing `PriorityLevel` and `AppointmentMode` enums —
// only the enums below are new.

/// "Query type" dropdown on the Legal Support form.
enum LegalQueryType { registerQuery, onCallSupport, bookAppointment }

extension LegalQueryTypeX on LegalQueryType {
  String get displayName {
    switch (this) {
      case LegalQueryType.registerQuery:
        return 'Register / Request a Query';
      case LegalQueryType.onCallSupport:
        return 'On‑Call Support';
      case LegalQueryType.bookAppointment:
        return 'Book Appointment';
    }
  }
}

/// "Related to" dropdown on the Service Support form.
enum ServiceRelatedTo {
  renewal,
  documents,
  payments,
  endorsement,
  upgrade,
  membershipClarification,
}

extension ServiceRelatedToX on ServiceRelatedTo {
  String get displayName {
    switch (this) {
      case ServiceRelatedTo.renewal:
        return 'Renewal';
      case ServiceRelatedTo.documents:
        return 'Documents';
      case ServiceRelatedTo.payments:
        return 'Payments';
      case ServiceRelatedTo.endorsement:
        return 'Endorsement';
      case ServiceRelatedTo.upgrade:
        return 'Upgrade';
      case ServiceRelatedTo.membershipClarification:
        return 'Membership clarification';
    }
  }
}

/// "Preferred contact" dropdown on the Service Support form.
enum PreferredContact { chatSupport, onCallSupport }

extension PreferredContactX on PreferredContact {
  String get displayName {
    switch (this) {
      case PreferredContact.chatSupport:
        return 'Chat Support';
      case PreferredContact.onCallSupport:
        return 'On‑Call Support';
    }
  }
}

/// Legal ticket "category" chip — derived/assigned when a ticket is raised.
enum LegalTicketCategory { consultation, notice, legalCase }

extension LegalTicketCategoryX on LegalTicketCategory {
  String get displayName {
    switch (this) {
      case LegalTicketCategory.consultation:
        return 'Consultation';
      case LegalTicketCategory.notice:
        return 'Notice';
      case LegalTicketCategory.legalCase:
        return 'Case';
    }
  }
}

/// Common-query options, dependent on the selected [LegalQueryType].
const Map<LegalQueryType, List<String>> kLegalCommonQueries = {
  LegalQueryType.registerQuery: [
    'Notice Received — Need to Reply',
    'Notice Received — Need to Send',
    'Notice Received — Need to Send a Reminder',
    'Negligence Allegation Received',
    'Patient / Family Complaint Received',
    'Consumer Court Complaint Received',
    'Police Complaint / FIR Registered',
    'Medical Council Complaint Received',
    'Show‑Cause Notice from Medical Council',
    'Request for Case Status Update',
    'Request for Legal Opinion on a Treatment Decision',
    'Documentation Request',
    'Request for Draft Reply Review',
    'Query on Consent Form Wording',
    'Other',
  ],
  LegalQueryType.onCallSupport: [
    'Immediate Legal Guidance',
    'Emergency — Police at Clinic / Hospital',
    'Emergency — Media Enquiry at Premises',
    'Emergency — Family Threatening Legal Action',
    'Case Status Update',
    'Notice Drafting Assistance',
    'Notice Response Strategy Discussion',
    'Consent Form Guidance',
    'Documentation Guidance Before Meeting Investigators',
    'General Legal Query',
    'Other',
  ],
  LegalQueryType.bookAppointment: [
    'Case Discussion',
    'Document Review',
    'Court / Hearing Preparation',
    'Notice Response Strategy Discussion',
    'Settlement Discussion',
    'Expert Witness Coordination',
    'Evidence & Records Review Meeting',
    'Pre‑Litigation Strategy Session',
    'Consultation on a New Allegation',
    'Other',
  ],
};

/// Common-query options, dependent on the selected [ServiceRelatedTo].
const Map<ServiceRelatedTo, List<String>> kServiceCommonQueries = {
  ServiceRelatedTo.renewal: [
    'Help Renewing',
    'Renewal Letter Required',
    'Grace Period Query',
    'Premium Recalculation',
  ],
  ServiceRelatedTo.documents: [
    'Certificate Reissue',
    'Policy Copy Request',
    'Medical Reg. Certificate Update',
  ],
  ServiceRelatedTo.payments: [
    'Payment Failed',
    'Refund Status',
    'Invoice Request',
  ],
  ServiceRelatedTo.endorsement: [
    'Endorsement — Name Change',
    'Endorsement — Sum Assured',
    'Endorsement — Address Change',
    'Endorsement — Nominee Update',
  ],
  ServiceRelatedTo.upgrade: [
    'Plan Upgrade Request',
    'Coverage Increase Request',
  ],
  ServiceRelatedTo.membershipClarification: [
    'Coverage Query',
    'Terms Clarification',
    'General Question',
  ],
};