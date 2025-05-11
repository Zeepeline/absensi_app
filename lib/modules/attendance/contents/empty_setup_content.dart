import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmptySetupContent extends StatelessWidget {
  const EmptySetupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SvgPicture.asset('assets/vectors/empty_vector.svg'),
          Text(
            'Lokasi utama belum disetup. Silakan tentukan lokasi utama terlebih dahulu.',
            style: AppTextStyles.bodyMediumRegular,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Ganti dengan page map yang sesuai
              Get.toNamed('/map');
            },
            child: const Text('Tentukan Lokasi'),
          ),
        ],
      ),
    );
  }
}
