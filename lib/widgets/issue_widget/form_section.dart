import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class FormSection extends StatelessWidget {
  final String label;
  final Widget child;

  const FormSection({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.sectionLabel),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}