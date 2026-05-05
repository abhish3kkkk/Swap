import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/action_item.dart';

class ActionCard extends StatelessWidget {
  final ActionItem item;

  const ActionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.route != null
          ? () => Navigator.pushNamed(context, item.route!)
          : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconBox(),
            _buildLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(AppRadius.avatar),
      ),
      child: Icon(item.icon, color: item.color, size: 22),
    );
  }

  Widget _buildLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title, style: AppTextStyles.driverName),
        const SizedBox(height: 2),
        Text(item.subtitle, style: AppTextStyles.driverPhone),
      ],
    );
  }
}