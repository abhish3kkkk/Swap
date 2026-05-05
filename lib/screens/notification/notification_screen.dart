import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: '1',
      title: 'Battery Low',
      message: 'Battery level dropped below 20%. Please charge your device.',
      time: '2 min ago',
      icon: Icons.battery_alert_outlined,
      type: _NotificationType.warning,
      isRead: false,
    ),
    _NotificationItem(
      id: '2',
      title: 'Charge Complete',
      message: 'Battery is fully charged at 100%. You can unplug safely.',
      time: '1 hr ago',
      icon: Icons.battery_charging_full_outlined,
      type: _NotificationType.success,
      isRead: false,
    ),
    _NotificationItem(
      id: '3',
      title: 'Optimisation Tip',
      message: 'Enable power saving mode to extend battery life by up to 30%.',
      time: '3 hr ago',
      icon: Icons.tips_and_updates_outlined,
      type: _NotificationType.info,
      isRead: true,
    ),
    _NotificationItem(
      id: '4',
      title: 'Temperature Warning',
      message: 'Battery temperature is higher than normal. Avoid heavy usage.',
      time: 'Yesterday',
      icon: Icons.thermostat_outlined,
      type: _NotificationType.warning,
      isRead: true,
    ),
    _NotificationItem(
      id: '5',
      title: 'Health Report Ready',
      message: 'Your weekly battery health report is now available to view.',
      time: 'Yesterday',
      icon: Icons.health_and_safety_outlined,
      type: _NotificationType.info,
      isRead: true,
    ),
    _NotificationItem(
      id: '6',
      title: 'Charge Complete',
      message: 'Battery charged to 100%. Unplugged automatically.',
      time: '2 days ago',
      icon: Icons.battery_charging_full_outlined,
      type: _NotificationType.success,
      isRead: true,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markRead(String id) {
    setState(() {
      _notifications.firstWhere((n) => n.id == id).isRead = true;
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: AppTextStyles.screenTitleCompact),
            if (_unreadCount > 0)
              Text(
                '$_unreadCount unread',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: AppColors.primary,
                  fontSize: 11,
                ),
              ),
          ],
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(
                'Mark all read',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: _notifications.isEmpty
          ? _EmptyNotifications()
          : ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.pagePadding,
        ),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return _NotificationTile(
            item: item,
            onTap: () => _markRead(item.id),
            onDismiss: () => _deleteNotification(item.id),
          );
        },
      ),
    );
  }
}

// ── Notification Tile ────────────────────────────────────────────────────────

class _NotificationTile extends StatelessWidget {
  final _NotificationItem item;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationTile({
    required this.item,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppDimens.pagePadding),
        color: AppColors.error.withOpacity(0.1),
        child: Icon(Icons.delete_outline_rounded, color: AppColors.error),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: item.isRead
              ? Colors.transparent
              : AppColors.primary.withOpacity(0.04),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.pagePadding,
            vertical: 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon badge
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: item.type.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: Icon(item.icon, color: item.type.color, size: 20),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: AppTextStyles.cardTitle.copyWith(
                              fontWeight: item.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.time,
                          style: AppTextStyles.sectionLabel.copyWith(
                            fontSize: 11,
                          ),
                        ),
                        if (!item.isRead) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.message,
                      style: AppTextStyles.sectionLabel.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
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

// ── Empty State ──────────────────────────────────────────────────────────────

class _EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.avatar),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              color: AppColors.textSecondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text('No Notifications', style: AppTextStyles.cardTitle),
          const SizedBox(height: 6),
          Text(
            'You\'re all caught up!',
            style: AppTextStyles.sectionLabel,
          ),
        ],
      ),
    );
  }
}

// ── Models ───────────────────────────────────────────────────────────────────

enum _NotificationType { warning, success, info }

extension _NotificationTypeX on _NotificationType {
  Color get color {
    switch (this) {
      case _NotificationType.warning:
        return AppColors.warning;
      case _NotificationType.success:
        return AppColors.success;
      case _NotificationType.info:
        return AppColors.primary;
    }
  }
}

class _NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final _NotificationType type;
  bool isRead;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.type,
    required this.isRead,
  });
}