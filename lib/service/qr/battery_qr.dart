// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'dart:convert';
// import '../../models/battery_model.dart';
//
// class BatteryQrService {
//   /// Generates the raw payload string for a battery QR code in JSON format
//   static String generatePayload(BatteryModel battery) {
//     return jsonEncode(battery.toJson());
//   }
//
//   /// Returns a QrImageView widget for the given battery
//   static Widget buildQrCode(BatteryModel battery, {double size = 200.0}) {
//     final String data = generatePayload(battery);
//
//     return QrImageView(
//       data: data,
//       version: QrVersions.auto,
//       size: size,
//       gapless: false,
//       errorStateBuilder: (cxt, err) {
//         return const Center(
//           child: Text(
//             'Uh oh! Something went wrong...',
//             textAlign: TextAlign.center,
//           ),
//         );
//       },
//     );
//   }
// }


import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../models/battery_model.dart';

class BatteryQrService {
  static final ScreenshotController screenshotController =
  ScreenshotController();

  /// Generates QR payload
  static String generatePayload(BatteryModel battery) {
    return jsonEncode(battery.toJson());
  }

  /// QR Widget
  static Widget buildQrCode(
      BatteryModel battery, {
        double size = 200,
      }) {
    final String data = generatePayload(battery);

    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: data,
              version: QrVersions.auto,
              size: size,
            ),

            const SizedBox(height: 4),

            Text(
              "Serial Number ${battery.serialNumber}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        ),
      ),
    );
  }

  /// Download QR
  static Future<bool> downloadQr(BatteryModel battery) async {
    try {
      final Uint8List? imageBytes =
      await screenshotController.capture();

      if (imageBytes == null) return false;

      await Gal.putImageBytes(
        imageBytes,
        name: "battery_${battery.serialNumber}",
      );

      return true;
    } catch (e) {
      debugPrint("QR Download Error: $e");
      return false;
    }
  }
}