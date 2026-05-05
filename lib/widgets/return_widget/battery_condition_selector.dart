import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class BatteryConditionSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;

  const BatteryConditionSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _options = [
    _ConditionOption(
      value: 'good',
      label: 'Good',
      description: 'No visible damage',
      icon: Icons.check_circle_outline_rounded,
      color: AppColors.success,
      bg: AppColors.successBg,
      textColor: AppColors.successText,
    ),
    _ConditionOption(
      value: 'damaged',
      label: 'Damaged',
      description: 'Physical damage present',
      icon: Icons.warning_amber_rounded,
      color: AppColors.warning,
      bg: AppColors.warningBg,
      textColor: AppColors.warningText,
    ),
    _ConditionOption(
      value: 'needs_service',
      label: 'Needs Service',
      description: 'Performance issues',
      icon: Icons.build_outlined,
      color: AppColors.error,
      bg: AppColors.errorBg,
      textColor: AppColors.errorText,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _options.map((opt) {
        final isSelected = selected == opt.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => onChanged(opt.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? opt.bg : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(
                  color: isSelected ? opt.color : AppColors.border,
                  width: isSelected ? 1.5 : 0.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected ? opt.color : AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      opt.icon,
                      size: 18,
                      color: isSelected ? Colors.white : AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opt.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? opt.textColor
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          opt.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? opt.color : Colors.transparent,
                      border: Border.all(
                        color:
                        isSelected ? opt.color : AppColors.borderStrong,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check_rounded,
                        size: 12, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ConditionOption {
  final String value;
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final Color bg;
  final Color textColor;

  const _ConditionOption({
    required this.value,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.bg,
    required this.textColor,
  });
}