import 'package:flutter/material.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';

class DriverAvatar extends StatelessWidget {
  final DriverModel driver;
  final double size;

  const DriverAvatar({
    super.key,
    required this.driver,
    this.size = 46,
  });

  String get _initials {
    final parts = driver.name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  List<Color> get _colors {
    final palette = AppColors.avatarPalette;
    return palette[driver.id % palette.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _colors[0],
        borderRadius: BorderRadius.circular(AppRadius.avatar),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontFamily: 'Syne',
          fontSize: size * 0.35,
          fontWeight: FontWeight.w700,
          color: _colors[1],
        ),
      ),
    );
  }
}