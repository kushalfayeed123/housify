import 'package:housify/core/domain/dtos/dashboard.dto.dart';
import 'package:geolocator/geolocator.dart';

class DashboardStateModel {
  DashboardDTO? dashboardData;
  Position? currentLocation;
  String? currentAddress;

  DashboardStateModel({
    this.dashboardData,
    this.currentLocation,
    this.currentAddress,
  });
}
