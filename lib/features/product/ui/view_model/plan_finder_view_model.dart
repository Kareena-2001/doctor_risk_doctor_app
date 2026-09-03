import 'package:Doctors_App/features/product/model/plan_finder_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/plan_finder_state.dart';

part 'plan_finder_view_model.g.dart';

@riverpod
class PlanFinderViewModel extends _$PlanFinderViewModel {
  @override
  PlanFinderState build(PlanFinderArgs args) {
    return PlanFinderState(
      orgName: args.orgName,
      staffCode: args.staffCode,
      category: args.category,
    );
  }

  void selectMembership(MembershipType? m) => state = state.copyWith(
    membership: m,
    clearMembership: m == null,
    clearPlan: true,
    clearQuote: true,
  );

  void selectPlan(PlanTier? p) =>
      state = state.copyWith(plan: p, clearPlan: p == null, clearQuote: true);

  void selectDuration(PolicyDuration? d) => state = state.copyWith(
    duration: d,
    clearDuration: d == null,
    clearQuote: true,
  );

  void selectSumAssured(SumAssured? s) => state = state.copyWith(
    sumAssured: s,
    clearSumAssured: s == null,
    clearQuote: true,
  );

  void search() {
    if (!state.canSearch) return;
    final premium = calculatePremium(
      membership: state.membership!,
      plan: state.plan!,
      duration: state.duration!,
      sumAssured: state.sumAssured!,
    );
    state = state.copyWith(
      quote: PlanQuote(
        membership: state.membership!,
        plan: state.plan!,
        duration: state.duration!,
        sumAssured: state.sumAssured!,
        premium: premium,
      ),
    );
  }

  void clear() => state = state.copyWith(
    clearMembership: true,
    clearPlan: true,
    clearDuration: true,
    clearSumAssured: true,
    clearQuote: true,
  );

  void toggleComparison() =>
      state = state.copyWith(showComparison: !state.showComparison);

  void applyFromComparison({
    required MembershipType membership,
    required PlanTier plan,
    required PolicyDuration duration,
    required SumAssured sumAssured,
  }) {
    state = state.copyWith(
      membership: membership,
      plan: plan,
      duration: duration,
      sumAssured: sumAssured,
      showComparison: false,
    );
    search();
  }
}