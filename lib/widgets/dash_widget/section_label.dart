import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: AppTextStyles.sectionLabel);
  }
}