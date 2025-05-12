import 'package:absensi_app/app/dependeny_injection/injector.dart';
import 'package:absensi_app/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  await Injector.init();
  runApp(const MyApp());
}
