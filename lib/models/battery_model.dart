// class BatteryModel {
//   final int id;
//   final String batteryCode;
//   final String status;
//   final String mfd;
//
//   BatteryModel({
//     required this.id,
//     required this.batteryCode,
//     required this.status,
//     required this.mfd,
//   });
//
//   factory BatteryModel.fromJson(Map<String, dynamic> json) {
//     return BatteryModel(
//       id: json['id'],
//       batteryCode: json['battery_code'],
//       status: json['status'],
//       mfd: json['manufacturing_date'],
//     );
//   }
// }
class BatteryModel {
  final String id;
  final String serialNumber;
  final int capacityMah;
  final int healthPercent;
  final String type;

  const BatteryModel({
    required this.id,
    required this.serialNumber,
    required this.capacityMah,
    required this.healthPercent,
    required this.type,
  });

  /// Parses QR code payload (expected format: id|serial|capacity|health|type)
  factory BatteryModel.fromQrCode(String raw) {
    final parts = raw.split('|');
    if (parts.length < 5) {
      throw FormatException('Invalid QR payload: $raw');
    }
    return BatteryModel(
      id: parts[0].trim(),
      serialNumber: parts[1].trim(),
      capacityMah: int.tryParse(parts[2].trim()) ?? 0,
      healthPercent: int.tryParse(parts[3].trim()) ?? 0,
      type: parts[4].trim(),
    );
  }

  factory BatteryModel.fromJson(Map<String, dynamic> json) {
    return BatteryModel(
      id: json['id'] ?? '',
      serialNumber: json['serial_number'] ?? '',
      capacityMah: json['capacity_mah'] ?? 0,
      healthPercent: json['health_percent'] ?? 0,
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'serial_number': serialNumber,
    'capacity_mah': capacityMah,
    'health_percent': healthPercent,
    'type': type,
  };
}