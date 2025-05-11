import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLocationDialog() async {
  await Get.dialog(
    AlertDialog(
      title: const Text('Lokasi Utama Belum Ditentukan'),
      content:
          const Text('Anda perlu menentukan lokasi utama terlebih dahulu.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close dialog
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/map'); // Ganti dengan page map yang sesuai
          },
          child: const Text('Tentukan Lokasi'),
        ),
      ],
    ),
  );
}
