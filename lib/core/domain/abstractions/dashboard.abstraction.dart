import 'package:geolocator/geolocator.dart';
import 'package:housify/core/domain/dtos/dashboard.dto.dart';

abstract class IDashboardService {
  Future<DashboardDTO> getDashboardData();
  Future<Position?> getCurrentPosition();
  Future<String> getAddress(Position? coordinates);
}
