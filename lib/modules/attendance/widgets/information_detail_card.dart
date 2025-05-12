import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:absensi_app/shared/cores/constants/colorpedia.dart';
import 'package:absensi_app/shared/cores/services/attandance_service.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class InformationDetailCard extends StatelessWidget {
  const InformationDetailCard(
      {super.key,
      required this.locationController,
      required this.locations,
      required this.attendanceService,
      required this.prefs,
      required this.position,
      required this.isCheckIn,
      required this.address});

  final LocationController locationController;
  final List<Location> locations;
  final AttendanceService attendanceService;
  final PrefsService prefs;
  final Position position;
  final RxString address;
  final bool isCheckIn;

  @override
  Widget build(BuildContext context) {
    final distance = locationController.getDistance(
      position.latitude,
      position.longitude,
      locations[0].latitude,
      locations[0].longitude,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check-in',
            style: AppTextStyles.bodyMediumBold,
          ),
          Gap(8),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  isCheckIn ? 'Batas Check-In' : 'Mulai Check-Out',
                  style: AppTextStyles.bodyMediumBold,
                ),
              ),
              Text(
                isCheckIn
                    ? ': ${DateFormat.Hm().format(locations[0].checkInLimit)}'
                    : ': ${DateFormat.Hm().format(locations[0].checkOutLimit)}',
                style: AppTextStyles.bodyMediumMedium,
              )
            ],
          ),
          Gap(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Alamat User',
                  style: AppTextStyles.bodyMediumBold,
                ),
              ),
              FutureBuilder<String>(
                future: locationController.getAddressFromLatLng(
                    position.latitude, position.longitude),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Memuat alamat...");
                  } else if (snapshot.hasError) {
                    return const Text("Gagal memuat alamat");
                  } else {
                    address.value = snapshot.data ?? "Alamat tidak tersedia";
                    return Expanded(
                      child: Text(
                        ': ${snapshot.data}',
                        style: AppTextStyles.bodyMediumRegular,
                      ),
                    );
                  }
                },
              )
            ],
          ),
          Gap(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Alamat Presensi',
                  style: AppTextStyles.bodyMediumBold,
                ),
              ),
              FutureBuilder<String>(
                future: locations.isNotEmpty
                    ? locationController.getAddressFromLatLng(
                        locations[0].latitude,
                        locations[0].longitude,
                      )
                    : Future.value('Memuat lokasi...'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Memuat alamat...");
                  } else if (snapshot.hasError) {
                    return const Text("Gagal memuat alamat");
                  } else {
                    return Expanded(
                      child: Text(
                        ': ${snapshot.data}',
                        style: AppTextStyles.bodyMediumRegular,
                      ),
                    );
                  }
                },
              )
            ],
          ),
          Gap(8),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  'Jarak:',
                  style: AppTextStyles.bodyMediumBold,
                ),
              ),
              Text(': ${distance.toStringAsFixed(2)} m'),
            ],
          ),
          Gap(8),
          ElevatedButton(
              onPressed: () async {
                attendanceService.performCheck(
                    LatLng(position.latitude, position.longitude),
                    LatLng(
                      locations[0].latitude,
                      locations[0].longitude,
                    ),
                    isCheckIn
                        ? locations[0].checkInLimit
                        : locations[0].checkOutLimit,
                    'userId-1',
                    address.value,
                    locations[0].name);
              },
              style: ButtonStyle(
                backgroundColor: isCheckIn
                    ? WidgetStateProperty.all<Color>(Colors.blueAccent)
                    : WidgetStateProperty.all<Color>(AppColors.brandBaseDark),
              ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                  )))
        ],
      ),
    );
  }
}
