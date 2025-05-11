import 'package:absensi_app/features/attendances/models/attendance_model.dart';
import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:absensi_app/shared/cores/utils/prefs_utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class Injector {
  static Future<void> init() async {
    // Initialize SharedPreferences
    await Get.putAsync(() => PrefsService().init());

    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    // Inisialisasi Hive
    await Hive.initFlutter();
    Hive.registerAdapter(LocationAdapter());
    Hive.registerAdapter(AttendanceAdapter());

    // Inisialisasi controller
    Get.put(LocationController());
  }
}
