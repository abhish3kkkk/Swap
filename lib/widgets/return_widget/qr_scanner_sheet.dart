import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../config/app_theme.dart';

/// Shows a full bottom-sheet QR scanner.
/// Returns the raw scanned string via Navigator.pop, or null if dismissed.
Future<String?> showQrScannerSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _QrScannerSheet(),
  );
}

class _QrScannerSheet extends StatefulWidget {
  const _QrScannerSheet();

  @override
  State<_QrScannerSheet> createState() => _QrScannerSheetState();
}

class _QrScannerSheetState extends State<_QrScannerSheet> {
  final MobileScannerController _controller = MobileScannerController();
  bool _hasScanned = false;
  bool _torchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final barcode = capture.barcodes.firstOrNull;
    final raw = barcode?.rawValue;
    if (raw != null && raw.isNotEmpty) {
      _hasScanned = true;
      Navigator.of(context).pop(raw);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Text(
                  'Scan Battery QR',
                  style: TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                _IconBtn(
                  icon: _torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  onTap: () {
                    _controller.toggleTorch();
                    setState(() => _torchOn = !_torchOn);
                  },
                ),
                const SizedBox(width: 8),
                _IconBtn(
                  icon: Icons.close_rounded,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Scanner viewport
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
                // Viewfinder overlay
                _ScannerOverlay(),
              ],
            ),
          ),

          // Hint text
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Align the QR code within the frame',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const size = 220.0;
    const cornerLen = 24.0;
    const cornerThick = 3.0;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Top-left corner
          Positioned(
            top: 0, left: 0,
            child: _Corner(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6)),
              width: cornerLen,
              height: cornerLen,
              borders: {_Side.top, _Side.left},
              thick: cornerThick,
            ),
          ),
          // Top-right corner
          Positioned(
            top: 0, right: 0,
            child: _Corner(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6)),
              width: cornerLen,
              height: cornerLen,
              borders: {_Side.top, _Side.right},
              thick: cornerThick,
            ),
          ),
          // Bottom-left corner
          Positioned(
            bottom: 0, left: 0,
            child: _Corner(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6)),
              width: cornerLen,
              height: cornerLen,
              borders: {_Side.bottom, _Side.left},
              thick: cornerThick,
            ),
          ),
          // Bottom-right corner
          Positioned(
            bottom: 0, right: 0,
            child: _Corner(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(6)),
              width: cornerLen,
              height: cornerLen,
              borders: {_Side.bottom, _Side.right},
              thick: cornerThick,
            ),
          ),
        ],
      ),
    );
  }
}

enum _Side { top, bottom, left, right }

class _Corner extends StatelessWidget {
  final BorderRadius borderRadius;
  final double width;
  final double height;
  final Set<_Side> borders;
  final double thick;

  const _Corner({
    required this.borderRadius,
    required this.width,
    required this.height,
    required this.borders,
    required this.thick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border(
          top: borders.contains(_Side.top)
              ? BorderSide(color: AppColors.scannerBorder, width: thick)
              : BorderSide.none,
          bottom: borders.contains(_Side.bottom)
              ? BorderSide(color: AppColors.scannerBorder, width: thick)
              : BorderSide.none,
          left: borders.contains(_Side.left)
              ? BorderSide(color: AppColors.scannerBorder, width: thick)
              : BorderSide.none,
          right: borders.contains(_Side.right)
              ? BorderSide(color: AppColors.scannerBorder, width: thick)
              : BorderSide.none,
        ),
      ),
    );
  }
}