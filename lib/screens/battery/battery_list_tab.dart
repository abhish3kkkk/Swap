import 'package:flutter/material.dart';

import '../../models/battery_model.dart';
import '../../service/battery_api_service/battery_api_service.dart';
import '../../widgets/battery_widget/update_battery_dialog.dart';

class BatteryListTab extends StatelessWidget {
  final List<BatteryModel> batteries;

  final Function(String id) onDelete;
  final Function(BatteryModel battery) onUpdate;

  const BatteryListTab({
    super.key,
    required this.batteries,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (batteries.isEmpty) {
      return const Center(
        child: Text("No Batteries Found ⚡"),
      );
    }

    return ListView.builder(
      itemCount: batteries.length,
      itemBuilder: (context, index) {
        final battery = batteries[index];

        return Card(
          child: ListTile(
            title: Text(battery.serialNumber),
            subtitle: Text(
              "${battery.capacityMah} mAh | ${battery.type}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showUpdateBatteryDialog(
                      context: context,
                      battery: battery,
                      onUpdate: onUpdate,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final response =
                    await BatteryApiService
                        .deleteBattery(
                      battery.id,
                    );

                    if (response["status"] == true) {
                      onDelete(battery.id);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}