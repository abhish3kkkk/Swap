import 'package:flutter/material.dart';
import 'package:swap/config/routes.dart';
import '../../config/app_theme.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.border,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        //collapseMode: CollapseMode.fade,
        background: Container(
          color: AppColors.surface,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimens.pagePadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: Text(
                      "Welcome,",
                      style: AppTextStyles.sectionLabel,
                    ),
                  ),
                  Row(
                    children: [
                      _AppBarIconButton(icon: Icons.notifications_outlined,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.notification,
                        ),
                      ),
                      const SizedBox(width: 10),
                      _AppBarIconButton(icon: Icons.settings_outlined,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.setting,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        title: Text(
          "Battery Management",
          style: AppTextStyles.screenTitleCompact.copyWith(fontSize: 16),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(
          left: AppDimens.pagePadding,
          bottom: 14,
        ),
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;

  const _AppBarIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.avatar),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
      onTap: onTap,
    );
  }
}