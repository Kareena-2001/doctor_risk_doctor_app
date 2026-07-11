import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/my_plan_model.dart';

part 'my_plans_view_model.g.dart';

@Riverpod(keepAlive: true)
class MyPlansViewModel extends _$MyPlansViewModel {
  @override
  FutureOr<List<MyPlan>> build() async {
    // TODO: replace with real API call, e.g. ref.read(planRepositoryProvider).fetchMyPlans()
    return _samplePlans;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => _samplePlans);
  }

  Future<void> renew(String planId) async {
    // TODO: call renew API, then refresh
    await refresh();
  }

  static final List<MyPlan> _samplePlans = [
    MyPlan(
      srNo: 1,
      id: 'PLN001',
      planName: 'Product A',
      duration: '2 Years',
      sumAssured: 5000000,
      premium: 44000,
      payable: 38800,
      status: PlanStatus.active,
      fromDate: DateTime(2025, 9, 1),
      toDate: DateTime(2026, 8, 31),
      policyNumber: '03303387333412',
    ),
    MyPlan(
      srNo: 2,
      id: 'PLN002',
      planName: 'Product C',
      duration: '1 Year',
      sumAssured: 2500000,
      premium: 21000,
      payable: 21000,
      status: PlanStatus.expired,
      fromDate: DateTime(2024, 8, 1),
      toDate: DateTime(2025, 7, 31),
      policyNumber: '03303387333999',
    ),
  ];
}