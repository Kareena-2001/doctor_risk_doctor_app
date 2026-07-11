import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/product_state.dart';

part 'product_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductViewModel extends _$ProductViewModel {
  @override
  FutureOr<ProductState> build() {
    return const ProductState();
  }

  void changeTab(bool isPlanList) {
    state = AsyncData(
      state.requireValue.copyWith(isPlanListSelected: isPlanList),
    );
  }
}