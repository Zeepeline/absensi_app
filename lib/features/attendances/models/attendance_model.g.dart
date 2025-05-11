// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceAdapter extends TypeAdapter<Attendance> {
  @override
  final int typeId = 1;

  @override
  Attendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendance(
      userId: fields[0] as String,
      isAccepted: fields[1] as bool,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      timestamp: fields[4] as DateTime,
      name: fields[5] as String,
      address: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Attendance obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.isAccepted)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
