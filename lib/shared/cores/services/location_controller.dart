import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  // Observable position
  final Rxn<Position> currentPosition = Rxn<Position>();

  // Observable error
  final RxnString error = RxnString();
  late BitmapDescriptor customIconAttandance;
  late BitmapDescriptor customIconUnselected;

  @override
  void onInit() {
    super.onInit();
    loadCustomMarker();
    determinePosition();
    startListeningPosition();
  }

  Future<void> loadCustomMarker() async {
    customIconAttandance = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/home-address.png',
    );

    customIconUnselected = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/unselected-home.png',
    );
  }

  void startListeningPosition() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position pos) {
      currentPosition.value = pos;
    });
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
      } else {
        return "Alamat tidak ditemukan";
      }
    } catch (e) {
      print("Error getting address: $e");
      return "Gagal mendapatkan alamat";
    }
  }

  double getDistance(double lat1, double lon1, double lat2, double lon2,
      {double thresholdInMeters = 50}) {
    const earthRadius = 6371000; // radius bumi dalam meter

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadius * c;
    return distance;
  }

  double _degreesToRadians(double degree) {
    return degree * pi / 180;
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error.value = 'Location services are disabled.';
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        error.value = 'Location permissions are denied';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      error.value =
          'Location permissions are permanently denied, cannot request.';
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      currentPosition.value = position;
    } catch (e) {
      error.value = 'Failed to get location: $e';
    }
  }
}
