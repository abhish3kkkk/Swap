import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';

class AddBatteryTab extends StatefulWidget {
  final Function(BatteryModel battery) onAdd;

  const AddBatteryTab({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddBatteryTab> createState() =>
      _AddBatteryTabState();
}

class _AddBatteryTabState
    extends State<AddBatteryTab> {
  final _formKey = GlobalKey<FormState>();

  final serialController = TextEditingController();
  final mahController = TextEditingController();
  final typeController = TextEditingController();
  final statusController = TextEditingController();

  bool isLoading = false;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      print("Battery Add Response : ${ serialController.text.trim()}");
      print("Battery Add Response : ${mahController.text.trim()}");
      print("Battery Add Response : ${typeController.text.trim()}");

      final response =
      await BatteryApiService.addBattery(
        serialNo: serialController.text.trim(),
        capacityMah: mahController.text.trim(),
        type: typeController.text.trim(),
      );

      print("Battery Add Response : $response");

      if (response["status"] == true) {
        final battery = BatteryModel(
          id: response["battery_id"].toString(),
          serialNumber: serialController.text.trim(),
          capacityMah:
          int.parse(mahController.text.trim()),
          healthPercent: 100,
          type: typeController.text.trim(),
        );

        widget.onAdd(battery);

        serialController.clear();
        mahController.clear();
        typeController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Battery added successfully ⚡",
              ),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.all(AppDimens.pagePadding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: serialController,
              decoration: const InputDecoration(
                hintText: "Battery Serial Number",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: mahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Battery Capacity",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: typeController,
              decoration: const InputDecoration(
                hintText: "Battery Type",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : submit,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Add Battery"),
            )
          ],
        ),
      ),
    );
  }
}