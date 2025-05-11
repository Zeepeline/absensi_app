import 'package:absensi_app/features/attendances/models/attendance_model.dart';
import 'package:hive/hive.dart';

class AttendanceRepository {
  // Nama box tempat data presensi disimpan
  static const String _checkInBoxName = 'checkIn_attendance_box';
  static const String _checkOutBoxName = 'checkOut_attendance_box';

  // Fungsi untuk menyimpan data check-in
  Future<void> addCheckInAttendance(Attendance attendance) async {
    if (!Hive.isBoxOpen(_checkInBoxName)) {
      var box = await Hive.openBox<Attendance>(_checkInBoxName);

      // Menyimpan check-in ke dalam box
      await box.add(attendance);

      // Menutup box
      await box.close();
    }
  }

  // Fungsi untuk menyimpan data check-out
  Future<void> addCheckOutAttendance(Attendance attendance) async {
    if (!Hive.isBoxOpen(_checkOutBoxName)) {
      var box = await Hive.openBox<Attendance>(_checkOutBoxName);

      // Menyimpan check-out ke dalam box
      await box.add(attendance);

      // Menutup box
      await box.close();
    }
  }

  // Fungsi untuk mendapatkan data check-in
  Future<List<Attendance>> getCheckIn() async {
    var box = await Hive.openBox<Attendance>(_checkInBoxName);

    List<Attendance> checkIn = box.values.toList();

    // Mendapatkan data check-in
    await box.close();
    return checkIn;
  }

  // Fungsi untuk mendapatkan data check-out
  Future<List<Attendance>> getCheckOut() async {
    var box = await Hive.openBox<Attendance>(_checkOutBoxName);

    // Mendapatkan data check-out
    List<Attendance> checkOut = box.values.toList();

    await box.close();
    return checkOut;
  }

  // Fungsi untuk menghapus data check-in
  Future<void> deleteCheckIn() async {
    var box = await Hive.openBox<Attendance>(_checkInBoxName);

    // Menghapus data check-in
    await box.delete('checkIn');

    await box.close();
  }

  // Fungsi untuk menghapus data check-out
  Future<void> deleteCheckOut() async {
    var box = await Hive.openBox<Attendance>(_checkOutBoxName);

    // Menghapus data check-out
    await box.delete('checkOut');

    await box.close();
  }
}
