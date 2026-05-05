import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF1D9E75);
  static const Color primaryLight = Color(0xFFE1F5EE);
  static const Color primaryDark = Color(0xFF0F6E56);

  // Status — Active
  static const Color active = Color(0xFF1D9E75);
  static const Color activeBg = Color(0xFFE1F5EE);
  static const Color activeText = Color(0xFF0F6E56);

  // Status — Idle
  static const Color idle = Color(0xFFEF9F27);
  static const Color idleBg = Color(0xFFFAEEDA);
  static const Color idleText = Color(0xFF854F0B);

  // Status — Offline
  static const Color offline = Color(0xFF888780);
  static const Color offlineBg = Color(0xFFF1EFE8);
  static const Color offlineText = Color(0xFF5F5E5A);

  // Semantic — Success (alias of active)
  static const Color success = Color(0xFF1D9E75);
  static const Color successBg = Color(0xFFE1F5EE);
  static const Color successText = Color(0xFF0F6E56);

  // Semantic — Warning (alias of idle)
  static const Color warning = Color(0xFFEF9F27);
  static const Color warningBg = Color(0xFFFAEEDA);
  static const Color warningText = Color(0xFF854F0B);

  // Semantic — Error
  static const Color error = Color(0xFFE24B4A);
  static const Color errorBg = Color(0xFFFCEBEB);
  static const Color errorText = Color(0xFFA32D2D);

  // Avatars (background, foreground pairs)
  static const List<List<Color>> avatarPalette = [
    [Color(0xFFE1F5EE), Color(0xFF0F6E56)],
    [Color(0xFFE6F1FB), Color(0xFF185FA5)],
    [Color(0xFFFAEEDA), Color(0xFF854F0B)],
    [Color(0xFFEEEDFE), Color(0xFF534AB7)],
    [Color(0xFFFBEAF0), Color(0xFF993556)],
    [Color(0xFFFAECE7), Color(0xFF993C1D)],
  ];

  // Neutrals
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF7F7F5);
  static const Color border = Color(0xFFE8E8E5);
  static const Color borderStrong = Color(0xFFD0D0CC);
  static const Color textPrimary = Color(0xFF1A1A18);
  static const Color textSecondary = Color(0xFF6B6B68);
  static const Color textTertiary = Color(0xFFABABA8);
  static const Color textHint = Color(0xFFCCCCCA);

  // Scanner
  static const Color scannerOverlay = Color(0xCC000000);
  static const Color scannerBorder = Color(0xFF1D9E75);
}

// class AppTextStyles {
//   // Titles
//   static const TextStyle screenTitle = TextStyle(
//     fontFamily: 'Syne',
//     fontSize: 28,
//     fontWeight: FontWeight.w800,
//     color: AppColors.textPrimary,
//     letterSpacing: -0.5,
//     height: 1.1,
//   );
//
//   static const TextStyle screenTitleCompact = TextStyle(
//     fontFamily: 'Syne',
//     fontSize: 22,
//     fontWeight: FontWeight.w800,
//     color: AppColors.textPrimary,
//     letterSpacing: -0.3,
//   );
//
//   // Labels
//   static const TextStyle sectionLabel = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textTertiary,
//     letterSpacing: 0.8,
//   );
//
//   static const TextStyle fieldLabel = TextStyle(
//     fontSize: 13,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textSecondary,
//   );
//
//   // Driver card
//   static const TextStyle driverName = TextStyle(
//     fontFamily: 'Syne',
//     fontSize: 15,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimary,
//   );
//
//   static const TextStyle driverPhone = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondary,
//   );
//
//   static const TextStyle vehicleTag = TextStyle(
//     fontFamily: 'monospace',
//     fontSize: 11,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textSecondary,
//     letterSpacing: 0.5,
//   );
//
//   // Stats
//   static const TextStyle statNumber = TextStyle(
//     fontFamily: 'Syne',
//     fontSize: 22,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimary,
//   );
//
//   static const TextStyle statLabel = TextStyle(
//     fontSize: 11,
//     fontWeight: FontWeight.w500,
//     color: AppColors.textTertiary,
//     letterSpacing: 0.5,
//   );
//
//   // Chips & pills
//   static const TextStyle chipLabel = TextStyle(
//     fontSize: 13,
//     fontWeight: FontWeight.w500,
//   );
//
//   static const TextStyle statusPill = TextStyle(
//     fontSize: 11,
//     fontWeight: FontWeight.w500,
//   );
//
//   // Battery
//   static const TextStyle batteryTitle = TextStyle(
//     fontFamily: 'Syne',
//     fontSize: 15,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimary,
//   );
//
//   static const TextStyle batteryMeta = TextStyle(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondary,
//   );
//
//   // Input
//   static const TextStyle inputText = TextStyle(
//     fontSize: 15,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textPrimary,
//   );
//
//   // Button
//   static const TextStyle buttonLabel = TextStyle(
//     fontSize: 15,
//     fontWeight: FontWeight.w600,
//     color: Colors.white,
//     letterSpacing: 0.2,
//   );
// }
class AppTextStyles {
  // ── Titles ────────────────────────────────────────────────────────────────

  static const TextStyle screenTitle = TextStyle(
    fontFamily: 'Syne',
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static const TextStyle screenTitleCompact = TextStyle(
    fontFamily: 'Syne',
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  // ── Labels ────────────────────────────────────────────────────────────────

  static const TextStyle sectionLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    letterSpacing: 0.8,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // ── Cards & Tiles ─────────────────────────────────────────────────────────

  /// Primary label inside list tiles, setting rows, and notification titles.
  /// Used in: NotificationScreen, SettingsScreen
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Syne',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
  );

  /// Secondary body text inside cards / tiles (subtitles, descriptions).
  /// Used in: NotificationScreen message text, SettingsScreen subtitles
  static const TextStyle cardBody = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ── Driver card ───────────────────────────────────────────────────────────

  static const TextStyle driverName = TextStyle(
    fontFamily: 'Syne',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle driverPhone = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle vehicleTag = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  // ── Stats ─────────────────────────────────────────────────────────────────

  static const TextStyle statNumber = TextStyle(
    fontFamily: 'Syne',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    letterSpacing: 0.5,
  );

  // ── Chips & pills ─────────────────────────────────────────────────────────

  static const TextStyle chipLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle statusPill = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  // ── Battery ───────────────────────────────────────────────────────────────

  static const TextStyle batteryTitle = TextStyle(
    fontFamily: 'Syne',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle batteryMeta = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ── Input ─────────────────────────────────────────────────────────────────

  static const TextStyle inputText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // ── Button ────────────────────────────────────────────────────────────────

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  // ── Timestamps & meta ─────────────────────────────────────────────────────

  /// Small muted text for timestamps, counts, version strings.
  /// Used in: NotificationScreen time labels, SettingsScreen "Version 1.0.0"
  static const TextStyle metaText = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.2,
  );
}

class AppRadius {
  static const double card = 16.0;
  static const double chip = 20.0;
  static const double tag = 6.0;
  static const double avatar = 14.0;
  static const double fab = 16.0;
  static const double searchBar = 12.0;
  static const double statCard = 12.0;
  static const double input = 12.0;
  static const double button = 14.0;
  static const double badge = 20.0;
}

class AppDimens {
  static const double pagePadding = 20.0;
  static const double sectionGap = 24.0;
  static const double itemGap = 12.0;
  static const double fieldGap = 16.0;
}