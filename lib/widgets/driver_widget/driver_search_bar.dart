import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class DriverSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const DriverSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = 'Search by name or vehicle...',
  });

  @override
  State<DriverSearchBar> createState() => _DriverSearchBarState();
}

class _DriverSearchBarState extends State<DriverSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.searchBar),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search_rounded, size: 18, color: AppColors.textTertiary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (_, value, __) {
              if (value.text.isEmpty) return const SizedBox(width: 14);
              return GestureDetector(
                onTap: _clear,
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.close_rounded,
                      size: 16, color: AppColors.textTertiary),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}