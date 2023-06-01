import 'package:car_pool_dashboard/pages/home_page/home_cards.dart';
import 'package:flutter/material.dart';

class HomePageCards extends StatelessWidget {
  const HomePageCards({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        HomeCards(
          title: "Drivers",
          value: "70",
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: width / 64,
        ),
        HomeCards(
          title: "Users",
          value: "120",
          onTap: () {},
          topColor: Colors.lightGreen,
        ),
        SizedBox(
          width: width / 64,
        ),
        HomeCards(
          title: "Trips",
          value: "850",
          onTap: () {},
          topColor: Colors.redAccent,
        ),
      ],
    );
  }
}
