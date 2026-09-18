import 'package:Doctors_App/core/exceptions/app_exception.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
import 'package:Doctors_App/core/widgets/common_empty_state.dart';
import 'package:Doctors_App/core/widgets/common_error_state.dart';
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
    final date = proposal.date;
    final preferredTime = proposal.preferedTime;
    final status = proposal.approveStatus;

    final statusStyle = _getStatusStyle(status);

    final detailsText = [
      if (date != null && date.isNotEmpty) date,
      if (preferredTime != null && preferredTime.isNotEmpty) preferredTime,
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Column(
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
                detailsText.isNotEmpty
                    ? '$organisation · $detailsText'
                    : organisation,
                style: customTextStyle(
                  fontSize: Responsive.sp(11),
                  color: AppColors.homeTextMuted,
                ),
              ),
            ],
          ),
          Spacer(),
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
        ],
      ),
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

class _StatusStyle {
  final Color bgColor;
  final Color textColor;

  _StatusStyle({required this.bgColor, required this.textColor});
}
