import '../models/driver_model.dart';

class DriverData {
  static List<DriverModel> mockDrivers = [
    DriverModel(
      id: 1,
      name: 'Rahul Sharma',
      phone: '+91 98100 11234',
      address: '14 MG Road, Delhi',
      vehicleNumber: 'DL 01 CA 4521',
      status: DriverStatus.active,
    ),
    DriverModel(
      id: 2,
      name: 'Priya Mehta',
      phone: '+91 87654 32100',
      address: '7 Sector 18, Noida',
      vehicleNumber: 'UP 16 BT 9930',
      status: DriverStatus.idle,
    ),
    DriverModel(
      id: 3,
      name: 'Aman Verma',
      phone: '+91 99870 56789',
      address: '3 Civil Lines, Gurugram',
      vehicleNumber: 'HR 26 AL 1102',
      status: DriverStatus.active,
    ),
    DriverModel(
      id: 4,
      name: 'Sneha Kapoor',
      phone: '+91 70110 88001',
      address: '22 Lajpat Nagar, Delhi',
      vehicleNumber: 'DL 03 CX 7744',
      status: DriverStatus.offline,
    ),
    DriverModel(
      id: 5,
      name: 'Deepak Nair',
      phone: '+91 91560 33412',
      address: '9 Powai, Mumbai',
      vehicleNumber: 'MH 02 GH 2256',
      status: DriverStatus.active,
    ),
    DriverModel(
      id: 6,
      name: 'Kavita Singh',
      phone: '+91 82210 00541',
      address: '5 Koregaon Park, Pune',
      vehicleNumber: 'MH 12 EF 5510',
      status: DriverStatus.idle,
    ),
    DriverModel(
      id: 7,
      name: 'Arjun Pillai',
      phone: '+91 96320 77230',
      address: '11 Whitefield, Bengaluru',
      vehicleNumber: 'KA 05 MN 3389',
      status: DriverStatus.active,
    ),
    DriverModel(
      id: 8,
      name: 'Fatima Shaikh',
      phone: '+91 88005 19874',
      address: '38 Salt Lake, Kolkata',
      vehicleNumber: 'WB 02 AB 8871',
      status: DriverStatus.offline,
    ),
  ];
}