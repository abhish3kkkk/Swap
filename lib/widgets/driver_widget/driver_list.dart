import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';
import 'driver_card.dart';

class DriverList extends StatelessWidget {
  final List<DriverModel> drivers;
  final ValueChanged<DriverModel>? onDriverTap;

  const DriverList({
    super.key,
    required this.drivers,
    this.onDriverTap,
  });

  @override
  Widget build(BuildContext context) {
    if (drivers.isEmpty) {
      return const _EmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: drivers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final driver = drivers[index];
        return DriverCard(
          driver: driver,
          onTap: () => onDriverTap?.call(driver),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Icon(Icons.person_search_rounded,
                size: 44, color: AppColors.textTertiary),
            SizedBox(height: 12),
            Text(
              'No drivers found',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}