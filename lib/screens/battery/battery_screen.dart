// // import 'package:flutter/material.dart';
// // import '../../config/app_theme.dart';
// //
// // class BatteryScreen extends StatefulWidget {
// //   const BatteryScreen({super.key});
// //
// //   @override
// //   State<BatteryScreen> createState() => _BatteryScreenState();
// // }
// //
// // class _BatteryScreenState extends State<BatteryScreen>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //
// //   final List<Map<String, String>> batteries = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //   }
// //
// //   void addBattery(Map<String, String> data) {
// //     setState(() {
// //       batteries.add(data);
// //       _tabController.animateTo(1);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.background,
// //       appBar: AppBar(
// //         title: const Text('Battery Management'),
// //         backgroundColor: AppColors.surface,
// //         elevation: 0,
// //         bottom: TabBar(
// //           controller: _tabController,
// //           indicatorColor: AppColors.primary,
// //           labelColor: AppColors.primary,
// //           unselectedLabelColor: AppColors.textSecondary,
// //           tabs: const [
// //             Tab(text: "Add Battery"),
// //             Tab(text: "Battery List"),
// //           ],
// //         ),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: [
// //           AddBatteryTab(onAdd: addBattery),
// //           BatteryListTab(batteries: batteries),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // ////////////////////////////////////////////////////////////
// // /// 🧾 ADD BATTERY TAB
// // ////////////////////////////////////////////////////////////
// //
// // class AddBatteryTab extends StatefulWidget {
// //   final Function(Map<String, String>) onAdd;
// //
// //   const AddBatteryTab({super.key, required this.onAdd});
// //
// //   @override
// //   State<AddBatteryTab> createState() => _AddBatteryTabState();
// // }
// //
// // class _AddBatteryTabState extends State<AddBatteryTab> {
// //   final _formKey = GlobalKey<FormState>();
// //
// //   final serialController = TextEditingController();
// //   final mahController = TextEditingController();
// //   final healthController = TextEditingController();
// //
// //   void submit() {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     widget.onAdd({
// //       "serial": serialController.text,
// //       "mah": mahController.text,
// //       "health": healthController.text,
// //     });
// //
// //     serialController.clear();
// //     mahController.clear();
// //     healthController.clear();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(AppDimens.pagePadding),
// //       child: Container(
// //         padding: const EdgeInsets.all(20),
// //         decoration: BoxDecoration(
// //           color: AppColors.surface,
// //           borderRadius: BorderRadius.circular(AppRadius.card),
// //           border: Border.all(color: AppColors.border),
// //         ),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               _input("Battery Serial Number", serialController),
// //               const SizedBox(height: 16),
// //               _input("Battery mAh", mahController,
// //                   keyboardType: TextInputType.number),
// //               const SizedBox(height: 16),
// //               _input("Battery Health (%)", healthController,
// //                   keyboardType: TextInputType.number),
// //
// //               const SizedBox(height: 24),
// //
// //               GestureDetector(
// //                 onTap: submit,
// //                 child: Container(
// //                   height: 50,
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     color: AppColors.primary,
// //                     borderRadius:
// //                     BorderRadius.circular(AppRadius.button),
// //                   ),
// //                   child: Center(
// //                     child: Text(
// //                       "Add Battery",
// //                       style: AppTextStyles.buttonLabel,
// //                     ),
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _input(String label, TextEditingController controller,
// //       {TextInputType? keyboardType}) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label, style: AppTextStyles.fieldLabel),
// //         const SizedBox(height: 6),
// //         TextFormField(
// //           controller: controller,
// //           keyboardType: keyboardType,
// //           validator: (v) =>
// //           v == null || v.isEmpty ? "Required" : null,
// //           style: AppTextStyles.inputText,
// //           decoration: InputDecoration(
// //             hintText: "Enter $label",
// //             hintStyle: AppTextStyles.inputText.copyWith(
// //               color: AppColors.textHint,
// //             ),
// //             filled: true,
// //             fillColor: AppColors.background,
// //             contentPadding:
// //             const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //             border: OutlineInputBorder(
// //               borderRadius:
// //               BorderRadius.circular(AppRadius.input),
// //               borderSide: BorderSide(color: AppColors.border),
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius:
// //               BorderRadius.circular(AppRadius.input),
// //               borderSide: BorderSide(color: AppColors.border),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius:
// //               BorderRadius.circular(AppRadius.input),
// //               borderSide:
// //               BorderSide(color: AppColors.primary),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // ////////////////////////////////////////////////////////////
// // /// 📋 BATTERY LIST TAB
// // ////////////////////////////////////////////////////////////
// //
// // class BatteryListTab extends StatelessWidget {
// //   final List<Map<String, String>> batteries;
// //
// //   const BatteryListTab({super.key, required this.batteries});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (batteries.isEmpty) {
// //       return Center(
// //         child: Text(
// //           "No batteries added yet ⚡",
// //           style: AppTextStyles.cardBody,
// //         ),
// //       );
// //     }
// //
// //     return ListView.builder(
// //       padding: const EdgeInsets.all(AppDimens.pagePadding),
// //       itemCount: batteries.length,
// //       itemBuilder: (context, index) {
// //         final battery = batteries[index];
// //
// //         return Container(
// //           margin: const EdgeInsets.only(bottom: 12),
// //           padding: const EdgeInsets.all(16),
// //           decoration: BoxDecoration(
// //             color: AppColors.surface,
// //             borderRadius:
// //             BorderRadius.circular(AppRadius.card),
// //             border: Border.all(color: AppColors.border),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Serial: ${battery['serial']}",
// //                 style: AppTextStyles.cardTitle,
// //               ),
// //               const SizedBox(height: 6),
// //               Text(
// //                 "Capacity: ${battery['mah']} mAh",
// //                 style: AppTextStyles.cardBody,
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 "Health: ${battery['health']}%",
// //                 style: AppTextStyles.cardBody.copyWith(
// //                   color: AppColors.success,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// import '../../config/app_theme.dart';
// import '../../models/battery_model.dart';
// import '../../service/battery_api_service/battery_api_service.dart';
// import 'add_battery_tab.dart';
// import 'battery_list_tab.dart';
//
// class BatteryScreen extends StatefulWidget {
//   const BatteryScreen({super.key});
//
//   @override
//   State<BatteryScreen> createState() => _BatteryScreenState();
// }
//
// class _BatteryScreenState extends State<BatteryScreen>
//     with SingleTickerProviderStateMixin {
//
//   late TabController _tabController;
//
//   List<BatteryModel> batteries = [];
//
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(
//       length: 2,
//       vsync: this,
//     );
//
//     fetchBatteries();
//   }
//
//   ////////////////////////////////////////////////////////////
//   /// FETCH BATTERIES
//   ////////////////////////////////////////////////////////////
//
//   Future<void> fetchBatteries() async {
//     try {
//       final response =
//       await BatteryApiService.getBatteries();
//
//       setState(() {
//         batteries = response;
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   ////////////////////////////////////////////////////////////
//   /// ADD BATTERY
//   ////////////////////////////////////////////////////////////
//
//   void addBattery(BatteryModel battery) {
//     setState(() {
//       batteries.insert(0, battery);
//
//       _tabController.animateTo(1);
//     });
//   }
//
//   ////////////////////////////////////////////////////////////
//   /// UPDATE BATTERY
//   ////////////////////////////////////////////////////////////
//
//   void updateBattery(BatteryModel updatedBattery) {
//     final index = batteries.indexWhere(
//           (battery) => battery.id == updatedBattery.id,
//     );
//
//     if (index != -1) {
//       setState(() {
//         batteries[index] = updatedBattery;
//       });
//     }
//   }
//
//   ////////////////////////////////////////////////////////////
//   /// DELETE BATTERY
//   ////////////////////////////////////////////////////////////
//
//   void deleteBattery(String id) {
//     setState(() {
//       batteries.removeWhere(
//             (battery) => battery.id == id,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Battery Management"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: "Add Battery"),
//             Tab(text: "Battery List"),
//           ],
//         ),
//       ),
//
//       body: isLoading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : TabBarView(
//         controller: _tabController,
//         children: [
//           AddBatteryTab(
//             onAdd: addBattery,
//           ),
//
//           BatteryListTab(
//             batteries: batteries,
//             onDelete: deleteBattery,
//             onUpdate: updateBattery,
//           ),
//         ],
//       ),
//     );
//   }
// }
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