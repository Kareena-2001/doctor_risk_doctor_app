import 'package:Doctors_App/core/exceptions/app_exception.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/events/model/collaboration_response.dart';
import 'package:Doctors_App/features/events/ui/view_model/events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/values/app_text_style.dart';
import '../../../../theme/app_colors.dart';

class CollaborateTab extends ConsumerStatefulWidget {
  const CollaborateTab({super.key});

  @override
  ConsumerState<CollaborateTab> createState() => _CollaborateTabState();
}

class _CollaborateTabState extends ConsumerState<CollaborateTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(eventsViewModelProvider.notifier).collaborationList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final listState = ref.watch(eventsViewModelProvider).collaborationList;

    return AppRefreshIndicator(
      onRefresh: () =>
          ref.read(eventsViewModelProvider.notifier).refreshCollaborationList(),
      child: listState.when(
        loading: () => Loading(),
        error: (error, _) => CommonErrorState(
          title: '',
          message: error is ApiException ? error.message : error.toString(),
          onRetry: () => ref
              .read(eventsViewModelProvider.notifier)
              .refreshCollaborationList(),
        ),
        data: (response) {
          final proposals = response.data;

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(16),
              vertical: Responsive.h(16),
            ),
            itemCount: proposals.isEmpty ? 2 : proposals.length + 1,
            separatorBuilder: (_, __) => height(Responsive.h(14)),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildInfoCard();
              }

              if (proposals.isEmpty) {
                return CommonEmptyState(
                  title: 'No collaboration proposals yet.',
                );
              }

              final proposal = proposals[index - 1];
              return _CollaborationCard(proposal: proposal);
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        "Want to organise a session with DoctorsRisk — a joint CME, "
        "workshop, or speaker exchange? Propose it below. "
        "You'll earn reward points once the collaboration is confirmed "
        "and successfully completed — even if you're not yet a "
        "DoctorsRisk member.",
        style: customTextStyle(
          fontSize: Responsive.sp(11),
          fontWeight: FontWeight.w600,
          color: AppColors.newPri,
        ),
      ),
    );
  }
}

class _CollaborationCard extends StatelessWidget {
  final CollaborationData proposal;

  const _CollaborationCard({required this.proposal});

  @override
  Widget build(BuildContext context) {
    final title = proposal.title;
    final organisation = proposal.organization;
    final status = proposal.approveStatus;

    final submitted = proposal.submitted;
    final statusStyle = _getStatusStyle(status);

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: context.secondaryWidgetColor,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: customTextStyle(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                height(Responsive.h(7)),
                Text(
                  submitted.isNotEmpty
                      ? '$organisation · $submitted'
                      : organisation,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: AppColors.homeTextMuted,
                  ),
                ),
              ],
            ),
          ),
          width(Responsive.w(8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(9),
              vertical: Responsive.h(5),
            ),
            decoration: BoxDecoration(
              color: statusStyle.bgColor,
              borderRadius: BorderRadius.circular(Responsive.w(8)),
            ),
            child: Text(
              status,
              style: customTextStyle(
                fontSize: Responsive.sp(10),
                fontWeight: FontWeight.bold,
                color: statusStyle.textColor,
              ),
            ),
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.more_vert,
              size: Responsive.sp(18),
              color: AppColors.homeTextMuted,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Responsive.w(12)),
            ),
            onSelected: (value) {
              if (value == 'view') {
                _showCollaborationDetails(context, proposal);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'view',
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: Responsive.sp(16),
                      color: AppColors.textColor,
                    ),
                    width(Responsive.w(8)),
                    Text(
                      'View',
                      style: customTextStyle(
                        fontSize: Responsive.sp(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCollaborationDetails(
    BuildContext context,
    CollaborationData proposal,
  ) {
    final statusStyle = _getStatusStyle(proposal.approveStatus);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.35,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: context.secondaryWidgetColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Responsive.w(20)),
                ),
              ),
              child: Column(
                children: [
                  height(Responsive.h(10)),
                  Container(
                    width: Responsive.w(40),
                    height: Responsive.h(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(Responsive.w(4)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16),
                      vertical: Responsive.h(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Collaboration details',
                            style: customTextStyle(
                              fontSize: Responsive.sp(15),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(9),
                            vertical: Responsive.h(5),
                          ),
                          decoration: BoxDecoration(
                            color: statusStyle.bgColor,
                            borderRadius: BorderRadius.circular(
                              Responsive.w(8),
                            ),
                          ),
                          child: Text(
                            proposal.approveStatus,
                            style: customTextStyle(
                              fontSize: Responsive.sp(10),
                              fontWeight: FontWeight.bold,
                              color: statusStyle.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.all(Responsive.w(16)),
                      children: [
                        _DetailRow(label: 'Title', value: proposal.title),
                        _DetailRow(
                          label: 'Organisation',
                          value: proposal.organization,
                        ),
                        _DetailRow(
                          label: 'Mode of event',
                          value: proposal.modeOfEvent,
                        ),
                        _DetailRow(
                          label: 'Preferred date',
                          value: proposal.date,
                        ),
                        _DetailRow(
                          label: 'Preferred time',
                          value: proposal.preferedTime,
                        ),
                        _DetailRow(label: 'State', value: proposal.state),
                        _DetailRow(label: 'City', value: proposal.city),
                        _DetailRow(label: 'Area', value: proposal.area),
                        _DetailRow(label: 'Purpose', value: proposal.purpose),
                        _DetailRow(
                          label: 'Submitted',
                          value: proposal.submitted,
                        ),
                        _DetailRow(
                          label: 'Status',
                          value: proposal.approveStatus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _StatusStyle _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'approved':
        return _StatusStyle(
          bgColor: Colors.green.withValues(alpha: 0.1),
          textColor: Colors.green,
        );
      case 'under review':
      case 'pending':
        return _StatusStyle(
          bgColor: Colors.orange.withValues(alpha: 0.1),
          textColor: Colors.orange.shade800,
        );
      case 'rejected':
        return _StatusStyle(
          bgColor: Colors.red.withValues(alpha: 0.1),
          textColor: Colors.red,
        );
      default:
        return _StatusStyle(
          bgColor: Colors.blue.withValues(alpha: 0.1),
          textColor: Colors.blue,
        );
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.h(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: customTextStyle(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w500,
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(3)),
          Text(
            value!,
            style: customTextStyle(
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusStyle {
  final Color bgColor;
  final Color textColor;

  _StatusStyle({required this.bgColor, required this.textColor});
}
