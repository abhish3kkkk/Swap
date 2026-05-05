import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class BatteryOverviewCard extends StatelessWidget {
  final int available;
  final int inUse;
  final int charging;
  final double availabilityRatio;

  const BatteryOverviewCard({
    super.key,
    this.available = 18,
    this.inUse = 4,
    this.charging = 2,
    this.availabilityRatio = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildStats(),
          const SizedBox(height: 20),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Battery Fleet Overview",
          style: TextStyle(
            fontFamily: 'Syne',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: const Text(
            "Today",
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        _FleetStat(value: "$available", label: "Available"),
        const SizedBox(width: 28),
        _FleetStat(value: "$inUse", label: "In Use"),
        const SizedBox(width: 28),
        _FleetStat(value: "$charging", label: "Charging"),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: availabilityRatio,
            backgroundColor: Colors.white.withOpacity(0.25),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fleet availability",
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "${(availabilityRatio * 100).toInt()}%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FleetStat extends StatelessWidget {
  final String value;
  final String label;

  const _FleetStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.statNumber.copyWith(
            color: Colors.white,
            fontSize: 30,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: AppTextStyles.statLabel.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}