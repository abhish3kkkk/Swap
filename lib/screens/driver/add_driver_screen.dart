import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/driver_model.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final vehicleController = TextEditingController();

  DriverStatus selectedStatus = DriverStatus.offline;

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    final driver = DriverModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      vehicleNumber: vehicleController.text,
      status: selectedStatus,
    );

    // TODO: Save to DB / API
    print(driver.toJson());

    Navigator.pop(context, driver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Add Driver"),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Driver Details", style: AppTextStyles.cardTitle),

                const SizedBox(height: 20),

                _input("Full Name", nameController),
                const SizedBox(height: 16),

                _input("Phone Number", phoneController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 16),

                _input("Address", addressController, maxLines: 2),
                const SizedBox(height: 16),

                _input("Vehicle Number", vehicleController),
                const SizedBox(height: 20),

                // ── Status Selector ─────────────────────
                Text("Status", style: AppTextStyles.fieldLabel),
                const SizedBox(height: 10),

                Row(
                  children: DriverStatus.values.map((status) {
                    final isSelected = selectedStatus == status;

                    final colors = _getStatusColors(status);

                    return GestureDetector(
                      onTap: () => setState(() => selectedStatus = status),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors['bg']
                              : AppColors.background,
                          borderRadius:
                          BorderRadius.circular(AppRadius.chip),
                          border: Border.all(
                            color: isSelected
                                ? colors['color']!
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          status.name.toUpperCase(),
                          style: AppTextStyles.chipLabel.copyWith(
                            color: isSelected
                                ? colors['text']
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 30),

                // ── Submit Button ─────────────────────
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                      BorderRadius.circular(AppRadius.button),
                    ),
                    child: Center(
                      child: Text(
                        "Add Driver",
                        style: AppTextStyles.buttonLabel,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Input Field ─────────────────────────
  Widget _input(
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
        int maxLines = 1,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: (v) =>
          v == null || v.isEmpty ? "Required" : null,
          style: AppTextStyles.inputText,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: "Enter $label",
            hintStyle: AppTextStyles.inputText.copyWith(
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide:
              BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  // ── Status Colors Mapping ─────────────────────────
  Map<String, Color> _getStatusColors(DriverStatus status) {
    switch (status) {
      case DriverStatus.active:
        return {
          "color": AppColors.active,
          "bg": AppColors.activeBg,
          "text": AppColors.activeText,
        };
      case DriverStatus.idle:
        return {
          "color": AppColors.idle,
          "bg": AppColors.idleBg,
          "text": AppColors.idleText,
        };
      case DriverStatus.offline:
        return {
          "color": AppColors.offline,
          "bg": AppColors.offlineBg,
          "text": AppColors.offlineText,
        };
    }
  }
}