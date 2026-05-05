import 'package:flutter/material.dart';

class ActivityItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}