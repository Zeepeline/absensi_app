import 'dart:developer';

import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/features/locations/repositories/locations_repository.dart';
import 'package:absensi_app/modules/maps/widgets/add_new_place_modal.dart';
import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

void showLocationInformationBottomSheet(
    {required BuildContext context,
    required Location location,
    required int index,
    required LocationRepository locationRepository,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required VoidCallback onSetMain}) {
  Get.bottomSheet(
      Wrap(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Informasi Lokasi',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                            icon: const Icon(Remix.edit_line),
                            onPressed: () {
                              showAddLocationBottomSheet(
                                  LatLng(location.latitude, location.longitude),
                                  (name, latLng, checkIn, checkOut) {
                                Get.back();

                                log('time : ${location.timestamp}');

                                locationRepository
                                    .editLocation(
                                        Location(
                                          name: name,
                                          latitude: latLng.latitude,
                                          longitude: latLng.longitude,
                                          timestamp: location.timestamp,
                                          address: location.address,
                                          checkInLimit: checkIn,
                                          checkOutLimit: checkOut,
                                        ),
                                        index)
                                    .then(
                                  (value) {
                                    onEdit();
                                  },
                                );
                                // update logic here
                              }, initialData: location);
                            }),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Nama Lokasi',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Text(
                          ': ${location.name}',
                          style: AppTextStyles.bodyMediumMedium,
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Alamat Lokasi',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ': ${location.address}',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Latitude',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Text(
                          ': ${location.latitude}',
                          style: AppTextStyles.bodyMediumMedium,
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Longitude',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Text(
                          ': ${location.longitude}',
                          style: AppTextStyles.bodyMediumMedium,
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Jam Masuk',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Text(
                          ': ${DateFormat.Hm().format(location.checkInLimit)}',
                          style: AppTextStyles.bodyMediumMedium,
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Jam Pulang',
                            style: AppTextStyles.bodyMediumMedium,
                          ),
                        ),
                        Text(
                          ': ${DateFormat.Hm().format(location.checkOutLimit)}',
                          style: AppTextStyles.bodyMediumMedium,
                        ),
                      ],
                    ),
                    Gap(32),
                    ElevatedButton(
                        onPressed: () {
                          onDelete();
                          // Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: SizedBox(
                            width: double.infinity,
                            child: const Text('Hapus',
                                textAlign: TextAlign.center))),
                    const Gap(8),
                    ElevatedButton(
                        onPressed: () {
                          onSetMain();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: SizedBox(
                            width: double.infinity,
                            child: const Text('Jadikan Titik Utama',
                                textAlign: TextAlign.center))),
                  ])),
        ],
      ),
      isScrollControlled: true);
}
