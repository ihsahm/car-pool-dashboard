import 'package:car_pool_dashboard/pages/drivers.dart';
import 'package:car_pool_dashboard/pages/home_page/home_page.dart';
import 'package:car_pool_dashboard/pages/trips.dart';
import 'package:car_pool_dashboard/pages/users.dart';
import 'package:car_pool_dashboard/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return _getPageRoute(const HomePage());
    case DriversPageRoute:
      return _getPageRoute(const DriversPage());
    case UsersPageRoute:
      return _getPageRoute(const UsersPage());
    case TripsPageRoute:
      return _getPageRoute(const TripsPage());
    default:
      return _getPageRoute(const HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: ((context) => child));
}
