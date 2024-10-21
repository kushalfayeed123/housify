import 'package:get_it/get_it.dart';
import 'package:housify/core/domain/abstractions/dashboard.abstraction.dart';
import 'package:housify/core/infrastructure/services/dashboard.service.dart';

GetIt getIt = GetIt.instance;

void setupProvider() {
  getIt.registerLazySingleton<IDashboardService>(() => DashboardService());
}
