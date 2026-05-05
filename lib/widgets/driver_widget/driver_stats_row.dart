import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';

class DriverStatsRow extends StatelessWidget {
  final List<DriverModel> drivers;

  const DriverStatsRow({super.key, required this.drivers});

  int _count(DriverStatus status) =>
      drivers.where((d) => d.status == status).length;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          count: _count(DriverStatus.active),
          label: 'Active',
          dotColor: AppColors.active,
        ),
        const SizedBox(width: 10),
        _StatCard(
          count: _count(DriverStatus.idle),
          label: 'Idle',
          dotColor: AppColors.idle,
        ),
        const SizedBox(width: 10),
        _StatCard(
          count: _count(DriverStatus.offline),
          label: 'Offline',
          dotColor: AppColors.offline,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final int count;
  final String label;
  final Color dotColor;

  const _StatCard({
    required this.count,
    required this.label,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.statCard),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          children: [
            Text(count.toString(), style: AppTextStyles.statNumber),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(label.toUpperCase(), style: AppTextStyles.statLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}