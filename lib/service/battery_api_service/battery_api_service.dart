import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/battery_model.dart';

class BatteryApiService {
  static const String addUrl =
      "https://dynamic-futuretech.com/swap_app/apis/addBattery.php";

  static const String updateUrl =
      "https://dynamic-futuretech.com/swap_app/apis/updateBattery.php";

  static const String deleteUrl =
      "https://dynamic-futuretech.com/swap_app/apis/deleteBattery.php";

  ////////////////////////////////////////////////////////////
  /// ADD BATTERY
  ////////////////////////////////////////////////////////////

  static Future<Map<String, dynamic>> addBattery({
    required String serialNo,
    required String capacityMah,
    required String type,
  }) async {
    final response = await http.post(
      Uri.parse(addUrl),
      body: {
        "serial_no": serialNo,
        "capacity_mah": capacityMah,
        "type": type,
        "status": "1",
      },
    );

    return jsonDecode(response.body);
  }

  ////////////////////////////////////////////////////////////
  /// UPDATE BATTERY
  ////////////////////////////////////////////////////////////

  static Future<Map<String, dynamic>> updateBattery({
    required String id,
    required String serialNo,
    required String capacityMah,
    required String type,
  }) async {
    final response = await http.post(
      Uri.parse(updateUrl),
      body: {
        "id": id,
        "serial_no": serialNo,
        "capacity_mah": capacityMah,
        "type": type,
        "status": "1",
      },
    );

    return jsonDecode(response.body);
  }

  ////////////////////////////////////////////////////////////
  /// DELETE BATTERY
  ////////////////////////////////////////////////////////////

  static Future<Map<String, dynamic>> deleteBattery(
      String id,
      ) async {
    final response = await http.post(
      Uri.parse(deleteUrl),
      body: {
        "id": id,
      },
    );

    return jsonDecode(response.body);
  }

  ////////////////////////////////////////////////////////////
  /// GET BATTERIES
////////////////////////////////////////////////////////////

  static Future<List<BatteryModel>> getBatteries() async {
    final response = await http.get(
      Uri.parse(
        "https://dynamic-futuretech.com/swap_app/apis/getBattery.php",
      ),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      final List batteryList = data["data"];

      return batteryList
          .map(
            (e) => BatteryModel.fromJson(e),
      )
          .toList();
    } else {
      throw Exception(
        data["message"] ?? "Failed to fetch batteries",
      );
    }
  }

}
