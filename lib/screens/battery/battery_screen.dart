import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> batteries = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void addBattery(Map<String, String> data) {
    setState(() {
      batteries.add(data);
      _tabController.animateTo(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Battery Management'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: const [
            Tab(text: "Add Battery"),
            Tab(text: "Battery List"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AddBatteryTab(onAdd: addBattery),
          BatteryListTab(batteries: batteries),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🧾 ADD BATTERY TAB
////////////////////////////////////////////////////////////

class AddBatteryTab extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const AddBatteryTab({super.key, required this.onAdd});

  @override
  State<AddBatteryTab> createState() => _AddBatteryTabState();
}

class _AddBatteryTabState extends State<AddBatteryTab> {
  final _formKey = GlobalKey<FormState>();

  final serialController = TextEditingController();
  final mahController = TextEditingController();
  final healthController = TextEditingController();

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onAdd({
      "serial": serialController.text,
      "mah": mahController.text,
      "health": healthController.text,
    });

    serialController.clear();
    mahController.clear();
    healthController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input("Battery Serial Number", serialController),
              const SizedBox(height: 16),
              _input("Battery mAh", mahController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _input("Battery Health (%)", healthController,
                  keyboardType: TextInputType.number),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: submit,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius:
                    BorderRadius.circular(AppRadius.button),
                  ),
                  child: Center(
                    child: Text(
                      "Add Battery",
                      style: AppTextStyles.buttonLabel,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (v) =>
          v == null || v.isEmpty ? "Required" : null,
          style: AppTextStyles.inputText,
          decoration: InputDecoration(
            hintText: "Enter $label",
            hintStyle: AppTextStyles.inputText.copyWith(
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(AppRadius.input),
              borderSide:
              BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
/// 📋 BATTERY LIST TAB
////////////////////////////////////////////////////////////

class BatteryListTab extends StatelessWidget {
  final List<Map<String, String>> batteries;

  const BatteryListTab({super.key, required this.batteries});

  @override
  Widget build(BuildContext context) {
    if (batteries.isEmpty) {
      return Center(
        child: Text(
          "No batteries added yet ⚡",
          style: AppTextStyles.cardBody,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      itemCount: batteries.length,
      itemBuilder: (context, index) {
        final battery = batteries[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius:
            BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Serial: ${battery['serial']}",
                style: AppTextStyles.cardTitle,
              ),
              const SizedBox(height: 6),
              Text(
                "Capacity: ${battery['mah']} mAh",
                style: AppTextStyles.cardBody,
              ),
              const SizedBox(height: 4),
              Text(
                "Health: ${battery['health']}%",
                style: AppTextStyles.cardBody.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}