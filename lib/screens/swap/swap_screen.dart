import 'package:flutter/material.dart';
import '../../models/battery_model.dart';
import '../../config/app_theme.dart';

// Import Widgets (Shared across issue/return)
import '../../widgets/issue_widget/driver_id_field.dart';
import '../../widgets/issue_widget/form_section.dart';
import '../../widgets/issue_widget/qr_scan_button.dart';
import '../../widgets/issue_widget/qr_scanner_sheet.dart';
import '../../widgets/issue_widget/battery_info_card.dart' as issue_card;
import '../../widgets/return_widget/battery_condition_selector.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final _formKey = GlobalKey<FormState>();
  final _driverIdController = TextEditingController();

  // State for the Swap Process
  String? _driverId;
  BatteryModel? _returnBattery;
  String? _returnCondition;
  BatteryModel? _issueBattery;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _driverIdController.dispose();
    super.dispose();
  }

  // ─── Logic ──────────────────────────────────────────────────────────────────

  Future<void> _handleQrScan({required bool isReturn}) async {
    final raw = await showQrScannerSheet(context);
    if (raw == null || !mounted) return;

    try {
      final battery = BatteryModel.fromQrCode(raw);

      // Prevent scanning the same battery for both return and issue
      if (!isReturn && _returnBattery?.id == battery.id) {
        _setErrorMessage("Cannot issue the same battery being returned.");
        return;
      }
      if (isReturn && _issueBattery?.id == battery.id) {
        _setErrorMessage("This battery is already marked for issue.");
        return;
      }

      setState(() {
        if (isReturn) {
          _returnBattery = battery;
          _returnCondition = null; // Reset condition on new scan
        } else {
          _issueBattery = battery;
        }
        _errorMessage = null;
      });
    } catch (_) {
      _setErrorMessage("Invalid QR code format.");
    }
  }

  void _setErrorMessage(String msg) {
    setState(() => _errorMessage = msg);
  }

  bool get _isFormValid {
    return _driverId != null &&
        _driverId!.isNotEmpty &&
        _returnBattery != null &&
        _returnCondition != null &&
        _issueBattery != null;
  }

  Future<void> _submitSwap() async {
    if (!_isFormValid) return;

    setState(() => _isSubmitting = true);

    // TODO: Replace with your actual API call that handles a Swap transaction
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    _showSuccessAndReset();
  }

  void _showSuccessAndReset() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Battery Swap Completed Successfully!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    _driverIdController.clear();
    setState(() {
      _returnBattery = null;
      _returnCondition = null;
      _issueBattery = null;
      _driverId = null;
    });
  }

  // ─── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSwapHeader(),
                const SizedBox(height: AppDimens.sectionGap),

                // 1. Driver Section
                FormSection(
                  label: 'Driver Information',
                  child: DriverIdField(
                    controller: _driverIdController,
                    onChanged: (val) => setState(() => _driverId = val),
                  ),
                ),
                const SizedBox(height: AppDimens.sectionGap),

                // 2. Return Section
                _buildBatterySection(
                  title: 'Step 1: Return Old Battery',
                  battery: _returnBattery,
                  isReturn: true,
                  onScan: () => _handleQrScan(isReturn: true),
                  onRemove: () => setState(() => _returnBattery = null),
                ),

                if (_returnBattery != null) ...[
                  const SizedBox(height: AppDimens.itemGap),
                  BatteryConditionSelector(
                    selected: _returnCondition,
                    onChanged: (val) => setState(() => _returnCondition = val),
                  ),
                ],

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1, color: AppColors.border),
                ),

                // 3. Issue Section
                _buildBatterySection(
                  title: 'Step 2: Issue New Battery',
                  battery: _issueBattery,
                  isReturn: false,
                  onScan: () => _handleQrScan(isReturn: false),
                  onRemove: () => setState(() => _issueBattery = null),
                ),

                if (_errorMessage != null) _buildErrorBanner(),

                const SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: (_isSubmitting || !_isFormValid) ? null : _submitSwap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.border,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('CONFIRM SWAP', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Helper UI Components ──────────────────────────────────────────────────

  Widget _buildBatterySection({
    required String title,
    required BatteryModel? battery,
    required bool isReturn,
    required VoidCallback onScan,
    required VoidCallback onRemove,
  }) {
    return FormSection(
      label: title,
      child: battery == null
          ? QrScanButton(onTap: onScan, isScanned: false)
          : Column(
        children: [
          issue_card.BatteryInfoCard(
            battery: battery,
            onRemove: onRemove,
          ),
          const SizedBox(height: 8),
          QrScanButton(onTap: onScan, isScanned: true),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Battery Swap', style: TextStyle(fontFamily: 'Syne', fontWeight: FontWeight.bold)),
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildSwapHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.swap_horizontal_circle_outlined, color: AppColors.primaryDark),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Complete a full swap by recording the returned battery and issuing a new one.',
              style: TextStyle(fontSize: 13, color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(_errorMessage!, style: const TextStyle(color: AppColors.error, fontSize: 13)),
    );
  }
}