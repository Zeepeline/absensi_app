import 'package:absensi_app/modules/home/pages/home_page.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  @override
  Future<void> refresh() async {
    final homePageStaet = Get.find<MyHomePageState>();
    await homePageStaet.refresh();
  }
}
