import 'dart:ui';

import 'package:flutter/material.dart';

enum LegalQueryType { registerQuery, onCallSupport, bookAppointment }

enum LegalType { legalNotice, legalConsultation, legalCase }

extension LegalTypeX on LegalType {
  String get displayName {
    switch (this) {
      case LegalType.legalNotice:
        return 'Legal Notice';
      case LegalType.legalConsultation:
        return 'Legal Consultation';
      case LegalType.legalCase:
        return 'Legal Case';
    }
  }

  String get apiValue {
    switch (this) {
      case LegalType.legalNotice:
        return 'NOTICE';
      case LegalType.legalConsultation:
        return 'CONSULTATION';
      case LegalType.legalCase:
        return 'CASE';
    }
  }
}

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

enum PriorityLevel {
  normal,
  high,
  urgent;

  String get displayName {
    switch (this) {
      case PriorityLevel.normal:
        return 'Normal';
      case PriorityLevel.high:
        return 'High';
      case PriorityLevel.urgent:
        return 'Urgent';
    }
  }
}

enum TicketStatus { open, inProgress, escalated, closed, cancelled }

extension TicketStatusX on TicketStatus {
  String get label {
    switch (this) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.escalated:
        return 'Escalated';
      case TicketStatus.closed:
        return 'Closed';
      case TicketStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isOpenish =>
      this == TicketStatus.open ||
          this == TicketStatus.inProgress ||
          this == TicketStatus.escalated;

  Color get color {
    switch (this) {
      case TicketStatus.open:
        return Colors.orange;
      case TicketStatus.inProgress:
        return Colors.blue;
      case TicketStatus.escalated:
        return Colors.deepOrange;
      case TicketStatus.closed:
        return Colors.green;
      case TicketStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case TicketStatus.open:
        return Icons.schedule_rounded;
      case TicketStatus.inProgress:
        return Icons.hourglass_bottom_rounded;
      case TicketStatus.escalated:
        return Icons.priority_high_rounded;
      case TicketStatus.closed:
        return Icons.check_circle_rounded;
      case TicketStatus.cancelled:
        return Icons.block_rounded;
    }
  }
}
enum AppointmentMode {
  videoCall,
  phoneCall,
  inPerson;

  String get displayName {
    switch (this) {
      case AppointmentMode.videoCall:
        return 'Video Call';
      case AppointmentMode.phoneCall:
        return 'Phone Call';
      case AppointmentMode.inPerson:
        return 'In Person';
    }
  }
}

enum ServiceRelatedTo {
  renewal,
  documents,
  payments,
  endorsement,
  upgrade,
  membershipClarification,
  bookAppointment,
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
      case ServiceRelatedTo.bookAppointment:
        return 'Book Appointment';
    }
  }
}

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
  ServiceRelatedTo.bookAppointment: [
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
