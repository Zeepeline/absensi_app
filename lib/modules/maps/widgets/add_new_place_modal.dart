import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:absensi_app/shared/cores/services/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationController extends GetxController {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final notesController = TextEditingController();
  final checkInLimitController = TextEditingController(); // batas jam masuk
  final checkOutLimitController = TextEditingController(); // batas jam pulang

  final checkInLimit = Rx<TimeOfDay?>(null);
  final checkOutLimit = Rx<TimeOfDay?>(null);

  final checkInDateTime = DateTime.now().obs;
  final checkOutDateTime = DateTime.now().obs;

  final isFormValid = false.obs;

  void validateForm() {
    isFormValid.value = nameController.text.trim().isNotEmpty &&
        checkInLimit.value != null &&
        checkOutLimit.value != null;
  }

  void clearFields() {
    nameController.clear();
    addressController.clear();
    latController.clear();
    lngController.clear();
    notesController.clear();
    checkInLimitController.clear();
    checkOutLimitController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(validateForm);
    checkInLimitController.addListener(validateForm);
    checkOutLimitController.addListener(validateForm);
  }
}

Future<void> pickTime(Rx<TimeOfDay?> target, TextEditingController controller,
    Rx<DateTime?>? targetDateTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: Get.context!,
    initialTime: target.value ?? TimeOfDay.now(),
  );
  if (picked != null) {
    target.value = picked;
    controller.text = formatTime(picked);
  }

  if (targetDateTime != null) {
    final now = DateTime.now();
    targetDateTime.value =
        DateTime(now.year, now.month, now.day, picked!.hour, picked.minute);
  }
}

String formatTime(TimeOfDay? time) {
  if (time == null) return '';
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

Future<void> showAddLocationBottomSheet(
  LatLng latLng,
  void Function(String name, LatLng latLng, DateTime checkInLimit,
          DateTime checkOutLimit)
      onSave, {
  Location? initialData,
}) async {
  final controller = Get.put(AddLocationController());
  // final locationController = Get.find<LocationController>();

  if (initialData != null) {
    controller.nameController.text = initialData.name;
    controller.addressController.text = initialData.address;
    controller.notesController.text = '';

    controller.checkInLimit.value =
        TimeOfDay.fromDateTime(initialData.checkInLimit);
    controller.checkOutLimit.value =
        TimeOfDay.fromDateTime(initialData.checkOutLimit);

    controller.checkInLimitController.text =
        formatTime(controller.checkInLimit.value);
    controller.checkOutLimitController.text =
        formatTime(controller.checkOutLimit.value);

    controller.checkInDateTime.value = initialData.checkInLimit;
    controller.checkOutDateTime.value = initialData.checkOutLimit;
  } else {
    // Jika bukan edit, isi address dari latlng
    final locationController = Get.find<LocationController>();
    locationController
        .getAddressFromLatLng(latLng.latitude, latLng.longitude)
        .then((value) {
      controller.addressController.text = value;
    });
  }

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                initialData == null ? 'Tambah Lokasi Baru' : 'Ubah Lokasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(24),
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lokasi',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.bodyMediumRegular,
            ),
            Gap(16),
            TextField(
              controller: controller.addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: AppTextStyles.bodyMediumRegular,
            ),
            Gap(16),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    initialValue: latLng.latitude.toString(),
                    decoration: const InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        fillColor: Colors.blue),
                    style: AppTextStyles.bodyMediumRegular,
                    enabled: false,
                  ),
                ),
                Gap(8),
                Flexible(
                  child: TextFormField(
                    initialValue: latLng.longitude.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: AppTextStyles.bodyMediumRegular,
                    enabled: false,
                  ),
                ),
              ],
            ),
            Gap(16),
            Row(children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => pickTime(
                      controller.checkInLimit,
                      controller.checkInLimitController,
                      controller.checkInDateTime),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Batas Jam Masuk',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      style: AppTextStyles.bodyMediumRegular,
                      controller: controller.checkInLimitController,
                    ),
                  ),
                ),
              ),
              Gap(8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    pickTime(
                        controller.checkOutLimit,
                        controller.checkOutLimitController,
                        controller.checkOutDateTime);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mulai Jam Pulang',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      style: AppTextStyles.bodyMediumRegular,
                      controller: controller.checkOutLimitController,
                    ),
                  ),
                ),
              ),
            ]),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.clearFields();
                      Get.back();
                    },
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isFormValid.value
                              ? () {
                                  final name = controller.nameController.text;

                                  onSave(
                                    name,
                                    latLng,
                                    controller.checkInDateTime.value,
                                    controller.checkOutDateTime.value,
                                  );

                                  controller.clearFields();
                                  Get.back();
                                }
                              : null,
                          child: const Text('Simpan'),
                        ))),
              ],
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
