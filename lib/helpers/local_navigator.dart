import 'package:car_pool_dashboard/constants/controllers.dart';
import 'package:car_pool_dashboard/routing/router.dart';
import 'package:car_pool_dashboard/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: HomePageRoute,
      onGenerateRoute: generateRoute,
    );
