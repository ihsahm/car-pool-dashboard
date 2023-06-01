import 'package:car_pool_dashboard/constants/controllers.dart';
import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:car_pool_dashboard/pages/home_page/home_page_cards.dart';
import 'package:car_pool_dashboard/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Responsive.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        Expanded(
            child: ListView(
          children: const [HomePageCards()],
        ))
      ],
    );
  }
}
