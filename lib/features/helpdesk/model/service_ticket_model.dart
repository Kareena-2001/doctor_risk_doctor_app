import 'package:flutter/material.dart';

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

class TicketRemark {
  final String author;
  final bool isTeam;
  final String? teamRole;
  final DateTime timestamp;
  final String message;
  final String? attachmentName;

  const TicketRemark({
    required this.author,
    required this.isTeam,
    this.teamRole,
    required this.timestamp,
    required this.message,
    this.attachmentName,
  });
}

class SupportTicket {
  final String ref;
  final String typeLabel; // e.g. "Register / Request a Query — Notice Received"
  final String? category; // Legal only: Consultation / Notice / Case
  final String priority;
  TicketStatus status;
  final String description;
  final DateTime raisedAt;
  final List<TicketRemark> remarks;

  SupportTicket({
    required this.ref,
    required this.typeLabel,
    this.category,
    required this.priority,
    required this.status,
    required this.description,
    required this.raisedAt,
    List<TicketRemark>? remarks,
  }) : remarks = remarks ?? [];

  bool get isEditable =>
      status == TicketStatus.open &&
          DateTime.now().difference(raisedAt).inHours < 36;

  int get editableHoursLeft =>
      (36 - DateTime.now().difference(raisedAt).inHours).clamp(0, 36);

  String get raisedAgo {
    final diff = DateTime.now().difference(raisedAt);
    if (diff.inHours < 24) {
      return diff.inHours <= 0 ? 'Just now' : '${diff.inHours}h ago';
    }
    return '${diff.inDays}d ago';
  }
}