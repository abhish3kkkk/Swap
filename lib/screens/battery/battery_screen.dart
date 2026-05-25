import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/app_theme.dart';
import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';
import 'add_battery_tab.dart';
import 'battery_list_tab.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<BatteryModel> batteries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchBatteries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── API calls ────────────────────────────────────────────────────────────────

  Future<void> fetchBatteries() async {
    try {
      final response = await BatteryApiService.getBatteries();
      setState(() => batteries = response);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() => isLoading = false);
  }

  void addBattery(BatteryModel battery) {
    setState(() {
      batteries.insert(0, battery);
      _tabController.animateTo(1);
    });
  }

  void updateBattery(BatteryModel updatedBattery) {
    final index =
    batteries.indexWhere((b) => b.id == updatedBattery.id);
    if (index != -1) {
      setState(() => batteries[index] = updatedBattery);
    }
  }

  void deleteBattery(String id) {
    setState(() => batteries.removeWhere((b) => b.id == id));
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Custom header ──────────────────────────────────────────
              _BatteryScreenHeader(
                batteryCount: batteries.length,
                tabController: _tabController,
              ),

              // ── Body ───────────────────────────────────────────────────
              Expanded(
                child: isLoading
                    ? const _LoadingView()
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    AddBatteryTab(onAdd: addBattery),
                    BatteryListTab(
                      batteries: batteries,
                      onDelete: deleteBattery,
                      onUpdate: updateBattery,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _BatteryScreenHeader extends StatelessWidget {
  final int batteryCount;
  final TabController tabController;

  const _BatteryScreenHeader({
    required this.batteryCount,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        16,
        AppDimens.pagePadding,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title row ────────────────────────────────────────────────
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius:
                    BorderRadius.circular(AppRadius.avatar),
                    border: Border.all(
                        color: AppColors.border, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Battery Management",
                      style: AppTextStyles.screenTitleCompact,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$batteryCount ${batteryCount == 1 ? 'battery' : 'batteries'} in fleet",
                      style: AppTextStyles.cardBody,
                    ),
                  ],
                ),
              ),

              // Count badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius:
                  BorderRadius.circular(AppRadius.chip),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: AppColors.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$batteryCount",
                      style: AppTextStyles.statusPill.copyWith(
                        color: AppColors.activeText,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Tab bar ──────────────────────────────────────────────────
          _AppTabBar(controller: tabController),
        ],
      ),
    );
  }
}

// ── Custom tab bar ────────────────────────────────────────────────────────────

class _AppTabBar extends StatelessWidget {
  final TabController controller;

  const _AppTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelStyle: AppTextStyles.cardTitle,
      unselectedLabelStyle: AppTextStyles.cardTitle.copyWith(
        fontWeight: FontWeight.w500,
      ),
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textTertiary,
      indicatorColor: AppColors.primary,
      indicatorWeight: 2.5,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: AppColors.border,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      tabs: const [
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_circle_outline_rounded, size: 16),
              SizedBox(width: 6),
              Text("Add Battery"),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.list_alt_rounded, size: 16),
              SizedBox(width: 6),
              Text("Battery List"),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Loading view ──────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Loading batteries...",
            style: AppTextStyles.cardBody,
          ),
        ],
      ),
    );
  }
}