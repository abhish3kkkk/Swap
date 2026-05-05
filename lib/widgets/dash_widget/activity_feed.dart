import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/activity_item.dart';

class ActivityFeed extends StatelessWidget {
  final List<ActivityItem> activities;

  const ActivityFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.map((item) => ActivityTile(item: item)).toList(),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final ActivityItem item;

  const ActivityTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.itemGap),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _buildIconBox(),
          const SizedBox(width: 12),
          _buildTextContent(),
          Text(item.time, style: AppTextStyles.statLabel),
        ],
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: item.iconColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppRadius.avatar),
      ),
      child: Icon(item.icon, color: item.iconColor, size: 18),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: AppTextStyles.batteryTitle.copyWith(fontSize: 13)),
          const SizedBox(height: 2),
          Text(item.subtitle, style: AppTextStyles.batteryMeta),
        ],
      ),
    );
  }
}