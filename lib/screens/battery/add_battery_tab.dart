// import 'package:flutter/material.dart';
//
// import '../../config/app_theme.dart';
// import '../../models/battery_model.dart';
// import '../../service/battery_api_service/battery_api_service.dart';
//
// class AddBatteryTab extends StatefulWidget {
//   final Function(BatteryModel battery) onAdd;
//
//   const AddBatteryTab({
//     super.key,
//     required this.onAdd,
//   });
//
//   @override
//   State<AddBatteryTab> createState() =>
//       _AddBatteryTabState();
// }
//
// class _AddBatteryTabState
//     extends State<AddBatteryTab> {
//   final _formKey = GlobalKey<FormState>();
//
//   final serialController = TextEditingController();
//   final mahController = TextEditingController();
//   final typeController = TextEditingController();
//   final statusController = TextEditingController();
//
//   bool isLoading = false;
//
//   Future<void> submit() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       print("Battery Add Response : ${ serialController.text.trim()}");
//       print("Battery Add Response : ${mahController.text.trim()}");
//       print("Battery Add Response : ${typeController.text.trim()}");
//
//       final response =
//       await BatteryApiService.addBattery(
//         serialNo: serialController.text.trim(),
//         capacityMah: mahController.text.trim(),
//         type: typeController.text.trim(),
//       );
//
//       print("Battery Add Response : $response");
//
//       if (response["status"] == true) {
//         final battery = BatteryModel(
//           id: response["battery_id"].toString(),
//           serialNumber: serialController.text.trim(),
//           capacityMah:
//           int.parse(mahController.text.trim()),
//           healthPercent: 100,
//           type: typeController.text.trim(),
//         );
//
//         widget.onAdd(battery);
//
//         serialController.clear();
//         mahController.clear();
//         typeController.clear();
//
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 "Battery added successfully ⚡",
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//         ),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//       const EdgeInsets.all(AppDimens.pagePadding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: serialController,
//               decoration: const InputDecoration(
//                 hintText: "Battery Serial Number",
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: mahController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 hintText: "Battery Capacity",
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: typeController,
//               decoration: const InputDecoration(
//                 hintText: "Battery Type",
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isLoading ? null : submit,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text("Add Battery"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';

class AddBatteryTab extends StatefulWidget {
  final Function(BatteryModel battery) onAdd;

  const AddBatteryTab({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddBatteryTab> createState() => _AddBatteryTabState();
}

class _AddBatteryTabState extends State<AddBatteryTab> {
  final _formKey = GlobalKey<FormState>();

  final serialController = TextEditingController();
  final mahController = TextEditingController();
  final typeController = TextEditingController();

  bool isLoading = false;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await BatteryApiService.addBattery(
        serialNo: serialController.text.trim(),
        capacityMah: mahController.text.trim(),
        type: typeController.text.trim(),
      );

      if (response["status"] == true) {
        final battery = BatteryModel(
          id: response["battery_id"].toString(),
          serialNumber: serialController.text.trim(),
          capacityMah: int.parse(mahController.text.trim()),
          healthPercent: 100,
          type: typeController.text.trim(),
        );

        widget.onAdd(battery);
        serialController.clear();
        mahController.clear();
        typeController.clear();

        if (mounted) {
          _showSnackBar(
            context,
            message: "Battery added successfully ⚡",
            isError: false,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(context, message: e.toString(), isError: true);
      }
    }

    setState(() => isLoading = false);
  }

  void _showSnackBar(
      BuildContext context, {
        required String message,
        required bool isError,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppDimens.pagePadding),
        backgroundColor:
        isError ? AppColors.errorBg : AppColors.successBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(
            color: isError ? AppColors.error : AppColors.success,
            width: 1,
          ),
        ),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.bolt_rounded,
              color: isError ? AppColors.errorText : AppColors.successText,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.cardBody.copyWith(
                  color: isError
                      ? AppColors.errorText
                      : AppColors.successText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                      BorderRadius.circular(AppRadius.avatar),
                    ),
                    child: const Icon(
                      Icons.bolt_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Battery",
                        style: AppTextStyles.batteryTitle.copyWith(
                          color: AppColors.activeText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Register a battery to the fleet",
                        style: AppTextStyles.cardBody.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimens.sectionGap),

            // ── Section label ────────────────────────────────────────────
            Text(
              "BATTERY DETAILS",
              style: AppTextStyles.sectionLabel,
            ),
            const SizedBox(height: AppDimens.itemGap),

            // ── Serial Number ────────────────────────────────────────────
            _AppTextField(
              controller: serialController,
              hintText: "Battery Serial Number",
              prefixIcon: Icons.qr_code_rounded,
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? "Required" : null,
            ),
            const SizedBox(height: AppDimens.fieldGap),

            // ── Capacity ──────────────────────────────────────────────────
            _AppTextField(
              controller: mahController,
              hintText: "Capacity (mAh)",
              prefixIcon: Icons.battery_charging_full_rounded,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return "Required";
                if (int.tryParse(v.trim()) == null) {
                  return "Enter a valid number";
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimens.fieldGap),

            // ── Type ──────────────────────────────────────────────────────
            _AppTextField(
              controller: typeController,
              hintText: "Battery Type (e.g. Li-ion)",
              prefixIcon: Icons.category_rounded,
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? "Required" : null,
            ),

            const SizedBox(height: 32),

            // ── Submit Button ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor:
                  AppColors.primary.withOpacity(0.5),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(AppRadius.button),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Add Battery",
                      style: AppTextStyles.buttonLabel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared text field ──────────────────────────────────────────────────────────

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _AppTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.inputText.copyWith(
          color: AppColors.textHint,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.textTertiary,
          size: 20,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        errorStyle: AppTextStyles.cardBody.copyWith(
          color: AppColors.errorText,
        ),
      ),
    );
  }
}