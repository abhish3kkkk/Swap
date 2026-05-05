import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class DashboardStatusBar extends StatelessWidget {
  const DashboardStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const _StatusItem(
            icon: Icons.circle,
            iconColor: AppColors.active,
            label: "System",
            value: "Online",
            valueColor: AppColors.activeText,
          ),
          _verticalDivider(),
          const _StatusItem(
            icon: Icons.battery_full_rounded,
            iconColor: Color(0xFF185FA5),
            label: "Fleet",
            value: "24 Units",
            valueColor: AppColors.textPrimary,
          ),
          _verticalDivider(),
          const _StatusItem(
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.warning,
            label: "Alerts",
            value: "3 Active",
            valueColor: AppColors.warningText,
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 32,
      color: AppColors.border,
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;

  const _StatusItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 9),
              const SizedBox(width: 5),
              Text(label, style: AppTextStyles.statLabel),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.statNumber.copyWith(
              fontSize: 13,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}