// lib/shared/services/attendance_service.dart

import 'package:absensi_app/features/attendances/models/attendance_model.dart';
import 'package:absensi_app/features/attendances/repositories/attendance_repository.dart';
import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/modules/home/pages/home_page.dart';
import 'package:absensi_app/shared/components/dialog/failure_attande_dialog.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendanceService {
  final LocationController locationController;
  final AttendanceRepository attendanceRepository;
  final bool isCheckIn;

  AttendanceService({
    required this.locationController,
    required this.attendanceRepository,
    required this.isCheckIn,
  });

  void addMarkerWithRadius(
      Location location, Set<Marker> markers, Set<Circle> circles) {
    final markerId = MarkerId('${location.name}-${location.timestamp}');
    final position = LatLng(location.latitude, location.longitude);

    markers.add(Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: location.name),
      icon: locationController.customIconAttandance,
    ));

    circles.add(Circle(
      circleId: CircleId(markerId.value),
      center: position,
      radius: 50,
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blueAccent,
      strokeWidth: 1,
    ));
  }

  Future<void> performCheck(
    LatLng currentLocation,
    LatLng pinLocation,
    DateTime timeLimit,
    String userId,
    String address,
    String name,
  ) async {
    final isWithinDistance = locationController.getDistance(
          currentLocation.latitude,
          currentLocation.longitude,
          pinLocation.latitude,
          pinLocation.longitude,
        ) <=
        50;

    final isWithinTime = isCheckIn
        ? timeLimit.isAfter(DateTime.now())
        : timeLimit.isBefore(DateTime.now());

    if (isCheckIn) {
      if (isWithinDistance) {
        await attendanceRepository
            .addCheckInAttendance(Attendance(
          timestamp: DateTime.now(),
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          userId: userId,
          isAccepted: isWithinTime,
          address: address,
          name: name,
        ))
            .then((_) {
          Get.find<MyHomePageState>().refresh();
          Get.dialog(PresenceDialog(isSuccess: true));
        });
      } else {
        Get.dialog(PresenceDialog(isSuccess: false));
      }
    } else {
      if (isWithinDistance && isWithinTime) {
        await attendanceRepository
            .addCheckOutAttendance(
          Attendance(
            timestamp: DateTime.now(),
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude,
            userId: userId,
            isAccepted: isWithinTime,
            address: address,
            name: name,
          ),
        )
            .then((_) {
          Get.find<MyHomePageState>().refresh();
          Get.dialog(PresenceDialog(isSuccess: true));
        });
      } else {
        Get.dialog(PresenceDialog(isSuccess: false));
      }
    }
  }
}
