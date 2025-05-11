import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PresenceDialog extends StatelessWidget {
  final bool isSuccess; // Menentukan apakah presensi berhasil atau gagal

  const PresenceDialog({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    // Menentukan ikon dan teks berdasarkan status presensi
    String svgAsset = isSuccess
        ? 'assets/vectors/success_vector.svg'
        : 'assets/vectors/fail_vector.svg';
    String text = isSuccess ? "Presensi Berhasil" : "Presensi Gagal";
    String description = isSuccess
        ? "Presensi Anda telah tercatat dengan sukses."
        : "Terjadi kesalahan saat melakukan presensi, pastikan jarak anda berada di dalam 50 meter dari titik lokasi dan pastikan waktu presensi sesuai dengan waktu yang sudah diatur.";

    return AlertDialog(
      contentPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(16),
          Text(text,
              style: AppTextStyles.subtitleLargeBold.copyWith(
                color: isSuccess ? Colors.green : Colors.red,
              )),
          Gap(8),
          SvgPicture.asset(
            svgAsset,
            height: 150,
          ),
          Text(description,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyRegularMedium),
          Gap(20),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Menutup dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSuccess ? Colors.green : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Text("Tutup",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyRegularMedium)),
          ),
        ],
      ),
    );
  }
}
