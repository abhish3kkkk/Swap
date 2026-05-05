import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class DriverScreenHeader extends StatelessWidget {
  final int totalCount;

  const DriverScreenHeader({super.key, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Drivers', style: AppTextStyles.screenTitle),
            const SizedBox(height: 4),
            const Text(
              'Fleet management',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: Text(
            '$totalCount total',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}