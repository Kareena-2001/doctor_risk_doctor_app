enum QueryType {
  adminService,
  renewal,
  medicoLegal,
  legal;

  String get displayName {
    switch (this) {
      case QueryType.medicoLegal:
        return 'Medico Legal';
      case QueryType.legal:
        return 'Legal';
      case QueryType.adminService:
        return 'Admin Service';
      case QueryType.renewal:
        return 'Renewal';
    }
  }
}

enum RequestType {
  consultation,
  notice,
  preExistingCase;

  String get displayName {
    switch (this) {
      case RequestType.consultation:
        return 'Consultation';
      case RequestType.notice:
        return 'Notice';
      case RequestType.preExistingCase:
        return 'Pre-existing Case';
    }
  }
}

enum PriorityLevel {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case PriorityLevel.low:
        return 'Low';
      case PriorityLevel.medium:
        return 'Medium';
      case PriorityLevel.high:
        return 'High';
    }
  }
}

enum AppointmentMode {
  inPerson,
  videoCall,
  phoneCall;

  String get displayName {
    switch (this) {
      case AppointmentMode.inPerson:
        return 'In Person';
      case AppointmentMode.videoCall:
        return 'Video Call';
      case AppointmentMode.phoneCall:
        return 'Phone Call';
    }
  }
}

enum ChatSupportCategory {
  serviceDocuments,
  customerSupport,
  professionalDetailsChange,
  basicQuery;

  String get displayName {
    switch (this) {
      case ChatSupportCategory.serviceDocuments:
        return 'Service Documents';
      case ChatSupportCategory.customerSupport:
        return 'Customer Support';
      case ChatSupportCategory.professionalDetailsChange:
        return 'Changes in Professional Details';
      case ChatSupportCategory.basicQuery:
        return 'Basic Query';
    }
  }
}

enum TicketStage {
  open,
  inProgress,
  escalated,
  closed;

  String get displayName {
    switch (this) {
      case TicketStage.open:
        return 'Open';
      case TicketStage.inProgress:
        return 'In Progress';
      case TicketStage.escalated:
        return 'Escalated';
      case TicketStage.closed:
        return 'Closed';
    }
  }
}
