import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/driver_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final vehicleController = TextEditingController();

  DriverStatus selectedStatus = DriverStatus.offline;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          "https://dynamic-futuretech.com/swap_app/apis/addDriver.php",
        ),
        body: {
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "address": addressController.text.trim(),
          "vehical_number": vehicleController.text.trim(),

          // active = 1, idle = 2, offline = 0
          "status": _mapStatusToInt(selectedStatus).toString(),
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == true) {

        final driver = DriverModel(
          id: data["driver_id"],
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          address: addressController.text.trim(),
          vehicleNumber: vehicleController.text.trim(),
          status: selectedStatus,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Driver added successfully"),
            ),
          );

          Navigator.pop(context, driver);
        }

      } else {

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data["message"] ?? "Something went wrong"),
            ),
          );
        }
      }

    } catch (e) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  int _mapStatusToInt(DriverStatus status) {
    switch (status) {
      case DriverStatus.offline:
        return 0;

      case DriverStatus.active:
        return 1;

      case DriverStatus.idle:
        return 2;
    }
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
                      child: Center(
                    child: isLoading
                    ? const SizedBox(
                    height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                    "Add Driver",
                    style: AppTextStyles.buttonLabel,
                  ),
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