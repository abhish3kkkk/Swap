import 'package:flutter/material.dart';

import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';

Future<void> showUpdateBatteryDialog({
  required BuildContext context,
  required BatteryModel battery,
  required Function(BatteryModel battery) onUpdate,
}) async {
  final serialController =
  TextEditingController(
    text: battery.serialNumber,
  );

  final mahController =
  TextEditingController(
    text: battery.capacityMah.toString(),
  );

  final typeController =
  TextEditingController(
    text: battery.type,
  );

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Update Battery"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: serialController,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: mahController,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: typeController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final response =
              await BatteryApiService
                  .updateBattery(
                id: battery.id,
                serialNo:
                serialController.text.trim(),
                capacityMah:
                mahController.text.trim(),
                type: typeController.text.trim(),
              );

              if (response["status"] == true) {
                final updatedBattery =
                BatteryModel(
                  id: battery.id,
                  serialNumber:
                  serialController.text.trim(),
                  capacityMah: int.parse(
                    mahController.text.trim(),
                  ),
                  healthPercent: 100,
                  type:
                  typeController.text.trim(),
                );

                onUpdate(updatedBattery);

                Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      );
    },
  );
}