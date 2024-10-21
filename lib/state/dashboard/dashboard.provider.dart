import 'package:housify/core/domain/abstractions/dashboard.abstraction.dart';
import 'package:housify/service_provider.dart';
import 'package:housify/shared/models/dashboard.state.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard.provider.g.dart';

@riverpod
class Dashboard extends _$Dashboard {
  final IDashboardService _dashboardService = getIt<IDashboardService>();
  @override
  AsyncValue<DashboardStateModel> build() {
    final defaultState = DashboardStateModel();
    return AsyncValue.data(defaultState);
  }

  void setState(DashboardStateModel stateSlice) {
    state = const AsyncValue.loading();
    state = AsyncValue.data(stateSlice);
  }

  Future<void> fetchDashboardData() async {
    try {
      final data = await _dashboardService.getDashboardData();
      final newState = DashboardStateModel(dashboardData: data);
      setState(newState);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUserLocation() async {
    try {
      final currentLocation = await _dashboardService.getCurrentPosition();
      final address = await _dashboardService.getAddress(currentLocation);
      final currentState = state.asData?.value;
      final newState = DashboardStateModel(
        currentLocation: currentLocation,
        dashboardData: currentState?.dashboardData,
        currentAddress: address,
      );
      setState(newState);
    } catch (e) {
      rethrow;
    }
  }
}
