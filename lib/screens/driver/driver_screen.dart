import 'package:flutter/material.dart';
import '../../data/driver_data.dart';
import '../../models/driver_model.dart';
import '../../config/app_theme.dart';
import '../../widgets/driver_widget/driver_list.dart';
import '../../widgets/driver_widget/driver_screen_header.dart';
import '../../widgets/driver_widget/driver_search_bar.dart';
import '../../widgets/driver_widget/driver_stats_row.dart';
import '../../widgets/driver_widget/filter_chip_row.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final List<DriverModel> _allDrivers = DriverData.mockDrivers;

  String _searchQuery = '';
  FilterOption _activeFilter = FilterOption.all;

  List<DriverModel> get _filteredDrivers {
    return _allDrivers.where((driver) {
      final matchesFilter = _activeFilter.matches(driver);
      final q = _searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          driver.name.toLowerCase().contains(q) ||
          driver.vehicleNumber.toLowerCase().contains(q);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _onDriverTap(DriverModel driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped: ${driver.name}'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onAddDriver() {
    // Navigate to add driver screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add new driver'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredDrivers;

    return Scaffold(

      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    DriverScreenHeader(totalCount: filtered.length),
                    const SizedBox(height: 16),

                    // Search bar
                    DriverSearchBar(
                      onChanged: (val) =>
                          setState(() => _searchQuery = val),
                    ),
                    const SizedBox(height: 12),

                    // Filter chips
                    FilterChipRow(
                      selected: _activeFilter,
                      onChanged: (f) =>
                          setState(() => _activeFilter = f),
                    ),
                    const SizedBox(height: 16),

                    // Stats
                    DriverStatsRow(drivers: _allDrivers),
                    const SizedBox(height: 20),

                    // List label
                    Text(
                      'DRIVER ROSTER',
                      style: AppTextStyles.sectionLabel,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Driver list
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverToBoxAdapter(
                child: DriverList(
                  drivers: filtered,
                  onDriverTap: _onDriverTap,
                ),
              ),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddDriver,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.fab),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }
}