import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/common_empty_state.dart';
import '../../../core/widgets/common_error_state.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/loading.dart';
import '../model/query_list_model.dart';
import 'view_model/help_view_model.dart';

class MyQueriesScreen extends ConsumerStatefulWidget {
  const MyQueriesScreen({super.key});

  @override
  ConsumerState<MyQueriesScreen> createState() => _MyQueriesScreenState();
}

class _MyQueriesScreenState extends ConsumerState<MyQueriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(helpViewModelProvider.notifier).fetchQueries();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<QueryListItem> _filterByStatus(
    List<QueryListItem> queries,
    String status,
  ) {
    return queries
        .where((q) => q.ticketStatus.toLowerCase() == status.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final helpState = ref.watch(helpViewModelProvider);

    final allQueries = helpState.queries;
    final pendingQueries = _filterByStatus(allQueries, 'pending');
    final inProgressQueries = _filterByStatus(allQueries, 'in progress');
    final resolvedQueries = _filterByStatus(allQueries, 'resolved');

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryTextColor),
        backgroundColor: context.secondaryWidgetColor,
        title: Text(
          'My Support Queries',
          style: customTextStyle(color: context.primaryTextColor, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: context.primaryTextColor,
          labelStyle: customTextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: 'All (${allQueries.length})'),
            Tab(text: 'Pending (${pendingQueries.length})'),
            Tab(text: 'In Progress (${inProgressQueries.length})'),
            Tab(text: 'Resolved (${resolvedQueries.length})'),
          ],
        ),
      ),
      body: SafeArea(
        child: helpState.isFetchingQueries
            ? Loading()
            : helpState.error != null
            ? _isNotFoundError(helpState.error)
                  ? CommonEmptyState(
                      icon: Icons.inbox_rounded,
                      title: 'No queries found',
                      message: 'Submit a query to get started',
                    )
                  : CommonErrorState(
                      icon: Icons.error_outline,
                      title: 'Failed to load Queries',
                      message: helpState.error ?? '',
                      onRetry: () {
                        ref.read(helpViewModelProvider.notifier).fetchQueries();
                      },
                      buttonText: 'Retry',
                    )
            : TabBarView(
                controller: _tabController,
                children: [
                  _buildQueriesList(allQueries, isDark),
                  _buildQueriesList(pendingQueries, isDark),
                  _buildQueriesList(inProgressQueries, isDark),
                  _buildQueriesList(resolvedQueries, isDark),
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     context.push(Routes.addSupport);
      //   },
      //   backgroundColor: AppColors.newPri,
      //   icon: Icon(Icons.add, color: Colors.white),
      //   label: Text(
      //     'New Query',
      //     style: customTextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }

  bool _isNotFoundError(String? error) {
    if (error == null) return false;

    return error.contains('404') ||
        error.toLowerCase().contains('not exist') ||
        error.toLowerCase().contains('not found') ||
        error.toLowerCase().contains('query not exist');
  }

  Widget _buildQueriesList(List<QueryListItem> queries, bool isDark) {
    if (queries.isEmpty) {
      return CommonEmptyState(
        icon: Icons.inbox_rounded,
        title: 'No queries found',
        message: 'Submit a query to get started',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(helpViewModelProvider.notifier).fetchQueries();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: queries.length,
        itemBuilder: (context, index) {
          final query = queries[index];
          return _buildQueryCard(query, isDark);
        },
      ),
    );
  }

  Widget _buildQueryCard(QueryListItem query, bool isDark) {
    final statusColor = _getStatusColor(query.ticketStatus);
    final statusIcon = _getStatusIcon(query.ticketStatus);

    return InkWell(
      onTap: () {
        context.push(Routes.queryDetails, extra: query.id);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : Colors.grey.shade300).withValues(
                alpha: 0.3,
              ),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: statusColor),
                      width(6),
                      Text(
                        query.ticketStatus,
                        style: customTextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  query.ticketNumber,
                  style: customTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            height(12),
            Text(
              query.question,
              style: customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            height(6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                query.category,
                style: customTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            height(8),
            Text(
              query.description,
              style: customTextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            height(12),
            Divider(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
            height(8),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
                width(6),
                Text(
                  query.querySubmit,
                  style: customTextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
                Spacer(),
                if (query.ticketStatus != 'Pending')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.message_rounded,
                          size: 12,
                          color: Colors.green,
                        ),
                        width(4),
                        Text(
                          'Replied',
                          style: customTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                width(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
      case 'inprogress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule_rounded;
      case 'in progress':
      case 'inprogress':
        return Icons.hourglass_bottom_rounded;
      case 'resolved':
        return Icons.check_circle_rounded;
      case 'closed':
        return Icons.lock_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }
}
