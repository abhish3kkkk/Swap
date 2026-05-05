import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class VehicleTag extends StatelessWidget {
  final String vehicleNumber;

  const VehicleTag({super.key, required this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.tag),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Text(vehicleNumber, style: AppTextStyles.vehicleTag),
    );
  }
}