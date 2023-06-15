import 'package:car_pool_dashboard/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class MenuControllers extends GetxController {
  static MenuControllers instance = Get.find();

  var activeItem = HomePageRoute.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case HomePageRoute:
        return _customIcon(Icons.home, itemName);
      case RequestsPageRoute:
        return _customIcon(Icons.group_add_outlined, itemName);
      case DriversPageRoute:
        return _customIcon(Icons.drive_eta_outlined, itemName);
      case UsersPageRoute:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case TripsPageRoute:
        return _customIcon(Icons.arrow_upward_outlined, itemName);

      default:
        return _customIcon(Icons.home, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }

    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}
