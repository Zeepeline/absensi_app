import 'package:absensi_app/features/attendances/models/attendance_model.dart';
import 'package:absensi_app/features/attendances/repositories/attendance_repository.dart';
import 'package:absensi_app/features/locations/models/location_model.dart';
import 'package:absensi_app/features/locations/repositories/locations_repository.dart';
import 'package:absensi_app/modules/home/controller/home_page_controller.dart';
import 'package:absensi_app/modules/home/widgets/attendance_status_card.dart';
import 'package:absensi_app/shared/cores/constants/app_text_style.dart';
import 'package:absensi_app/shared/cores/constants/colorpedia.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final locationRepository = LocationRepository();
  final attendanceRepository = AttendanceRepository();
  final List<Attendance> attandancesCheckIn = <Attendance>[].obs;
  final List<Attendance> attandancesCheckOut = <Attendance>[].obs;
  final List<Location> locations = <Location>[].obs;
  int selectedIndex = 0;

  Future<void> refresh() async {
    attandancesCheckIn.clear();
    attandancesCheckOut.clear();
    locations.clear();
    attendanceRepository.getCheckIn().then((checkIn) {
      attandancesCheckIn.addAll(checkIn);
    });
    attendanceRepository.getCheckOut().then((checkOut) {
      attandancesCheckOut.addAll(checkOut);
    });
    locationRepository.getLocations().then((fetchedLocations) {
      locations.addAll(fetchedLocations);
    });
  }

  @override
  void initState() {
    super.initState();
    Get.put(this);
    Get.put(HomePageController());

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    final tabs = ['Check-In', 'Check-Out'];
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(child: Obx(() {
        return Stack(
          children: [
            CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                // Bagian atas dengan background biru
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 290,
                    child: Stack(
                      children: [
                        // Background Biru
                        Container(
                          height: 230,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                child: Image.asset('assets/images/cool.png'),
                              ),
                              const Gap(16),
                              Text('Welcome Back!',
                                  style: AppTextStyles.displayHeading.copyWith(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        // AppDrawer mengambang di atas background
                        Positioned(
                          top: 180, // Tentukan jarak dari atas
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                  color: Colors.black.withValues(alpha: 0.1),
                                )
                              ],
                            ),
                            child: _buildAppDrawer(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spasi setelah drawer
                SliverToBoxAdapter(child: const Gap(24)),

                // Absensi section
                SliverToBoxAdapter(
                  child: attandancesCheckIn.isEmpty
                      ? _buildEmptyAbsensiSection(dateFormat)
                      : _buildAbsensiSection(dateFormat),
                ),

                // Riwayat Absensi Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(24),
                        Text('Riwayat Absensi',
                            style: AppTextStyles.subtitleLargeBold),
                        const Gap(24),

                        // Chips
                        Wrap(
                          spacing: 8,
                          children: List.generate(tabs.length, (index) {
                            return ChoiceChip(
                              label: Text(tabs[index]),
                              selected: selectedIndex == index,
                              labelStyle: AppTextStyles.bodyMediumBold.copyWith(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              selectedColor: selectedIndex == 0
                                  ? Colors.blueAccent
                                  : AppColors.brandBaseDark,
                              onSelected: (selected) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            );
                          }),
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ),

                // Animated list switch
                SliverToBoxAdapter(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: selectedIndex == 0
                        ? _buildAttendanceList(attandancesCheckIn, 'Check-In')
                        : _buildAttendanceList(
                            attandancesCheckOut, 'Check-Out'),
                  ),
                ),

                // Bottom padding biar ga ketutup FAB
                SliverToBoxAdapter(child: const SizedBox(height: 100)),
              ],
            ),
          ],
        );
      })),
    );
  }

  Widget _buildAttendanceList(List<Attendance> list, String label) {
    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/box.png',
              width: 120,
              height: 120,
            ),
            Gap(8),
            Text(
              'Belum ada riwayat absensi, ayo lakukan presensi',
              style: AppTextStyles.bodyMediumMedium,
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final Attendance loc = list[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: label == 'Check-In'
                          ? Colors.blueAccent
                          : AppColors.brandBaseDark,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.name, style: AppTextStyles.bodyMediumBold),
                          const SizedBox(height: 8),
                          Text(loc.address,
                              style: AppTextStyles.bodyMediumRegular),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Remix.time_fill,
                      size: 14,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat.Hm().format(loc.timestamp),
                      style: AppTextStyles.bodyMediumBold,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyAbsensiSection(DateFormat dateFormat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Absensi', style: AppTextStyles.subtitleLargeBold),
          Gap(24),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Status',
                  isAbsent: true,
                  location: 'Belum Absen',
                  checkInTime: DateTime.now(),
                  icon: Icons.check_circle,
                ),
              ),
              Gap(8),
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Waktu',
                  isAbsent: true,
                  location: '-',
                  checkInTime: DateTime.now(),
                  icon: Icons.access_time,
                ),
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Nama Tempat',
                  isAbsent: true,
                  location: '-',
                  checkInTime: DateTime.now(),
                  icon: Icons.location_on,
                ),
              ),
            ],
          ),
          Gap(24),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Alamat',
                  isAbsent: true,
                  location: '-',
                  checkInTime: DateTime.now(),
                  icon: Icons.location_on,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiSection(DateFormat dateFormat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Absensi', style: AppTextStyles.subtitleLargeBold),
          Gap(24),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Status',
                  isAbsent: true,
                  location: attandancesCheckIn[attandancesCheckIn.length - 1]
                          .isAccepted
                      ? 'Sudah Absen - ${DateFormat.Hm().format(attandancesCheckIn[attandancesCheckIn.length - 1].timestamp)}'
                      : 'Terlambat - ${DateFormat.Hm().format(attandancesCheckIn[attandancesCheckIn.length - 1].timestamp)}',
                  checkInTime: DateTime.now(),
                  icon: Icons.check_circle,
                  isLate: !attandancesCheckIn[attandancesCheckIn.length - 1]
                      .isAccepted,
                ),
              ),
              Gap(8),
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Waktu',
                  isAbsent: true,
                  location: dateFormat.format(
                      attandancesCheckIn[attandancesCheckIn.length - 1]
                          .timestamp),
                  checkInTime: DateTime.now(),
                  icon: Icons.access_time,
                ),
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Nama Tempat',
                  isAbsent: true,
                  location:
                      attandancesCheckIn[attandancesCheckIn.length - 1].name,
                  checkInTime: DateTime.now(),
                  icon: Remix.home_3_fill,
                ),
              ),
            ],
          ),
          Gap(24),
          Row(
            children: [
              Expanded(
                child: AttendanceStatusCard(
                  title: 'Alamat',
                  isAbsent: true,
                  location:
                      attandancesCheckIn[attandancesCheckIn.length - 1].address,
                  checkInTime: DateTime.now(),
                  icon: Icons.location_on,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppDrawer() {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFeatureIcon(
            'Check-in',
            Remix.login_box_line,
            () {
              Get.toNamed<void>('/check-in');
            },
          ),
          Gap(8),
          _buildFeatureIcon(
            'Check-out',
            Remix.logout_box_line,
            () {
              Get.toNamed<void>('/check-out');
            },
          ),
          Gap(8),
          _buildFeatureIcon(
            'Lokasi',
            Remix.map_pin_2_line,
            () {
              Get.toNamed<void>('/map');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 80,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.brandBaseDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            Gap(8),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  AppTextStyles.bodyRegularBold.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
