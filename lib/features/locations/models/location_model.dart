import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 0)
class Location extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final DateTime checkInLimit;

  @HiveField(6)
  final DateTime checkOutLimit;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.address,
    required this.checkInLimit,
    required this.checkOutLimit,
  });
}
