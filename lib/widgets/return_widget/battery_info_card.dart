import 'package:flutter/material.dart';
import '../../models/battery_model.dart';
import '../../config/app_theme.dart';

class BatteryInfoCard extends StatelessWidget {
  final BatteryModel battery;
  final VoidCallback onRemove;

  const BatteryInfoCard({
    super.key,
    required this.battery,
    required this.onRemove,
  });

  Color get _healthColor {
    if (battery.healthPercent >= 80) return AppColors.success;
    if (battery.healthPercent >= 50) return AppColors.warning;
    return AppColors.error;
  }

  Color get _healthBg {
    if (battery.healthPercent >= 80) return AppColors.successBg;
    if (battery.healthPercent >= 50) return AppColors.warningBg;
    return AppColors.errorBg;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.battery_charging_full_rounded,
                    size: 22, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(battery.type, style: AppTextStyles.batteryTitle),
                    Text('ID: ${battery.id}',
                        style: AppTextStyles.batteryMeta),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close_rounded,
                      size: 16, color: AppColors.textTertiary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.border, height: 1, thickness: 0.5),
          const SizedBox(height: 14),
          Row(
            children: [
              _InfoTile(
                label: 'Serial No.',
                value: battery.serialNumber,
              ),
              _InfoTile(
                label: 'Capacity',
                value: '${battery.capacityMah} mAh',
              ),
              _InfoTile(
                label: 'Health',
                value: '${battery.healthPercent}%',
                valueColor: _healthColor,
                valueBg: _healthBg,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final Color? valueBg;

  const _InfoTile({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBg,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasBadge = valueColor != null && valueBg != null;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.batteryMeta),
          const SizedBox(height: 4),
          hasBadge
              ? Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: valueBg,
              borderRadius: BorderRadius.circular(AppRadius.badge),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          )
              : Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}