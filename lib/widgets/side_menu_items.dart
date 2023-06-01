import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:car_pool_dashboard/widgets/horizontal_menu_items.dart';
import 'package:car_pool_dashboard/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const SideMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isCustomSize(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
