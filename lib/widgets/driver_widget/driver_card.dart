import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';
import '../../service/qr/driver_qr.dart';
import 'driver_avatar.dart';
import 'status_pill.dart';
import 'vehicle_tag.dart';

class DriverCard extends StatelessWidget {
  final DriverModel driver;
  final VoidCallback? onTap;

  const DriverCard({
    super.key,
    required this.driver,
    this.onTap,
  });

  Color get _accentColor {
    switch (driver.status) {
      case DriverStatus.active:
        return AppColors.active;
      case DriverStatus.idle:
        return AppColors.idle;
      case DriverStatus.offline:
        return AppColors.border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(width: 4, color: _accentColor),

              // Card content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  child: Row(
                    children: [
                      DriverAvatar(driver: driver),
                      const SizedBox(width: 14),
                      Expanded(child: _DriverInfo(driver: driver)),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          StatusPill(status: driver.status),
                          const SizedBox(height: 2,),
                          IconButton(
                            onPressed: () => _showQrDialog(context, driver),
                            icon: const Icon(Icons.qr_code_2_rounded),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQrDialog(BuildContext context, DriverModel driver) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: Text(
          "Driver QR Code",
          style: AppTextStyles.batteryTitle,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: DriverQrService.buildQrCode(
                driver,
                size: 200,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              driver.name,
              style: AppTextStyles.batteryTitle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 1),

            Text(
              driver.vehicleNumber,
              style: AppTextStyles.batteryMeta,
            ),
          ],
        ),

        actions: [
          TextButton.icon(
            onPressed: () async {
              final success =
              await DriverQrService.downloadQr(driver);

              if (!context.mounted) return;
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? "QR downloaded successfully"
                        : "Failed to download QR",
                  ),
                  backgroundColor: success ? Colors.green : Colors.red,
                ),
              );
            },
            icon: const Icon(Icons.download),
            label: Text(
              "Download",
              style: AppTextStyles.chipLabel.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: AppTextStyles.chipLabel.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverInfo extends StatelessWidget {
  final DriverModel driver;

  const _DriverInfo({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          driver.name,
          style: AppTextStyles.driverName,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(driver.phone, style: AppTextStyles.driverPhone),
        const SizedBox(height: 6),
        VehicleTag(vehicleNumber: driver.vehicleNumber),
      ],
    );
  }
}