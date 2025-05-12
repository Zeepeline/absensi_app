import 'dart:developer';

import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LocationRepository {
  // Nama box tempat lokasi disimpan
  static const String _boxName = 'locations_box';
  final prefs = Get.find<PrefsService>();

  // Fungsi untuk menyimpan lokasi ke Hive
  Future<void> saveLocation(Location location) async {
    // Membuka box
    var box = await Hive.openBox<Location>(_boxName);

    // Menyimpan lokasi
    await box.put(location.timestamp.toString(), location);

    // Menutup box
    await box.close();
  }

  // Fungsi untuk mendapatkan semua lokasi yang tersimpan
  Future<List<Location>> getLocations() async {
    var box = await Hive.openBox<Location>(_boxName);
    List<Location> locations = box.values.toList();

    if (prefs.currentLocationId == null && locations.isNotEmpty) {
      prefs.setCurrentLocationId(locations[0].timestamp.toString());
    }
    await box.close();
    return locations;
  }

  // Fungsi untuk menghapus lokasi berdasarkan indeks
  Future<void> deleteLocation(int index) async {
    var box = await Hive.openBox<Location>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  // Fungsi untuk edit lokasi
  Future<void> editLocation(Location location, int index) async {
    var box = await Hive.openBox<Location>(_boxName);

    if (index != -1) {
      await box.putAt(index, location);
    } else {
      log('Data tidak ditemukan, tidak bisa edit.');
    }

    await box.close();
  }

  /// Fungsi untuk mendapatkan key (id) dari Location
  Future<int?> getKeyForLocation(Location targetLocation) async {
    var box = await Hive.openBox<Location>(_boxName);

    final entries = box.toMap().entries;
    MapEntry<dynamic, Location>? match;

    for (final entry in entries) {
      final loc = entry.value;
      if (loc.name == targetLocation.name &&
          loc.latitude == targetLocation.latitude &&
          loc.longitude == targetLocation.longitude &&
          loc.timestamp == targetLocation.timestamp &&
          loc.address == targetLocation.address) {
        match = entry;
        break;
      }
    }

    await box.close();
    return match?.key;
  }
}
