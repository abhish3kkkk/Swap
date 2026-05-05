import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification toggles
  bool _batteryAlerts = true;
  bool _chargeComplete = true;
  bool _tempWarnings = true;
  bool _weeklyReports = false;

  // Battery preferences
  bool _powerSaveMode = false;
  String _selectedThreshold = '20%';
  final List<String> _thresholdOptions = ['10%', '15%', '20%', '25%', '30%'];

  // Appearance
  bool _darkMode = false;

  void _showThresholdPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
                vertical: 8,
              ),
              child: Text(
                'Low Battery Threshold',
                style: AppTextStyles.screenTitleCompact.copyWith(fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding,
              ),
              child: Text(
                'Alert when battery falls below this level',
                style: AppTextStyles.sectionLabel,
              ),
            ),
            const SizedBox(height: 12),
            ..._thresholdOptions.map(
                  (option) => GestureDetector(
                onTap: () {
                  setState(() => _selectedThreshold = option);
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.pagePadding,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(option, style: AppTextStyles.cardTitle),
                      ),
                      if (_selectedThreshold == option)
                        Icon(
                          Icons.check_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.pagePadding),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.avatar),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ),
        ),
        title: Text('Settings', style: AppTextStyles.screenTitleCompact),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.pagePadding),
        children: [
          // ── Profile Card ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.pagePadding,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.avatar),
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('John Doe', style: AppTextStyles.cardTitle),
                        const SizedBox(height: 2),
                        Text(
                          'john.doe@email.com',
                          style: AppTextStyles.cardBody,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Notifications ─────────────────────────────────────────────────
          _SectionHeader(title: 'Notifications'),
          const SizedBox(height: 8),
          _SettingsGroup(
            children: [
              _ToggleTile(
                icon: Icons.battery_alert_outlined,
                label: 'Battery Low Alerts',
                subtitle: 'Alert when battery drops below threshold',
                value: _batteryAlerts,
                onChanged: (v) => setState(() => _batteryAlerts = v),
              ),
              _ItemDivider(),
              _ToggleTile(
                icon: Icons.battery_charging_full_outlined,
                label: 'Charge Complete',
                subtitle: 'Notify when battery is fully charged',
                value: _chargeComplete,
                onChanged: (v) => setState(() => _chargeComplete = v),
              ),
              _ItemDivider(),
              _ToggleTile(
                icon: Icons.thermostat_outlined,
                label: 'Temperature Warnings',
                subtitle: 'Alert on abnormal battery temperature',
                value: _tempWarnings,
                onChanged: (v) => setState(() => _tempWarnings = v),
              ),
              _ItemDivider(),
              _ToggleTile(
                icon: Icons.bar_chart_outlined,
                label: 'Weekly Reports',
                subtitle: 'Receive weekly battery health summary',
                value: _weeklyReports,
                onChanged: (v) => setState(() => _weeklyReports = v),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Battery ───────────────────────────────────────────────────────
          _SectionHeader(title: 'Battery'),
          const SizedBox(height: 8),
          _SettingsGroup(
            children: [
              _ToggleTile(
                icon: Icons.battery_saver_outlined,
                label: 'Power Save Mode',
                subtitle: 'Reduce background activity to save battery',
                value: _powerSaveMode,
                onChanged: (v) => setState(() => _powerSaveMode = v),
              ),
              _ItemDivider(),
              _NavTile(
                icon: Icons.tune_outlined,
                label: 'Low Battery Threshold',
                subtitle: 'Alert when battery falls below this level',
                trailing: Text(
                  _selectedThreshold,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                onTap: _showThresholdPicker,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Appearance ────────────────────────────────────────────────────
          _SectionHeader(title: 'Appearance'),
          const SizedBox(height: 8),
          _SettingsGroup(
            children: [
              _ToggleTile(
                icon: Icons.dark_mode_outlined,
                label: 'Dark Mode',
                subtitle: 'Switch to dark colour scheme',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── General ───────────────────────────────────────────────────────
          _SectionHeader(title: 'General'),
          const SizedBox(height: 8),
          _SettingsGroup(
            children: [
              _NavTile(
                icon: Icons.info_outline_rounded,
                label: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () {},
              ),
              _ItemDivider(),
              _NavTile(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                onTap: () {},
              ),
              _ItemDivider(),
              _NavTile(
                icon: Icons.description_outlined,
                label: 'Terms of Service',
                onTap: () {},
              ),
              _ItemDivider(),
              _NavTile(
                icon: Icons.help_outline_rounded,
                label: 'Help & Support',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Sign Out ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.pagePadding,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.error.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.error, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: AppDimens.pagePadding),
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.sectionLabel.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

// ── Settings Group ────────────────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(children: children),
      ),
    );
  }
}

// ── Item Divider ──────────────────────────────────────────────────────────────

class _ItemDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border,
      indent: 52 + AppDimens.pagePadding,
    );
  }
}

// ── Tile Icon ─────────────────────────────────────────────────────────────────

class _TileIcon extends StatelessWidget {
  final IconData icon;

  const _TileIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, color: AppColors.textSecondary, size: 18),
    );
  }
}

// ── Toggle Tile ───────────────────────────────────────────────────────────────

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.pagePadding,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TileIcon(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.cardTitle),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.cardBody),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

// ── Nav Tile ──────────────────────────────────────────────────────────────────

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.pagePadding,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _TileIcon(icon: icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.cardTitle),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppTextStyles.cardBody),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailing ??
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
          ],
        ),
      ),
    );
  }
}