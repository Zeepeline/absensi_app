import 'package:absensi_app/shared/cores/constants/prefs_key.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService extends GetxService {
  late SharedPreferences _prefs;

  Future<PrefsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // SETTER
  Future<void> setCurrentLocationId(String? id) async {
    if (id == null) {
      // Menyimpan nilai null
      await _prefs.remove(PrefsKey.currentLocationId);
    } else {
      // Menyimpan id
      await _prefs.setString(PrefsKey.currentLocationId, id);
    }
  }

  // GETTER
  String? get currentLocationId => _prefs.getString(PrefsKey.currentLocationId);
}
