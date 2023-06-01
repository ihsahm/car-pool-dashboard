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
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: dark.withOpacity(.7),
            )),
        Stack(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: dark.withOpacity(.7),
                )),
            Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: light, width: 2),
                      color: active),
                ))
          ],
        ),
        Container(
          width: 1,
          height: 22,
          color: lightGrey,
        ),
        const SizedBox(
          width: 24,
        ),
        CustomText(
          text: "Abebe Kelemu",
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
