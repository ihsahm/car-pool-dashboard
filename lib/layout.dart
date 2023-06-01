import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:car_pool_dashboard/widgets/large_screen.dart';
import 'package:car_pool_dashboard/widgets/side_menu.dart';
import 'package:car_pool_dashboard/widgets/small_screen.dart';
import 'package:car_pool_dashboard/widgets/top_nav.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      key: scaffoldKey,
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const Responsive(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
