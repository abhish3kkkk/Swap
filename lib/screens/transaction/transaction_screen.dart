import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  _StatusFilter _activeFilter = _StatusFilter.all;

  final List<_SwapTransaction> _all = [
    _SwapTransaction(
      id: 'SWP-0012',
      driverName: 'Rahul Sharma',
      oldBatteryId: 'BAT-4821',
      newBatteryId: 'BAT-9103',
      dateTime: DateTime(2026, 4, 25, 10, 32),
      status: _SwapStatus.completed,
    ),
    _SwapTransaction(
      id: 'SWP-0011',
      driverName: 'Priya Mehta',
      oldBatteryId: 'BAT-3374',
      newBatteryId: 'BAT-6612',
      dateTime: DateTime(2026, 4, 25, 9, 15),
      status: _SwapStatus.pending,
    ),
    _SwapTransaction(
      id: 'SWP-0010',
      driverName: 'Amit Verma',
      oldBatteryId: 'BAT-2291',
      newBatteryId: 'BAT-5540',
      dateTime: DateTime(2026, 4, 24, 17, 48),
      status: _SwapStatus.completed,
    ),
    _SwapTransaction(
      id: 'SWP-0009',
      driverName: 'Sneha Patel',
      oldBatteryId: 'BAT-5503',
      newBatteryId: 'BAT-8820',
      dateTime: DateTime(2026, 4, 24, 14, 20),
      status: _SwapStatus.failed,
    ),
    _SwapTransaction(
      id: 'SWP-0008',
      driverName: 'Karan Singh',
      oldBatteryId: 'BAT-1187',
      newBatteryId: 'BAT-3390',
      dateTime: DateTime(2026, 4, 24, 11, 05),
      status: _SwapStatus.completed,
    ),
    _SwapTransaction(
      id: 'SWP-0007',
      driverName: 'Deepa Nair',
      oldBatteryId: 'BAT-6642',
      newBatteryId: 'BAT-1175',
      dateTime: DateTime(2026, 4, 23, 16, 33),
      status: _SwapStatus.completed,
    ),
    _SwapTransaction(
      id: 'SWP-0006',
      driverName: 'Rahul Sharma',
      oldBatteryId: 'BAT-0934',
      newBatteryId: 'BAT-7701',
      dateTime: DateTime(2026, 4, 23, 10, 11),
      status: _SwapStatus.pending,
    ),
    _SwapTransaction(
      id: 'SWP-0005',
      driverName: 'Vijay Kumar',
      oldBatteryId: 'BAT-7723',
      newBatteryId: 'BAT-2248',
      dateTime: DateTime(2026, 4, 22, 15, 50),
      status: _SwapStatus.completed,
    ),
    _SwapTransaction(
      id: 'SWP-0004',
      driverName: 'Meena Iyer',
      oldBatteryId: 'BAT-3318',
      newBatteryId: 'BAT-9987',
      dateTime: DateTime(2026, 4, 22, 9, 40),
      status: _SwapStatus.failed,
    ),
    _SwapTransaction(
      id: 'SWP-0003',
      driverName: 'Arjun Das',
      oldBatteryId: 'BAT-8810',
      newBatteryId: 'BAT-4456',
      dateTime: DateTime(2026, 4, 21, 13, 25),
      status: _SwapStatus.completed,
    ),
  ];

  List<_SwapTransaction> get _filtered {
    if (_activeFilter == _StatusFilter.all) return _all;
    return _all.where((t) => t.status.filter == _activeFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

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
            Text('Swap Transactions', style: AppTextStyles.screenTitleCompact),
            Text(
              '${filtered.length} records',
              style: AppTextStyles.sectionLabel.copyWith(
                fontSize: 11,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ── Filter bar ────────────────────────────────────────────────────
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.fromLTRB(
              AppDimens.pagePadding,
              0,
              AppDimens.pagePadding,
              12,
            ),
            child: Row(
              children: _StatusFilter.values
                  .map(
                    (f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _FilterChip(
                    label: f.label,
                    color: f.color,
                    isActive: _activeFilter == f,
                    onTap: () => setState(() => _activeFilter = f),
                  ),
                ),
              )
                  .toList(),
            ),
          ),

          // ── Summary row ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.pagePadding,
              vertical: 14,
            ),
            child: Row(
              children: [
                _SummaryPill(
                  label: 'Completed',
                  count: _filtered
                      .where((t) => t.status == _SwapStatus.completed)
                      .length,
                  color: AppColors.success,
                ),
                const SizedBox(width: 8),
                _SummaryPill(
                  label: 'Pending',
                  count: _filtered
                      .where((t) => t.status == _SwapStatus.pending)
                      .length,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 8),
                _SummaryPill(
                  label: 'Failed',
                  count: _filtered
                      .where((t) => t.status == _SwapStatus.failed)
                      .length,
                  color: AppColors.error,
                ),
              ],
            ),
          ),

          // ── List ──────────────────────────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? _EmptyState(filter: _activeFilter)
                : ListView.separated(
              padding: const EdgeInsets.only(
                left: AppDimens.pagePadding,
                right: AppDimens.pagePadding,
                bottom: AppDimens.pagePadding,
              ),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) =>
                  _SwapCard(transaction: filtered[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Swap Card ─────────────────────────────────────────────────────────────────

class _SwapCard extends StatelessWidget {
  final _SwapTransaction transaction;

  const _SwapCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final status = transaction.status;

    return Container(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: icon + title + status pill ────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Battery Swap', style: AppTextStyles.cardTitle),
                    const SizedBox(height: 2),
                    Text(transaction.id, style: AppTextStyles.vehicleTag),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: status.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.avatar),
                ),
                child: Text(
                  status.label,
                  style: AppTextStyles.statusPill.copyWith(
                    color: status.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Divider(height: 1, thickness: 1, color: AppColors.border),
          const SizedBox(height: 12),

          // ── Battery swap row ───────────────────────────────────────────
          Row(
            children: [
              // Old battery
              Expanded(
                child: _BatteryIdBox(
                  label: 'Returned',
                  batteryId: transaction.oldBatteryId,
                  color: AppColors.error,
                  icon: Icons.battery_0_bar_outlined,
                ),
              ),
              // Arrow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.textTertiary,
                  size: 16,
                ),
              ),
              // New battery
              Expanded(
                child: _BatteryIdBox(
                  label: 'Issued',
                  batteryId: transaction.newBatteryId,
                  color: AppColors.success,
                  icon: Icons.battery_full_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(height: 1, thickness: 1, color: AppColors.border),
          const SizedBox(height: 12),

          // ── Driver + time row ──────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _MetaItem(
                  icon: Icons.person_outline_rounded,
                  value: transaction.driverName,
                ),
              ),
              _MetaItem(
                icon: Icons.access_time_rounded,
                value: _formatDateTime(transaction.dateTime),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final isToday =
        dt.day == now.day && dt.month == now.month && dt.year == now.year;
    final prefix = isToday ? 'Today' : '${dt.day}/${dt.month}';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$prefix, $h:$m';
  }
}

// ── Battery ID Box ────────────────────────────────────────────────────────────

class _BatteryIdBox extends StatelessWidget {
  final String label;
  final String batteryId;
  final Color color;
  final IconData icon;

  const _BatteryIdBox({
    required this.label,
    required this.batteryId,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: AppTextStyles.statLabel.copyWith(
                    color: color,
                    fontSize: 9,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  batteryId,
                  style: AppTextStyles.vehicleTag.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Meta Item ─────────────────────────────────────────────────────────────────

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _MetaItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            value,
            style: AppTextStyles.batteryMeta,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ── Filter Chip ───────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.avatar),
          border: Border.all(color: isActive ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: AppTextStyles.chipLabel.copyWith(
            fontSize: 13,
            color: isActive ? color : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ── Summary Pill ──────────────────────────────────────────────────────────────

class _SummaryPill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _SummaryPill({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.avatar),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$count $label',
            style: AppTextStyles.statLabel.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final _StatusFilter filter;

  const _EmptyState({required this.filter});

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
              Icons.swap_horiz_rounded,
              color: AppColors.textSecondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text('No Transactions', style: AppTextStyles.cardTitle),
          const SizedBox(height: 6),
          Text(
            'No ${filter.label.toLowerCase()} swap records found',
            style: AppTextStyles.sectionLabel,
          ),
        ],
      ),
    );
  }
}

// ── Models ────────────────────────────────────────────────────────────────────

enum _StatusFilter { all, completed, pending, failed }

extension _StatusFilterX on _StatusFilter {
  String get label {
    switch (this) {
      case _StatusFilter.all:
        return 'All';
      case _StatusFilter.completed:
        return 'Completed';
      case _StatusFilter.pending:
        return 'Pending';
      case _StatusFilter.failed:
        return 'Failed';
    }
  }

  Color get color {
    switch (this) {
      case _StatusFilter.all:
        return AppColors.primary;
      case _StatusFilter.completed:
        return AppColors.success;
      case _StatusFilter.pending:
        return AppColors.warning;
      case _StatusFilter.failed:
        return AppColors.error;
    }
  }
}

enum _SwapStatus { completed, pending, failed }

extension _SwapStatusX on _SwapStatus {
  String get label {
    switch (this) {
      case _SwapStatus.completed:
        return 'Completed';
      case _SwapStatus.pending:
        return 'Pending';
      case _SwapStatus.failed:
        return 'Failed';
    }
  }

  Color get color {
    switch (this) {
      case _SwapStatus.completed:
        return AppColors.success;
      case _SwapStatus.pending:
        return AppColors.warning;
      case _SwapStatus.failed:
        return AppColors.error;
    }
  }

  _StatusFilter get filter {
    switch (this) {
      case _SwapStatus.completed:
        return _StatusFilter.completed;
      case _SwapStatus.pending:
        return _StatusFilter.pending;
      case _SwapStatus.failed:
        return _StatusFilter.failed;
    }
  }
}

class _SwapTransaction {
  final String id;
  final String driverName;
  final String oldBatteryId;
  final String newBatteryId;
  final DateTime dateTime;
  final _SwapStatus status;

  const _SwapTransaction({
    required this.id,
    required this.driverName,
    required this.oldBatteryId,
    required this.newBatteryId,
    required this.dateTime,
    required this.status,
  });
}