import 'package:absensi_app/modules/attendance/pages/check_in_page.dart';
import 'package:absensi_app/modules/attendance/pages/check_out_page.dart';
import 'package:get/get.dart';

class CheckPageController extends GetxController {
  Future<void> refreshCheckIn() async {
    final checkInPageStaet = Get.find<CheckInPageState>();
    await checkInPageStaet.refresh();
  }

  Future<void> refreshCheckOut() async {
    final checkOutPageStaet = Get.find<CheckOutPageState>();
    await checkOutPageStaet.refresh();
  }
}
