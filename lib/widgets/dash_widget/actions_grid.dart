import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/action_item.dart';
import 'action_card.dart';

class ActionsGrid extends StatelessWidget {
  final List<ActionItem> items;

  const ActionsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.itemGap,
        mainAxisSpacing: AppDimens.itemGap,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ActionCard(item: items[index]),
    );
  }
}