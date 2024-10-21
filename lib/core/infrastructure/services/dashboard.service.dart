import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:housify/core/domain/abstractions/dashboard.abstraction.dart';
import 'package:housify/core/domain/dtos/dashboard.dto.dart';

class DashboardService implements IDashboardService {
  @override
  Future<DashboardDTO> getDashboardData() async {
    try {
      // Note ===> In a real life scenario this would be a call to an external data source to fetch data using http or dio;

      final String res =
          await rootBundle.loadString('assets/json/dashboard.json');

      return DashboardDTO.fromJson(jsonDecode(res));
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  @override
  Future<String> getAddress(Position? coordinates) async {
    try {
      final placeMarks = await placemarkFromCoordinates(
          coordinates?.latitude ?? 0, coordinates?.longitude ?? 0);
      return placeMarks.first.country ?? '';
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
// Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
// Request permission to get the user's location
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return null;
        }
      }
      final currentPosition = await Geolocator.getCurrentPosition();
      return currentPosition;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
