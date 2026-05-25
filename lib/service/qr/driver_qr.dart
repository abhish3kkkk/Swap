import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../models/driver_model.dart';

class DriverQrService {
  static final ScreenshotController screenshotController =
  ScreenshotController();

  /// Generate QR Payload
  static String generatePayload(DriverModel driver) {
    return jsonEncode(driver.toJson());
  }

  /// Build QR Widget
  static Widget buildQrCode(
      DriverModel driver, {
        double size = 200,
      }) {
    final String data = generatePayload(driver);

    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// QR
            QrImageView(
              data: data,
              version: QrVersions.auto,
              size: size,
            ),

            const SizedBox(height: 4),

            /// Driver Name
            Text(
              driver.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            /// Vehicle Number
            Text(
              "Vehicle No: ${driver.vehicleNumber}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 6),

            /// Phone Number
            Text(
              driver.phone,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),


            /// Status Badge
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 12,
            //     vertical: 6,
            //   ),
            //   decoration: BoxDecoration(
            //     color: _getStatusColor(driver.status)
            //         .withOpacity(0.12),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Text(
            //     driver.status.name.toUpperCase(),
            //     style: TextStyle(
            //       color: _getStatusColor(driver.status),
            //       fontWeight: FontWeight.bold,
            //       letterSpacing: 1,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Download QR
  static Future<bool> downloadQr(DriverModel driver) async {
    try {
      final Uint8List? imageBytes =
      await screenshotController.capture();

      if (imageBytes == null) return false;

      await Gal.putImageBytes(
        imageBytes,
        name: "driver_${driver.vehicleNumber}",
      );

      return true;
    } catch (e) {
      debugPrint("Driver QR Download Error: $e");
      return false;
    }
  }

  /// Status Color
  // static Color _getStatusColor(DriverStatus status) {
  //   switch (status) {
  //     case DriverStatus.active:
  //       return Colors.green;
  //
  //     case DriverStatus.idle:
  //       return Colors.orange;
  //
  //     case DriverStatus.offline:
  //       return Colors.red;
  //   }
  // }
}