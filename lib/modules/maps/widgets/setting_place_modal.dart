import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/features/locations/repositories/locations_repository.dart';
import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:absensi_app/shared/cores/constants/colorpedia.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLocationList({
  required BuildContext context,
  required List<Location> locations,
  required LocationRepository locationRepository,
  required PrefsService prefs,
  required VoidCallback onDelete,
  required VoidCallback onSetMain,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4, // Awal terbuka 40% dari tinggi layar
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Obx(() {
              if (locations.isEmpty) {
                return Center(
                    child: Text(
                  'Belum ada lokasi yang ditambahkan',
                  style: AppTextStyles.bodyMediumRegular,
                ));
              }
              return Column(
                children: [
                  Text(
                    'Daftar Lokasi',
                    style: AppTextStyles.bodyMediumBold,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final loc = locations[index];
                        return InkWell(
                          onTap: () {
                            if (prefs.currentLocationId ==
                                loc.timestamp.toString()) {
                              prefs.setCurrentLocationId(null);
                            } else {
                              prefs.setCurrentLocationId(
                                  loc.timestamp.toString());
                              onSetMain();
                            }
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: prefs.currentLocationId ==
                                      loc.timestamp.toString()
                                  ? AppColors.brand10Light
                                  : Colors.white,
                              border: Border.all(
                                  color: prefs.currentLocationId ==
                                          loc.timestamp.toString()
                                      ? AppColors.brandBaseDark
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bagian Kiri: Title dan Subtitle
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(loc.name,
                                          style: AppTextStyles.bodyMediumBold),
                                      const SizedBox(height: 4),
                                      Text(loc.address),
                                      const SizedBox(height: 4),
                                      Text('${loc.latitude}, ${loc.longitude}',
                                          style:
                                              AppTextStyles.bodyMediumRegular),
                                    ],
                                  ),
                                ),

                                // Bagian Kanan: Tombol delete
                                IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (locations[index].timestamp.toString() ==
                                        prefs.currentLocationId) {
                                      prefs.setCurrentLocationId(null);
                                    }
                                    locationRepository.deleteLocation(index);
                                    onDelete();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          );
        },
      );
    },
  );
}
