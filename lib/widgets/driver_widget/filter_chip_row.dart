import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';

enum FilterOption { all, active, idle, offline }

extension FilterOptionX on FilterOption {
  String get label {
    switch (this) {
      case FilterOption.all:
        return 'All';
      case FilterOption.active:
        return 'Active';
      case FilterOption.idle:
        return 'Idle';
      case FilterOption.offline:
        return 'Offline';
    }
  }

  bool matches(DriverModel driver) {
    switch (this) {
      case FilterOption.all:
        return true;
      case FilterOption.active:
        return driver.status == DriverStatus.active;
      case FilterOption.idle:
        return driver.status == DriverStatus.idle;
      case FilterOption.offline:
        return driver.status == DriverStatus.offline;
    }
  }
}

class FilterChipRow extends StatelessWidget {
  final FilterOption selected;
  final ValueChanged<FilterOption> onChanged;

  const FilterChipRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: FilterOption.values.map((option) {
          final isSelected = option == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  option.label,
                  style: AppTextStyles.chipLabel.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}