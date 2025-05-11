// coverage:ignore-file

import 'package:absensi_app/shared/cores/constants/colorpedia.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static late MediaQueryData mediaQuery;

  static void init(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
  }

  static double _baseSize(double baseSize) {
    final width = mediaQuery.size.width;

    if (width >= 800) {
      return baseSize * 1.4; // Tablet
    } else if (width >= 600) {
      return baseSize * 1.2; // Perangkat menengah
    } else {
      return baseSize; // Smartphone normal
    }
  }

  // Display Heading Style
  static TextStyle displayHeading = const TextStyle(
    fontFamily: 'Sora', // Font Family
    fontSize: 32, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w700, // Font Weight (Bold)
    height: 40 / 32, // Line Height (40px dari fontSize 32px)
    letterSpacing: 0, // Letter Spacing
  );

  // Headline Style
  static TextStyle headline = TextStyle(
    fontFamily: 'Sora',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(24),
    height: 0.9, // Line Height: 90%
    letterSpacing: -0.01 * 24, // Letter Spacing: -1%
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Title Style
  static TextStyle title = TextStyle(
    fontFamily: 'Sora',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(20),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 20, // Letter Spacing: -2% (2% of fontSize 20px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Large Black
  static TextStyle subtitleLargeBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(20),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 20, // Letter Spacing: -2% (2% of fontSize 20px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Large Bold
  static TextStyle subtitleLargeBold = const TextStyle(
    fontFamily: 'Satoshi', // Pastikan font Satoshi sudah tersedia dalam proyek
    fontSize: 20, // Ukuran font
    fontWeight: FontWeight.w700, // Bold (700)
    height: 28 / 20, // Line height (140% dari font size)
    letterSpacing: 0, // Letter spacing
  );

  // Subtitle Large Medium
  static TextStyle subtitleLargeMedium = const TextStyle(
    color: Color(0xFF1E1E1D), // #1E1E1D dalam bentuk Color Flutter
    fontFamily: "Satoshi", // Sesuai dengan Font-Family-Secondary
    fontSize: 20, // Sesuai dengan Size-Sub-Title---Large
    fontStyle: FontStyle.normal, // Sesuai dengan font-style: normal
    fontWeight: FontWeight.w500, // Sesuai dengan Weight-Medium (500)
    height: 28 / 20, // Line-height 28px dengan font-size 20px (140%)
    letterSpacing: 0, // Sesuai dengan Spacing-Sub-Title---Large
  );

  // Subtitle Large Regular
  static TextStyle subtitleLargeRegular = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(20),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 20, // Letter Spacing: -1% (1% of fontSize 20px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Large Light
  static TextStyle subtitleLargeLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(20),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 20, // Letter Spacing: -1% (1% of fontSize 20px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Medium Black
  static TextStyle subtitleMediumBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(18), // Font Size: 18px
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 18, // Letter Spacing: -1% (1% of fontSize 18px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Medium Bold
  static TextStyle subtitleMediumBold = const TextStyle(
    fontFamily: 'Satoshi', // Font-Family-Secondary
    fontSize: 18, // Size-Sub-Title---Medium
    fontWeight: FontWeight.bold, // Weight-Bold (700)
    height: 24 / 18, // Line-height 24px (dibagi dengan fontSize untuk Flutter)
    letterSpacing: 0.15, // Spacing-Sub-Title---Medium
  );

  // Subtitle Medium Medium
  static TextStyle subtitleMediumMedium = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(18), // Font Size: 18px
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 18, // Letter Spacing: -2% (2% of fontSize 18px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Medium Regular
  static TextStyle subtitleMediumRegular = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(18), // Font Size: 18px
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 18, // Letter Spacing: -2% (2% of fontSize 18px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Subtitle Medium Light
  static TextStyle subtitleMediumLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(18), // Font Size: 18px
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 18, // Letter Spacing: -2% (2% of fontSize 18px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Tambahkan gaya teks lainnya di sini
  static TextStyle bodyLargeBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(16),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 16, // Letter Spacing: -2% (2% of fontSize 16px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Medium Black
  static TextStyle bodyMediumBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(14),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 14, // Letter Spacing: -1% (1% of fontSize 14px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Regular Black
  static TextStyle bodyRegularBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(12),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 12, // Letter Spacing: -1% (1% of fontSize 12px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Large Bold
  static TextStyle bodyLargeBold = const TextStyle(
    fontFamily: 'Satoshi', // Font-Family-Secondary
    fontSize: 16, // Size-Body---Large
    fontWeight: FontWeight.bold, // Weight-Bold (700)
    height: 24 / 16, // Line-height 24px (dibagi dengan fontSize untuk Flutter)
    letterSpacing: 0.1, // Spacing-Body---Large
  );

  // Body Medium Bold
  static TextStyle bodyMediumBold = const TextStyle(
    fontFamily: 'Satoshi', // Font Family
    fontSize: 14, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w700, // Font Weight (Bold)
    height: 20 / 14, // Line Height (20px dari fontSize 14px)
    letterSpacing: 0.1, // Letter Spacing
  );

  // Body Regular Bold
  static TextStyle bodyRegularBold = const TextStyle(
    fontFamily: 'Satoshi', // Font-Family-Secondary
    fontSize: 12, // Size-Body---Regular
    fontWeight: FontWeight.bold, // Weight-Bold (700)
    height: 16 / 12, // Line-height 16px (dibagi dengan fontSize untuk Flutter)
    letterSpacing: 0.4, // Spacing-Body---Regular
  );

  // Body Large Medium
  static TextStyle bodyLargeMedium = const TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 14, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w500, // Font Weight (Medium)
    height: 24 / 16, // Line Height (150% dari fontSize)
    letterSpacing: 0.1,
  );

  // Body Medium Medium
  static TextStyle bodyMediumMedium = const TextStyle(
    fontFamily: 'Satoshi', // Font Family
    fontSize: 14, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w500, // Font Weight (Medium)
    height: 20 / 14, // Line Height (20px dari fontSize 14px)
    letterSpacing: 0.1, // Letter Spacing
  );

  // Body Regular Medium
  static TextStyle bodyRegularMedium = const TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 12, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w500, // Font Weight (Medium)
    height: 16 / 12, // Line Height (16px dari fontSize 12px)
    letterSpacing: 0.4, // Letter Spacing
  );

  // Body Large Regular
  static TextStyle bodyLargeRegular = const TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    letterSpacing: 0.1,
  );

  // Body Medium Regular
  static TextStyle bodyMediumRegular = const TextStyle(
    fontFamily: 'Satoshi', // Font Family
    fontSize: 14, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w400, // Font Weight (Regular)
    height: 20 / 14, // Line Height (142.857% dari fontSize)
    letterSpacing: 0.1, // Letter Spacing
  );

  // Body Regular Regular
  static TextStyle bodyRegularRegular = const TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 12, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w400, // Font Weight (Regular)
    height: 16 / 12, // Line Height (16px dari fontSize 12px)
    letterSpacing: 0.4, // Letter Spacing
  );

  // Body Large Light
  static TextStyle bodyLargeLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(16),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 16, // Letter Spacing: -1% (1% of fontSize 16px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Medium Light
  static TextStyle bodyMediumLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(14),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 14, // Letter Spacing: -2% (2% of fontSize 14px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Regular Light
  static TextStyle bodyRegularLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(12),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 12, // Letter Spacing: -2% (2% of fontSize 12px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Small Black
  static TextStyle bodySmallBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(10),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 10, // Letter Spacing: -2% (2% of fontSize 10px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Tiny Black
  static TextStyle bodyTinyBlack = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(8),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 8, // Letter Spacing: -1% (1% of fontSize 8px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Small Bold
  static TextStyle bodySmallBold = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: _baseSize(10),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 10, // Letter Spacing: -2% (2% of fontSize 10px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Tiny Bold
  static TextStyle bodyTinyBold = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(8),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 8, // Letter Spacing: -1% (1% of fontSize 8px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Small Medium
  static TextStyle bodySmallMedium = const TextStyle(
    fontFamily: "Satoshi", // Sesuai dengan Font-Family-Secondary
    fontSize: 10, // Sesuai dengan Size-Body---Small
    fontStyle: FontStyle.normal, // Sesuai dengan font-style: normal
    fontWeight: FontWeight.w500, // Sesuai dengan Weight-Medium (500)
    height: 14 / 10, // Line-height 14px dengan font-size 10px (140%)
    letterSpacing: 0.4, // Sesuai dengan Spacing-Body---Small
  );

  // Body Tiny Medium
  static TextStyle bodyTinyMedium = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(8),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 8, // Letter Spacing: -2% (2% of fontSize 8px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Small Regular
  static TextStyle bodySmallRegular = const TextStyle(
    fontFamily: "Satoshi", // Sesuai dengan Font-Family-Secondary
    fontSize: 10, // Sesuai dengan Size-Body---Small
    fontStyle: FontStyle.normal, // Sesuai dengan font-style: normal
    fontWeight: FontWeight.w400, // Sesuai dengan Weight-Regular (400)
    height: 14 / 10, // Line-height 14px dengan font-size 10px (140%)
    letterSpacing: 0.4, // Sesuai dengan Spacing-Body---Small
  );

  // Body Tiny Regular
  static TextStyle bodyTinyRegular = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(8),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 8, // Letter Spacing: -2% (2% of fontSize 8px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Small Light
  static TextStyle bodySmallLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(10),
    height: 1, // Line Height: 100%
    letterSpacing: -0.01 * 10, // Letter Spacing: -1% (1% of fontSize 10px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // Body Tiny Light
  static TextStyle bodyTinyLight = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.bold,
    fontSize: _baseSize(8),
    height: 1, // Line Height: 100%
    letterSpacing: -0.02 * 8, // Letter Spacing: -2% (2% of fontSize 8px)
    color: AppColors.text500, // Atau warna lain yang sesuai
  );

  // custom
  static TextStyle loginBodyText = const TextStyle(
    color: Color(0xFFC9C9C9),
    fontFamily: 'Satoshi', // Font Family
    fontSize: 14, // Font Size
    fontStyle: FontStyle.normal, // Font Style
    fontWeight: FontWeight.w400, // Font Weight (Regular)
    height: 20 / 14, // Line Height (displayed as a factor of fontSize)
    letterSpacing: 0.1, // Letter Spacing
  );
}
