import 'package:hive/hive.dart';

part 'attendance_model.g.dart';

@HiveType(typeId: 1)
class Attendance extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final bool isAccepted;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String name;

  @HiveField(6)
  final String address;

  Attendance({
    required this.userId,
    required this.isAccepted,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.name,
    required this.address,
  });
}
