import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class QrScanButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isScanned;

  const QrScanButton({
    super.key,
    required this.onTap,
    this.isScanned = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isScanned ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(
            color: isScanned ? AppColors.primary : AppColors.border,
            width: isScanned ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isScanned ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isScanned
                    ? Icons.qr_code_scanner_rounded
                    : Icons.qr_code_2_rounded,
                size: 22,
                color: isScanned ? Colors.white : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isScanned ? 'Battery scanned' : 'Scan battery QR code',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isScanned
                          ? AppColors.primaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isScanned
                        ? 'Tap to rescan'
                        : 'Point camera at battery QR tag',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isScanned
                  ? Icons.check_circle_rounded
                  : Icons.chevron_right_rounded,
              size: 20,
              color:
              isScanned ? AppColors.primary : AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}