import 'package:car_pool_dashboard/constants/colors.dart';
import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0,
      leading: !Responsive.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: const Icon(
                    Icons.local_taxi_outlined,
                    size: 28,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu)),
      title: Row(children: [
        Visibility(
            child: CustomText(
          text: "Dashboard",
          color: lightGrey,
          size: 20,
          weight: FontWeight.bold,
        )),
        Expanded(child: Container()),
        Container(
          width: 1,
          height: 22,
          color: lightGrey,
        ),
        const SizedBox(
          width: 24,
        ),
        CustomText(
          text: "Adminstrator",
          color: lightGrey,
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
                backgroundColor: light,
                child: Icon(
                  Icons.person_outline,
                  color: dark,
                )),
          ),
        )
      ]),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );
