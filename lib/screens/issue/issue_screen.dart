// import 'package:flutter/material.dart';
// import '../../models/battery_model.dart';
// import '../../models/issue_battery_form_state.dart';
// import '../../config/app_theme.dart';
// import '../../widgets/issue_widget/battery_info_card.dart';
// import '../../widgets/issue_widget/driver_id_field.dart';
// import '../../widgets/issue_widget/form_section.dart';
// import '../../widgets/issue_widget/issue_submit_button.dart';
// import '../../widgets/issue_widget/qr_scan_button.dart';
// import '../../widgets/issue_widget/qr_scanner_sheet.dart';
//
// class IssueScreen extends StatefulWidget {
//   const IssueScreen({super.key});
//
//   @override
//   State<IssueScreen> createState() => _IssueScreenState();
// }
//
// class _IssueScreenState extends State<IssueScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _driverIdController = TextEditingController();
//
//   IssueBatteryFormState _formState = const IssueBatteryFormState();
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
//         _formState = _formState.copyWith(battery: battery, clearError: true);
//       });
//     } catch (_) {
//       setState(() {
//         _formState = _formState.copyWith(
//           errorMessage: 'Invalid QR code. Please scan a valid battery tag.',
//           clearBattery: true,
//         );
//       });
//       _showErrorSnackBar('Invalid QR code format.');
//     }
//   }
//
//   void _removeBattery() {
//     setState(() {
//       _formState = _formState.copyWith(clearBattery: true, clearError: true);
//     });
//   }
//
//   // ─── Submission ─────────────────────────────────────────────────────────────
//
//   Future<void> _submit() async {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     if (_formState.battery == null) {
//       _showErrorSnackBar('Please scan a battery QR code first.');
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
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 size: 18, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(
//               'Battery issued to ${_formState.driverId}',
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//         backgroundColor: AppColors.primary,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppRadius.chip)),
//       ),
//     );
//     _driverIdController.clear();
//     setState(() => _formState = const IssueBatteryFormState());
//   }
//
//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: AppColors.error,
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
//                 // Page intro
//                 _buildPageIntro(),
//                 const SizedBox(height: AppDimens.sectionGap),
//
//                 // Driver ID section
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
//                 // Battery section
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
//                 if (_formState.errorMessage != null) ...[
//                   const SizedBox(height: AppDimens.itemGap),
//                   _ErrorBanner(message: _formState.errorMessage!),
//                 ],
//
//                 const SizedBox(height: 32),
//
//                 // Submit
//                 IssueSubmitButton(
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
//         'Issue Battery',
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
//         color: AppColors.primaryLight,
//         borderRadius: BorderRadius.circular(AppRadius.card),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline_rounded,
//               size: 18, color: AppColors.primaryDark),
//           const SizedBox(width: 10),
//           const Expanded(
//             child: Text(
//               'Enter the driver ID and scan the battery QR tag to issue.',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.primaryDark,
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

// C:/swap/lib/screens/issue/issue_screen.dart

import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class IssueScreen extends StatelessWidget {
  const IssueScreen({super.key});

  // Dummy Data
  static const List<Map<String, String>> _issuedHistory = [
    {"id": "B-9921", "driver": "John Doe", "time": "Today, 10:30 AM", "status": "In Use"},
    {"id": "B-1024", "driver": "Ramesh Kumar", "time": "Today, 09:15 AM", "status": "In Use"},
    {"id": "B-8827", "driver": "Suresh Singh", "time": "Yesterday, 04:45 PM", "status": "In Use"},
    {"id": "B-7721", "driver": "Amit Patel", "time": "Yesterday, 02:20 PM", "status": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Issued Batteries',
            style: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.bold, color: AppColors.textPrimary)
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        itemCount: _issuedHistory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _issuedHistory[index];
          return _buildIssueCard(item);
        },
      ),
    );
  }

  Widget _buildIssueCard(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.outbox_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Battery ${data['id']}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("Issued to: ${data['driver']}",
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: data['status'] == 'In Use' ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(data['status']!,
                    style: TextStyle(
                        color: data['status'] == 'In Use' ? Colors.green : Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}