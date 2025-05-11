import 'dart:async';

import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/features/locations/repositories/locations_repository.dart';
import 'package:absensi_app/modules/home/controller/home_page_controller.dart';
import 'package:absensi_app/modules/maps/widgets/add_new_place_modal.dart';
import 'package:absensi_app/modules/maps/widgets/location_information_modal.dart';
import 'package:absensi_app/modules/maps/widgets/setting_place_modal.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remixicon/remixicon.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final prefs = Get.find<PrefsService>();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final locationController = Get.put(LocationController());
  final locationRepository = LocationRepository();

  final RxSet<Marker> _markers = <Marker>{}.obs;
  final RxSet<Circle> _circles = <Circle>{}.obs;
  final List<Location> locations = <Location>[].obs;

  final isAddingNewPin = false.obs;
  final isLoading = false.obs;

  Future<void> getLocation() async {
    locations.clear();
    _circles.clear();
    _markers.clear();
    locationRepository.getLocations().then((fetchedLocations) {
      locations.addAll(fetchedLocations);
      for (final entry in fetchedLocations.asMap().entries) {
        final index = entry.key;
        final location = entry.value;

        setState(() {
          _markers.add(Marker(
            markerId: MarkerId('${location.name}-${location.timestamp}'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: location.name),
            icon: location.timestamp.toString() == prefs.currentLocationId
                ? locationController.customIconAttandance
                : locationController.customIconUnselected,
            onTap: () {
              showLocationInformationBottomSheet(
                context: context,
                location: location,
                onDelete: () {
                  Future.delayed(const Duration(milliseconds: 100));

                  if (location.timestamp.toString() ==
                      prefs.currentLocationId) {
                    prefs.setCurrentLocationId(null);
                  }
                  locationRepository.deleteLocation(index);
                  getLocation();
                  Navigator.pop(context);
                },
                onSetMain: () {
                  prefs.setCurrentLocationId(location.timestamp.toString());
                  getLocation();
                },
              );
            },
          ));

          _circles.add(Circle(
            circleId: CircleId('${location.name}-${location.timestamp}'),
            center: LatLng(location.latitude, location.longitude),
            radius: 50,
            fillColor: Colors.blue.withValues(alpha: 0.2),
            strokeColor: Colors.blueAccent,
            strokeWidth: 1,
          ));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: SafeArea(
        child: Obx(() {
          final position = locationController.currentPosition.value;

          if (position == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16,
          );

          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            markers: _markers,
            circles: _circles,
            onTap: (latLng) {
              if (isAddingNewPin.value) {
                showAddLocationBottomSheet(latLng,
                    (name, latLng, notes, checkInLimit, checkOutLimit) {
                  _addMarker(latLng, name, checkInLimit, checkOutLimit).then(
                    (value) {
                      Get.dialog(
                          const Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 8,
                          )),
                          barrierDismissible: false);

                      // Tutup dialog setelah 3 detik
                      Future.delayed(const Duration(seconds: 1), () {
                        if (Get.isDialogOpen ?? false) {
                          Get.back();
                        }
                      });
                    },
                  );
                });
                Get.find<HomePageController>().refresh();
              } else {}
            },
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FloatingActionButton(
            heroTag: 'settings',
            onPressed: () {
              showLocationList(
                context: context,
                locations: locations,
                locationRepository: locationRepository,
                prefs: prefs,
                onSetMain: () {
                  getLocation();
                },
                onDelete: () {
                  getLocation().then(
                    (value) {
                      Get.dialog(
                          Center(
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 8,
                            )),
                          ),
                          barrierDismissible: false);

                      // Tutup dialog setelah 3 detik
                      Future.delayed(const Duration(seconds: 1), () {
                        if (Get.isDialogOpen ?? false) {
                          Get.back();
                        }
                      });
                    },
                  );
                },
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(
              Remix.settings_2_fill,
              color: Colors.white,
            ),
          ),
          Gap(14),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              isAddingNewPin.value = !isAddingNewPin.value;
            },
            backgroundColor: Colors.blue,
            child: Obx(
              () => Icon(
                isAddingNewPin.value ? Icons.cancel : Icons.add_location_alt,
                color: Colors.white,
              ),
            ),
          ),
          Gap(14),
        ],
      ),
    );
  }

  Future<void> _addMarker(LatLng latLng, String name, DateTime checkInLimit,
      DateTime checkOutLimit) async {
    isAddingNewPin.value = false;

    var address = await locationController.getAddressFromLatLng(
        latLng.latitude, latLng.longitude);

    // Save location to database
    locationRepository.saveLocation(Location(
      name: name,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      checkInLimit: checkInLimit,
      checkOutLimit: checkOutLimit,
      address: address.toString(),
    ));

    getLocation();
  }
}
