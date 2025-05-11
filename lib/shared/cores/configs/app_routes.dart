import 'package:absensi_app/modules/attendance/pages/check_in_page.dart';
import 'package:absensi_app/modules/attendance/pages/check_out_page.dart';
import 'package:absensi_app/modules/maps/pages/maps_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final routes = [
    GetPage<void>(
        name: '/check-in',
        page: CheckInPage.new,
        transition: Transition.cupertino),
    GetPage<void>(
        name: '/check-out',
        page: CheckOutPage.new,
        transition: Transition.cupertino),
    GetPage<void>(
        name: '/map', page: MapPage.new, transition: Transition.cupertino),
  ];
}
