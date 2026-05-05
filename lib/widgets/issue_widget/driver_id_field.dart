import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/app_theme.dart';

class DriverIdField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const DriverIdField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Driver ID', style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-_]')),
            LengthLimitingTextInputFormatter(20),
          ],
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: 'e.g. DRV-001',
            hintStyle: const TextStyle(
              fontSize: 15,
              color: AppColors.textHint,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.badge_outlined,
                  size: 20, color: AppColors.textTertiary),
            ),
            prefixIconConstraints:
            const BoxConstraints(minWidth: 48, minHeight: 48),
            errorText: errorText,
            errorStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.error,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide:
              const BorderSide(color: AppColors.border, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide:
              const BorderSide(color: AppColors.border, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide:
              const BorderSide(color: AppColors.error, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide:
              const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}