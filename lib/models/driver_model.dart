// class DriverModel {
//   final int id;
//   final String name;
//   final String phone;
//   final String address;
//   final String vehicleNumber;
//
//   DriverModel({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.vehicleNumber,
//   });
//
//   factory DriverModel.fromJson(Map<String, dynamic> json) {
//     return DriverModel(
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//       address: json['address'] ?? '',
//       vehicleNumber: json['vehicle_number'] ?? '',
//     );
//   }
// }
enum DriverStatus { active, idle, offline } //this is to show driver is he/she is active or not

class DriverModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String vehicleNumber;
  final DriverStatus status;

  const DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.vehicleNumber,
    this.status = DriverStatus.offline,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      status: DriverStatus.values.firstWhere(
            (e) => e.name == (json['status'] ?? 'offline'),
        orElse: () => DriverStatus.offline,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'address': address,
    'vehicle_number': vehicleNumber,
    'status': status.name,
  };
}