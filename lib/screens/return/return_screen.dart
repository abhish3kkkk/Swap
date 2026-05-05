// import 'package:flutter/material.dart';
// import '../../models/battery_model.dart';
// import '../../models/return_battery_form_state.dart';
// import '../../config/app_theme.dart';
// import '../../widgets/return_widget/battery_condition_selector.dart';
// import '../../widgets/return_widget/battery_info_card.dart';
// import '../../widgets/return_widget/driver_id_field.dart';
// import '../../widgets/return_widget/form_section.dart';
// import '../../widgets/return_widget/qr_scan_button.dart';
// import '../../widgets/return_widget/qr_scanner_sheet.dart';
// import '../../widgets/return_widget/return_submit_button.dart';
//
// class ReturnScreen extends StatefulWidget {
//   const ReturnScreen({super.key});
//
//   @override
//   State<ReturnScreen> createState() => _ReturnScreenState();
// }
//
// class _ReturnScreenState extends State<ReturnScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _driverIdController = TextEditingController();
//
//   ReturnBatteryFormState _formState = const ReturnBatteryFormState();
//
//   @override
//   void dispose() {
//     _driverIdController.dispose();
//     super.dispose();
//   }
//
//   // ─── QR scanning ────────────────────────────────────────────────────────────
//
//   Future<void> _openQrScanner() async {
//     final raw = await showQrScannerSheet(context);
//     if (raw == null || !mounted) return;
//     _parseQrPayload(raw);
//   }
//
//   void _parseQrPayload(String raw) {
//     try {
//       final battery = BatteryModel.fromQrCode(raw);
//       setState(() {
//         _formState = _formState.copyWith(
//           battery: battery,
//           clearError: true,
//           clearCondition: true,
//         );
//       });
//     } catch (_) {
//       setState(() {
//         _formState = _formState.copyWith(
//           errorMessage: 'Invalid QR code. Please scan a valid battery tag.',
//           clearBattery: true,
//         );
//       });
//       _showSnackBar('Invalid QR code format.', isError: true);
//     }
//   }
//
//   void _removeBattery() {
//     setState(() {
//       _formState = _formState.copyWith(
//         clearBattery: true,
//         clearError: true,
//         clearCondition: true,
//       );
//     });
//   }
//
//   // ─── Submission ─────────────────────────────────────────────────────────────
//
//   Future<void> _submit() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     if (_formState.battery == null) {
//       _showSnackBar('Please scan a battery QR code first.', isError: true);
//       return;
//     }
//     if (_formState.condition == null) {
//       _showSnackBar('Please select battery condition.', isError: true);
//       return;
//     }
//
//     setState(() => _formState = _formState.copyWith(isSubmitting: true));
//
//     // TODO: replace with actual API call
//     await Future.delayed(const Duration(seconds: 2));
//
//     if (!mounted) return;
//     setState(() => _formState = _formState.copyWith(isSubmitting: false));
//
//     _showSuccessAndReset();
//   }
//
//   void _showSuccessAndReset() {
//     _showSnackBar(
//       'Battery returned by ${_formState.driverId}',
//       isError: false,
//       icon: Icons.keyboard_return_rounded,
//     );
//     _driverIdController.clear();
//     setState(() => _formState = const ReturnBatteryFormState());
//   }
//
//   void _showSnackBar(
//       String message, {
//         required bool isError,
//         IconData icon = Icons.info_outline_rounded,
//       }) {
//     final color = isError ? AppColors.error : const Color(0xFFBA7517);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(icon, size: 18, color: Colors.white),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 message,
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppRadius.chip)),
//       ),
//     );
//   }
//
//   // ─── Build ───────────────────────────────────────────────────────────────────
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: _buildAppBar(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(AppDimens.pagePadding),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildPageIntro(),
//                 const SizedBox(height: AppDimens.sectionGap),
//
//                 // Driver ID
//                 FormSection(
//                   label: 'Driver',
//                   child: DriverIdField(
//                     controller: _driverIdController,
//                     onChanged: (val) => setState(
//                           () => _formState = _formState.copyWith(driverId: val),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: AppDimens.sectionGap),
//
//                 // Battery scan
//                 FormSection(
//                   label: 'Battery',
//                   child: _formState.battery == null
//                       ? QrScanButton(
//                     onTap: _openQrScanner,
//                     isScanned: false,
//                   )
//                       : Column(
//                     children: [
//                       BatteryInfoCard(
//                         battery: _formState.battery!,
//                         onRemove: _removeBattery,
//                       ),
//                       const SizedBox(height: AppDimens.itemGap),
//                       QrScanButton(
//                         onTap: _openQrScanner,
//                         isScanned: true,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Error banner
//                 if (_formState.errorMessage != null) ...[
//                   const SizedBox(height: AppDimens.itemGap),
//                   _ErrorBanner(message: _formState.errorMessage!),
//                 ],
//
//                 // Condition selector (only after battery is scanned)
//                 if (_formState.battery != null) ...[
//                   const SizedBox(height: AppDimens.sectionGap),
//                   FormSection(
//                     label: 'Condition',
//                     child: BatteryConditionSelector(
//                       selected: _formState.condition,
//                       onChanged: (val) => setState(
//                             () => _formState = _formState.copyWith(condition: val),
//                       ),
//                     ),
//                   ),
//                 ],
//
//                 const SizedBox(height: 32),
//
//                 ReturnSubmitButton(
//                   enabled: _formState.isValid,
//                   isLoading: _formState.isSubmitting,
//                   onPressed: _submit,
//                 ),
//
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColors.background,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded,
//             size: 18, color: AppColors.textPrimary),
//         onPressed: () => Navigator.of(context).maybePop(),
//       ),
//       title: const Text(
//         'Return Battery',
//         style: TextStyle(
//           fontFamily: 'Syne',
//           fontSize: 18,
//           fontWeight: FontWeight.w700,
//           color: AppColors.textPrimary,
//         ),
//       ),
//       centerTitle: false,
//     );
//   }
//
//   Widget _buildPageIntro() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.warningBg,
//         borderRadius: BorderRadius.circular(AppRadius.card),
//       ),
//       child: const Row(
//         children: [
//           Icon(Icons.info_outline_rounded,
//               size: 18, color: AppColors.warningText),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               'Enter the driver ID, scan the battery QR tag, and select its condition.',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.warningText,
//                 height: 1.4,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ErrorBanner extends StatelessWidget {
//   final String message;
//
//   const _ErrorBanner({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.errorBg,
//         borderRadius: BorderRadius.circular(AppRadius.chip),
//         border: Border.all(color: AppColors.error, width: 0.5),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.error_outline_rounded,
//               size: 16, color: AppColors.errorText),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(message,
//                 style: const TextStyle(
//                     fontSize: 12, color: AppColors.errorText)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// C:/swap/lib/screens/return/return_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  // Dummy Data
  static const List<Map<String, String>> _returnHistory = [
    {"id": "B-5521", "driver": "Michael Scott", "time": "10 mins ago", "condition": "Good"},
    {"id": "B-0012", "driver": "Dwight Schrute", "time": "1 hr ago", "condition": "Needs Service"},
    {"id": "B-4412", "driver": "Jim Halpert", "time": "2 hrs ago", "condition": "Good"},
    {"id": "B-0991", "driver": "Pam Beesly", "time": "Today, 08:00 AM", "condition": "Damaged"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Returned Batteries',
            style: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.bold, color: AppColors.textPrimary)
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        itemCount: _returnHistory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _returnHistory[index];
          return _buildReturnCard(item);
        },
      ),
    );
  }

  Widget _buildReturnCard(Map<String, String> data) {
    Color conditionColor;
    switch (data['condition']) {
      case 'Good': conditionColor = Colors.green; break;
      case 'Needs Service': conditionColor = Colors.orange; break;
      case 'Damaged': conditionColor = Colors.red; break;
      default: conditionColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warningBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard_return_rounded, color: Color(0xFFBA7517)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Battery ${data['id']}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("Returned by: ${data['driver']}",
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data['time']!,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: conditionColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(data['condition']!,
                      style: TextStyle(color: conditionColor, fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}