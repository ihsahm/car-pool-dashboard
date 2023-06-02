import 'package:car_pool_dashboard/constants/colors.dart';
import 'package:car_pool_dashboard/controllers/menu_controller.dart';
import 'package:car_pool_dashboard/controllers/navigation_controller.dart';
import 'package:car_pool_dashboard/layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  Get.put(MenuControllers());
  Get.put(NavigationController());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDq7aXHBfaVMBvlwaNZ3h05XvDpHGAKVhg",
          appId: "1:991467052155:web:4429db6d6983ba0b0a16de",
          messagingSenderId: "991467052155",
          databaseURL: "https://ride-pool-6b3b1-default-rtdb.firebaseio.com",
          authDomain: "ride-pool-6b3b1.firebaseapp.com",
          storageBucket: "ride-pool-6b3b1.appspot.com",
          projectId: "ride-pool-6b3b1"));
  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
DatabaseReference tripsRef = FirebaseDatabase.instance.ref().child("trips");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.greenAccent),
      home: SiteLayout(),
    );
  }
}
