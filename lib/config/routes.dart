import 'package:flutter/material.dart';
import 'package:swap/screens/notification/notification_screen.dart';
import 'package:swap/screens/setting/setting_screen.dart';
import 'package:swap/screens/transaction/transaction_screen.dart';
import '../screens/dash/dash_screen.dart';
import '../screens/driver/driver_screen.dart';
import '../screens/issue/issue_screen.dart';
import '../screens/return/return_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/swap/swap_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String driver = '/driver';
  static const String issueBattery = '/issue-battery';
  static const String returnBattery = '/return-battery';
  static const String swapBattery = '/swap-battery';
  static const String notification = '/notification';
  static const String setting = '/setting';
  static const String transaction = '/transaction';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      dashboard: (context) => const DashboardScreen(),
      driver: (context) => const DriverScreen(),
      issueBattery: (context) => const IssueScreen(),
      returnBattery: (context) => const ReturnScreen(),
      swapBattery: (context) => const SwapScreen(),
      notification: (context) => const NotificationScreen(),
      setting : (context) => const SettingsScreen(),
      transaction : (context) => const TransactionScreen(),
    };
  }
}