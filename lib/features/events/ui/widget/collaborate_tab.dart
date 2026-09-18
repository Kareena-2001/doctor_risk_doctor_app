import 'package:Doctors_App/core/exceptions/app_exception.dart';
import 'package:Doctors_App/core/widgets/app_refresh_indicator.dart';
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

class _CollaborateTabState extends ConsumerState<CollaborateTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(eventsViewModelProvider.notifier).collaborationList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(eventsViewModelProvider).collaborationList;

    return AppRefreshIndicator(
      onRefresh: () =>
          ref.read(eventsViewModelProvider.notifier).refreshCollaborationList(),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          Responsive.w(16),
          0,
          Responsive.w(16),
          Responsive.h(24),
        ),
        children: [
          _buildInfoCard(),
          height(Responsive.h(18)),
          listState.when(
            loading: () => const _CollabLoading(),
            error: (error, _) => _CollabError(
              message: error is ApiException ? error.message : error.toString(),
              onRetry: () => ref
                  .read(eventsViewModelProvider.notifier)
                  .refreshCollaborationList(),
            ),
            data: (response) {
              final proposals = response.data ?? const [];
              if (proposals.isEmpty) return const _CollabEmpty();
              return Column(
                children: proposals
                    .map(
                      (p) => Padding(
                        padding: EdgeInsets.only(bottom: Responsive.h(14)),
                        child: _CollaborationCard(proposal: p),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: Colors.grey.shade200),
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

    final isCompleted =
        status.toLowerCase() == 'completed' ||
        status.toLowerCase() == 'approved';

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
          Row(
            children: [
              Icon(
                Icons.business_outlined,
                size: Responsive.sp(14),
                color: AppColors.homeTextMuted,
              ),
              width(Responsive.w(5)),
              Expanded(
                child: Text(
                  organisation,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    color: AppColors.homeTextMuted,
                  ),
                ),
              ),
            ],
          ),

          if (date != null || preferredTime != null) ...[
            height(Responsive.h(5)),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: Responsive.sp(13),
                  color: AppColors.homeTextMuted,
                ),
                width(Responsive.w(5)),
                Expanded(
                  child: Text(
                    [
                      if (date != null) date,
                      if (preferredTime != null) preferredTime,
                    ].join(' · '),
                    style: customTextStyle(
                      fontSize: Responsive.sp(11),
                      color: AppColors.homeTextMuted,
                    ),
                  ),
                ),
              ],
            ),
          ],

          height(Responsive.h(10)),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(9),
              vertical: Responsive.h(5),
            ),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Responsive.w(8)),
            ),
            child: Text(
              status,
              style: customTextStyle(
                fontSize: Responsive.sp(10),
                fontWeight: FontWeight.bold,
                color: isCompleted ? Colors.green : Colors.orange.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollabLoading extends StatelessWidget {
  const _CollabLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.h(40)),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _CollabError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CollabError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade300,
            size: Responsive.sp(36),
          ),
          height(Responsive.h(8)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.grey,
            ),
          ),
          height(Responsive.h(10)),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _CollabEmpty extends StatelessWidget {
  const _CollabEmpty();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.h(40)),
      child: Center(
        child: Text(
          'No collaboration proposals yet.',
          style: customTextStyle(
            fontSize: Responsive.sp(12),
            color: AppColors.homeTextMuted,
          ),
        ),
      ),
    );
  }
}
