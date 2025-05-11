import 'dart:async';

import 'package:absensi_app/features/attendances/repositories/attendance_repository.dart';
import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/features/locations/repositories/locations_repository.dart';
import 'package:absensi_app/modules/attendance/contents/empty_setup_content.dart';
import 'package:absensi_app/modules/attendance/controller/check_page_controller.dart';
import 'package:absensi_app/modules/attendance/widgets/information_detail_card.dart';
import 'package:absensi_app/shared/cores/services/attandance_service.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInPageState();
}

class CheckInPageState extends State<CheckInPage> {
  final prefs = Get.find<PrefsService>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final LocationController locationController = Get.put(LocationController());
  final locationRepository = LocationRepository();
  final attendanceRepository = AttendanceRepository();

  final RxSet<Marker> _markers = <Marker>{}.obs;
  final List<Location> locations = <Location>[].obs;
  final RxSet<Circle> _circles = <Circle>{}.obs;
  var isLoading = true.obs;

  // address
  final address = ''.obs;

  late AttendanceService attendanceService = AttendanceService(
    locationController: locationController,
    attendanceRepository: attendanceRepository,
    isCheckIn: true,
  );
  Future<void> getLocation() async {
    isLoading.value = true;

    await locationRepository.getLocations().then(
      (value) {
        if (prefs.currentLocationId != null) {
          locations.add(value.firstWhere((element) =>
              element.timestamp.toString() == prefs.currentLocationId));
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> refresh() async {
    getLocation();
  }

  @override
  void initState() {
    super.initState();
    Get.put(this);
    Get.put(CheckPageController());
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Check-in'),
      ),
      body: Obx(() {
        final position = locationController.currentPosition.value;

        if (isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (position == null) {
          return const Center(child: CircularProgressIndicator());
        }
        for (final location in locations) {
          attendanceService.addMarkerWithRadius(location, _markers, _circles);
        }

        final cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16,
        );
        return prefs.currentLocationId == null
            ? EmptySetupContent()
            : Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: cameraPosition,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: _markers,
                    circles: _circles,
                  ),
                  Positioned(
                      bottom: 30,
                      left: 20,
                      right: 20,
                      child: InformationDetailCard(
                        locationController: locationController,
                        locations: locations,
                        attendanceService: attendanceService,
                        position: position,
                        address: address,
                        prefs: prefs,
                        isCheckIn: true,
                      ))
                ],
              );
      }),
    );
  }
}
