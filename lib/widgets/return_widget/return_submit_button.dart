import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class ReturnSubmitButton extends StatelessWidget {
  final bool enabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  const ReturnSubmitButton({
    super.key,
    required this.enabled,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1.0 : 0.45,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: (enabled && !isLoading) ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBA7517), // amber-600
            disabledBackgroundColor: const Color(0xFFBA7517),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.keyboard_return_rounded,
                  size: 18, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'Return Battery',
                style: AppTextStyles.buttonLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}