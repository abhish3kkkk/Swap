// import 'package:flutter/material.dart';
//
// import '../../models/battery_model.dart';
// import '../../service/battery_api_service/battery_api_service.dart';
//
// Future<void> showUpdateBatteryDialog({
//   required BuildContext context,
//   required BatteryModel battery,
//   required Function(BatteryModel battery) onUpdate,
// }) async {
//   final serialController =
//   TextEditingController(
//     text: battery.serialNumber,
//   );
//
//   final mahController =
//   TextEditingController(
//     text: battery.capacityMah.toString(),
//   );
//
//   final typeController =
//   TextEditingController(
//     text: battery.type,
//   );
//
//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         title: const Text("Update Battery"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: serialController,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: mahController,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: typeController,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final response =
//               await BatteryApiService
//                   .updateBattery(
//                 id: battery.id,
//                 serialNo:
//                 serialController.text.trim(),
//                 capacityMah:
//                 mahController.text.trim(),
//                 type: typeController.text.trim(),
//               );
//
//               if (response["status"] == true) {
//                 final updatedBattery =
//                 BatteryModel(
//                   id: battery.id,
//                   serialNumber:
//                   serialController.text.trim(),
//                   capacityMah: int.parse(
//                     mahController.text.trim(),
//                   ),
//                   healthPercent: 100,
//                   type:
//                   typeController.text.trim(),
//                 );
//
//                 onUpdate(updatedBattery);
//
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text("Update"),
//           ),
//         ],
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';

Future<void> showUpdateBatteryDialog({
  required BuildContext context,
  required BatteryModel battery,
  required Function(BatteryModel battery) onUpdate,
}) async {
  final serialController =
  TextEditingController(text: battery.serialNumber);
  final mahController =
  TextEditingController(text: battery.capacityMah.toString());
  final typeController =
  TextEditingController(text: battery.type);

  await showDialog<void>(
    context: context,
    builder: (_) => _UpdateBatteryDialog(
      battery: battery,
      serialController: serialController,
      mahController: mahController,
      typeController: typeController,
      onUpdate: onUpdate,
    ),
  );
}

// ── Dialog widget ─────────────────────────────────────────────────────────────

class _UpdateBatteryDialog extends StatefulWidget {
  final BatteryModel battery;
  final TextEditingController serialController;
  final TextEditingController mahController;
  final TextEditingController typeController;
  final Function(BatteryModel) onUpdate;

  const _UpdateBatteryDialog({
    required this.battery,
    required this.serialController,
    required this.mahController,
    required this.typeController,
    required this.onUpdate,
  });

  @override
  State<_UpdateBatteryDialog> createState() =>
      _UpdateBatteryDialogState();
}

class _UpdateBatteryDialogState extends State<_UpdateBatteryDialog> {
  bool isLoading = false;

  Future<void> _submit() async {
    setState(() => isLoading = true);

    try {
      final response = await BatteryApiService.updateBattery(
        id: widget.battery.id,
        serialNo: widget.serialController.text.trim(),
        capacityMah: widget.mahController.text.trim(),
        type: widget.typeController.text.trim(),
      );

      if (response["status"] == true) {
        final updated = BatteryModel(
          id: widget.battery.id,
          serialNumber: widget.serialController.text.trim(),
          capacityMah:
          int.parse(widget.mahController.text.trim()),
          healthPercent: 100,
          type: widget.typeController.text.trim(),
        );
        widget.onUpdate(updated);
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(AppDimens.pagePadding),
            backgroundColor: AppColors.errorBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
              side: const BorderSide(color: AppColors.error),
            ),
            content: Text(
              e.toString(),
              style: AppTextStyles.cardBody.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ),
        );
      }
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius:
                    BorderRadius.circular(AppRadius.avatar),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Battery",
                      style: AppTextStyles.batteryTitle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.battery.serialNumber,
                      style: AppTextStyles.batteryMeta,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius:
                      BorderRadius.circular(AppRadius.avatar),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Section label ────────────────────────────────────────────
            Text("EDIT DETAILS", style: AppTextStyles.sectionLabel),
            const SizedBox(height: 12),

            // ── Serial Number ────────────────────────────────────────────
            _DialogField(
              controller: widget.serialController,
              hintText: "Serial Number",
              icon: Icons.qr_code_rounded,
            ),
            const SizedBox(height: 12),

            // ── Capacity ──────────────────────────────────────────────────
            _DialogField(
              controller: widget.mahController,
              hintText: "Capacity (mAh)",
              icon: Icons.battery_charging_full_rounded,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // ── Type ──────────────────────────────────────────────────────
            _DialogField(
              controller: widget.typeController,
              hintText: "Battery Type",
              icon: Icons.category_rounded,
            ),

            const SizedBox(height: 24),

            // ── Actions ───────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(
                          color: AppColors.border, width: 1.5),
                      padding:
                      const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.buttonLabel.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor:
                      AppColors.primary.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding:
                      const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      "Save Changes",
                      style: AppTextStyles.buttonLabel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared dialog text field ──────────────────────────────────────────────────

class _DialogField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;

  const _DialogField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputText.copyWith(
          color: AppColors.textHint,
        ),
        prefixIcon: Icon(icon, color: AppColors.textTertiary, size: 20),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide:
          const BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide:
          const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide:
          const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}