import 'package:car_pool_dashboard/constants/colors.dart';
import 'package:car_pool_dashboard/constants/controllers.dart';
import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:car_pool_dashboard/routing/routes.dart';
import 'package:car_pool_dashboard/widgets/custom_text.dart';
import 'package:car_pool_dashboard/widgets/side_menu_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(children: [
        if (Responsive.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 48,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.local_taxi),
                  ),
                  Flexible(
                      child: CustomText(
                          text: "Dashboard",
                          size: 20,
                          weight: FontWeight.bold,
                          color: active)),
                  SizedBox(
                    width: width / 48,
                  ),
                ],
              ),
            ],
          ),
        const SizedBox(
          height: 40,
        ),
        Divider(
          color: lightGrey.withOpacity(.1),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: sideMenuItems
              .map((itemName) => SideMenuItem(
                  itemName: itemName == HomePageRoute ? "Home Page" : itemName,
                  onTap: () {
                    if (itemName == HomePageRoute) {}
                    if (!menuController.isActive(itemName)) {
                      menuController.changeActiveitemTo(itemName);
                      if (Responsive.isSmallScreen(context)) Get.back();
                      navigationController.navigateTo(itemName);
                    }
                  }))
              .toList(),
        )
      ]),
    );
  }
}
