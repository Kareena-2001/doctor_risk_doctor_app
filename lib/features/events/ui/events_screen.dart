import 'dart:async';

import 'package:Doctors_App/core/widgets/custom_seachbar.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/common/ui/widgets/loading.dart';
import 'package:Doctors_App/features/events/ui/view_model/events_view_model.dart';
import 'package:Doctors_App/features/events/ui/widget/collaborate_tab.dart';
import 'package:Doctors_App/features/events/ui/widget/event_list_tab.dart';
import 'package:Doctors_App/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/responsive.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../theme/app_colors.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _typeFilter = 'All';
  String _searchQuery = '';
  Timer? _debounce;

  // String get _apiType => _typeFilter == 'All' ? '' : _typeFilter;
  String get _apiType => _typeFilter;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));

    Future.microtask(_fetchAll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchAll() {
    ref
        .read(eventsViewModelProvider.notifier)
        .fetchUpcomingEvents(type: _apiType, query: _searchQuery);
    ref
        .read(eventsViewModelProvider.notifier)
        .fetchPastEvents(type: _apiType, query: _searchQuery);
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() => _searchQuery = value.trim());
      _fetchAll();
    });
  }

  void _onTypeChanged(String option) {
    setState(() => _typeFilter = option);
    _fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(eventsViewModelProvider);
    final viewModel = ref.read(eventsViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      appBar: CustomAppBar(title: "Events Hub"),
      floatingActionButton: _tabController.index == 2
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.newPri, AppColors.primary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    context.push(Routes.addCollaboration);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16),
                      vertical: Responsive.h(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        width(Responsive.w(8)),
                        Text(
                          "Add Collaboration",
                          style: customTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: Column(
        children: [
          Container(
            color: context.secondaryBackgroundColor,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.newPri,
              unselectedLabelColor: AppColors.homeTextMuted,
              indicatorColor: AppColors.newPri,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: customTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.sp(12),
              ),
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Past Events"),
                Tab(text: "Collaborate"),
              ],
            ),
          ),
          height(Responsive.h(14)),
          if (_tabController.index != 2) ...[
            _buildSearchField(),
            height(Responsive.h(10)),
            _buildFilterChips(),
            height(Responsive.h(14)),
          ],

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                eventsState.upcomingEvents.when(
                  data: (response) => RefreshIndicator(
                    onRefresh: () => viewModel.refreshUpcomingEvents(
                      type: _apiType,
                      query: _searchQuery,
                    ),
                    child: EventListTab(
                      events: response.data,
                      activeTab: 'upcoming',
                    ),
                  ),
                  loading: () => const Center(child: Loading()),
                  error: (error, _) => _buildErrorState(
                    error.toString(),
                    () => viewModel.refreshUpcomingEvents(
                      type: _apiType,
                      query: _searchQuery,
                    ),
                  ),
                ),
                eventsState.pastEvents.when(
                  data: (response) => RefreshIndicator(
                    onRefresh: () => viewModel.refreshPastEvents(
                      type: _apiType,
                      query: _searchQuery,
                    ),
                    child: EventListTab(
                      events: response.data,
                      activeTab: 'past',
                    ),
                  ),
                  loading: () => const Center(child: Loading()),
                  error: (error, _) => _buildErrorState(
                    error.toString(),
                    () => viewModel.refreshPastEvents(
                      type: _apiType,
                      query: _searchQuery,
                    ),
                  ),
                ),
                CollaborateTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: CustomSearchBar(
        controller: _searchController,
        hint: 'Search Events',
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildErrorState(String message, Future<void> Function() onRetry) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: customTextStyle(
              fontSize: Responsive.sp(12),
              color: AppColors.homeTextMuted,
            ),
          ),
          height(Responsive.h(12)),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final options = ['All', 'Online', 'Offline'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Row(
        children: options.map((option) {
          final selected = _typeFilter == option;
          return Padding(
            padding: EdgeInsets.only(right: Responsive.w(10)),
            child: GestureDetector(
              onTap: () => _onTypeChanged(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(16),
                  vertical: Responsive.h(6),
                ),
                decoration: BoxDecoration(
                  gradient: selected
                      ? LinearGradient(
                          colors: [AppColors.newPri, AppColors.primary],
                        )
                      : null,
                  color: selected ? null : context.secondaryWidgetColor,
                  borderRadius: BorderRadius.circular(Responsive.w(30)),
                  border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  option,
                  style: customTextStyle(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
