// import 'package:flutter/material.dart';
// import '../../config/routes.dart';
// import '../../widgets/dash_widget/dash_card.dart';
//
// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Battery Management",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           children: [
//             DashboardCard(
//               title: "Driver",
//               icon: Icons.people,
//               color: Colors.blue,
//               onTap: () => Navigator.pushNamed(context, AppRoutes.driver),
//             ),
//             DashboardCard(
//               title: "Return Battery",
//               icon: Icons.battery_charging_full,
//               color: Colors.green,
//               onTap: () => Navigator.pushNamed(context, AppRoutes.returnBattery),
//             ),
//             DashboardCard(
//               title: "Issue Battery",
//               icon: Icons.swap_horiz,
//               color: Colors.orange,
//               onTap: () => Navigator.pushNamed(context, AppRoutes.issueBattery),
//             ),
//             DashboardCard(
//               title: "Transactions",
//               icon: Icons.receipt_long,
//               color: Colors.purple,
//               onTap: (){},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../config/routes.dart';
import '../../config/app_theme.dart';
import '../../models/action_item.dart';
import '../../models/activity_item.dart';
import '../../widgets/dash_widget/dashboard_app_bar.dart';
import '../../widgets/dash_widget/dashboard_status_bar.dart';
import '../../widgets/dash_widget/battery_overview_card.dart';
import '../../widgets/dash_widget/section_label.dart';
import '../../widgets/dash_widget/actions_grid.dart';
import '../../widgets/dash_widget/activity_feed.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<ActionItem> _actions = [
    ActionItem(
      title: "Driver",
      subtitle: "Manage drivers",
      icon: Icons.people_alt_rounded,
      color: Color(0xFF185FA5),
      bgColor: Color(0xFFE6F1FB),
      route: AppRoutes.driver,
    ),
    ActionItem(
      title: "Return Battery",
      subtitle: "Log returns",
      icon: Icons.battery_charging_full_rounded,
      color: AppColors.activeText,
      bgColor: AppColors.activeBg,
      route: AppRoutes.returnBattery,
    ),
    ActionItem(
      title: "Issue Battery",
      subtitle: "Assign units",
      icon: Icons.swap_horiz_rounded,
      color: AppColors.idleText,
      bgColor: AppColors.idleBg,
      route: AppRoutes.issueBattery,
    ),
    ActionItem(
      title: "Transactions",
      subtitle: "View history",
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF534AB7),
      bgColor: Color(0xFFEEEDFE),
      route: AppRoutes.transaction,
    ),
  ];

  static const List<ActivityItem> _recentActivity = [
    ActivityItem(
      icon: Icons.battery_charging_full_rounded,
      iconColor: AppColors.active,
      title: "Battery #B-042 returned",
      subtitle: "Driver: Ramesh Kumar",
      time: "10 min ago",
    ),
    ActivityItem(
      icon: Icons.swap_horiz_rounded,
      iconColor: AppColors.idle,
      title: "Battery #B-017 issued",
      subtitle: "Driver: Priya Sharma",
      time: "32 min ago",
    ),
    ActivityItem(
      icon: Icons.warning_amber_rounded,
      iconColor: AppColors.error,
      title: "Low charge alert",
      subtitle: "Battery #B-009 — 12% remaining",
      time: "1 hr ago",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.swapBattery),
        backgroundColor: AppColors.primary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 2. Add the Bottom App Bar with a notch for the button
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.white,
        height: size.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: 'Add Driver',
              icon: Icon(Icons.person_add,size: size.width*0.08,color: AppColors.active,),
              onPressed: (){},
            ),
            SizedBox(width: size.width * 0.4,),
            IconButton(
              tooltip: 'Add Battery',
              icon: Icon(Icons.battery_saver_rounded,size: size.width*0.08,color: AppColors.active,),
              onPressed: (){},
            ),
          ],
        ),
      ),

      body: CustomScrollView(
        slivers: [
          const DashboardAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimens.sectionGap),
                  const DashboardStatusBar(),
                  const SizedBox(height: AppDimens.sectionGap),
                  const BatteryOverviewCard(),
                  const SizedBox(height: AppDimens.sectionGap),
                  const SectionLabel("Quick Actions"),
                  const SizedBox(height: AppDimens.itemGap),
                  ActionsGrid(items: _actions),
                  const SizedBox(height: AppDimens.sectionGap),
                  const SectionLabel("Recent Activity"),
                  const SizedBox(height: AppDimens.itemGap),
                  ActivityFeed(activities: _recentActivity),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}