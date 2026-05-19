// import 'package:flutter/material.dart';
//
// import '../../models/battery_model.dart';
// import '../../service/battery_api_service/battery_api_service.dart';
// import '../../widgets/battery_widget/update_battery_dialog.dart';
//
// class BatteryListTab extends StatelessWidget {
//   final List<BatteryModel> batteries;
//
//   final Function(String id) onDelete;
//   final Function(BatteryModel battery) onUpdate;
//
//   const BatteryListTab({
//     super.key,
//     required this.batteries,
//     required this.onDelete,
//     required this.onUpdate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (batteries.isEmpty) {
//       return const Center(
//         child: Text("No Batteries Found ⚡"),
//       );
//     }
//
//     return ListView.builder(
//       itemCount: batteries.length,
//       itemBuilder: (context, index) {
//         final battery = batteries[index];
//
//         return Card(
//           child: ListTile(
//             title: Text(battery.serialNumber),
//             subtitle: Text(
//               "${battery.capacityMah} mAh | ${battery.type}",
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     showUpdateBatteryDialog(
//                       context: context,
//                       battery: battery,
//                       onUpdate: onUpdate,
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () async {
//                     final response =
//                     await BatteryApiService
//                         .deleteBattery(
//                       battery.id,
//                     );
//
//                     if (response["status"] == true) {
//                       onDelete(battery.id);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';
import '../../widgets/battery_widget/update_battery_dialog.dart';

class BatteryListTab extends StatelessWidget {
  final List<BatteryModel> batteries;
  final Function(String id) onDelete;
  final Function(BatteryModel battery) onUpdate;

  const BatteryListTab({
    super.key,
    required this.batteries,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (batteries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: const Icon(
                Icons.battery_0_bar_rounded,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "No Batteries Yet",
              style: AppTextStyles.batteryTitle,
            ),
            const SizedBox(height: 6),
            Text(
              "Add a battery to get started",
              style: AppTextStyles.cardBody,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      itemCount: batteries.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppDimens.itemGap),
      itemBuilder: (context, index) {
        final battery = batteries[index];
        return _BatteryCard(
          battery: battery,
          onDelete: onDelete,
          onUpdate: onUpdate,
        );
      },
    );
  }
}

// ── Battery card ──────────────────────────────────────────────────────────────

class _BatteryCard extends StatelessWidget {
  final BatteryModel battery;
  final Function(String id) onDelete;
  final Function(BatteryModel battery) onUpdate;

  const _BatteryCard({
    required this.battery,
    required this.onDelete,
    required this.onUpdate,
  });

  Color get _healthColor {
    if (battery.healthPercent >= 80) return AppColors.active;
    if (battery.healthPercent >= 50) return AppColors.idle;
    return AppColors.error;
  }

  Color get _healthBg {
    if (battery.healthPercent >= 80) return AppColors.activeBg;
    if (battery.healthPercent >= 50) return AppColors.idleBg;
    return AppColors.errorBg;
  }

  Color get _healthText {
    if (battery.healthPercent >= 80) return AppColors.activeText;
    if (battery.healthPercent >= 50) return AppColors.idleText;
    return AppColors.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row ──────────────────────────────────────────────────
            Row(
              children: [
                // Battery icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius:
                    BorderRadius.circular(AppRadius.avatar),
                  ),
                  child: const Icon(
                    Icons.battery_charging_full_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Serial + type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        battery.serialNumber,
                        style: AppTextStyles.batteryTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        battery.type,
                        style: AppTextStyles.batteryMeta,
                      ),
                    ],
                  ),
                ),

                // Health pill
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _healthBg,
                    borderRadius:
                    BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Text(
                    "${battery.healthPercent}%",
                    style: AppTextStyles.statusPill.copyWith(
                      color: _healthText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Health bar ───────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: battery.healthPercent / 100,
                minHeight: 5,
                backgroundColor: AppColors.border,
                valueColor:
                AlwaysStoppedAnimation<Color>(_healthColor),
              ),
            ),

            const SizedBox(height: 14),

            // ── Divider ──────────────────────────────────────────────────
            const Divider(
              color: AppColors.border,
              height: 1,
              thickness: 1,
            ),

            const SizedBox(height: 12),

            // ── Footer: capacity + actions ───────────────────────────────
            Row(
              children: [
                // Capacity chip
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius:
                    BorderRadius.circular(AppRadius.tag),
                    border: Border.all(
                        color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bolt,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${battery.capacityMah} mAh",
                        style: AppTextStyles.vehicleTag,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Edit button
                _ActionButton(
                  icon: Icons.edit_outlined,
                  color: AppColors.primary,
                  bgColor: AppColors.primaryLight,
                  onTap: () => showUpdateBatteryDialog(
                    context: context,
                    battery: battery,
                    onUpdate: onUpdate,
                  ),
                ),
                const SizedBox(width: 8),

                // Delete button
                _ActionButton(
                  icon: Icons.delete_outline_rounded,
                  color: AppColors.error,
                  bgColor: AppColors.errorBg,
                  onTap: () =>
                      _confirmDelete(context, battery),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, BatteryModel battery) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        title: Text(
          "Delete Battery?",
          style: AppTextStyles.batteryTitle,
        ),
        content: Text(
          "This will permanently remove ${battery.serialNumber} from the fleet.",
          style: AppTextStyles.cardBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: AppTextStyles.chipLabel.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: Text(
              "Delete",
              style: AppTextStyles.buttonLabel,
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final response =
      await BatteryApiService.deleteBattery(battery.id);
      if (response["status"] == true) {
        onDelete(battery.id);
      }
    }
  }
}

// ── Small icon action button ──────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.avatar),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}