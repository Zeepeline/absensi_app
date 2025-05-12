import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:absensi_app/shared/cores/constants/colorpedia.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AttendanceStatusCard extends StatelessWidget {
  final bool isAbsent; // Status absensi (sudah atau belum)
  final DateTime? checkInTime; // Waktu absensi (jika sudah absen)
  final String location; // Lokasi absensi (misalnya, kota atau tempat)
  final String title;
  final IconData icon;
  final bool? isLate;

  const AttendanceStatusCard({
    super.key,
    required this.isAbsent,
    this.checkInTime,
    required this.location,
    required this.title,
    required this.icon,
    this.isLate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: 0.1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Absensi
          Row(
            children: [
              Icon(icon, color: AppColors.brandBaseDark),
              Gap(8),
              Text(title, style: AppTextStyles.bodyLargeRegular),
            ],
          ),
          Gap(8),
          Text(location,
              style: AppTextStyles.bodyMediumMedium.copyWith(
                color: isLate == null
                    ? null
                    : isLate == true
                        ? AppColors.errorBaseDark
                        : AppColors.successBaseDark,
              )),
        ],
      ),
    );
  }
}
