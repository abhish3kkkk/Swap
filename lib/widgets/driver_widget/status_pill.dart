import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';

class StatusPill extends StatelessWidget {
  final DriverStatus status;

  const StatusPill({super.key, required this.status});

  String get _label => status.name[0].toUpperCase() + status.name.substring(1);

  Color get _bg {
    switch (status) {
      case DriverStatus.active:
        return AppColors.activeBg;
      case DriverStatus.idle:
        return AppColors.idleBg;
      case DriverStatus.offline:
        return AppColors.offlineBg;
    }
  }

  Color get _textColor {
    switch (status) {
      case DriverStatus.active:
        return AppColors.activeText;
      case DriverStatus.idle:
        return AppColors.idleText;
      case DriverStatus.offline:
        return AppColors.offlineText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        _label,
        style: AppTextStyles.statusPill.copyWith(color: _textColor),
      ),
    );
  }
}