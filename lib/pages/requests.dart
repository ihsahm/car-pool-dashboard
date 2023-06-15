import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_pool_dashboard/models/drivers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../helpers/responsive.dart';
import '../main.dart';
import '../widgets/custom_text.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final FirebaseRealtimeDatabaseService getAllDrivers =
      FirebaseRealtimeDatabaseService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Responsive.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<List<Driver>>(
                    future: getAllDrivers.getAllDrivers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Driver>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No users found'));
                      } else {
                        return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Driver driversList = snapshot.data![index];

                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  driversRef
                                                      .child(snapshot
                                                          .data![index].id)
                                                      .update({
                                                    "status": "accepted"
                                                  });
                                                },
                                                child: const Text(
                                                  "Decline",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  try {
                                                    driversRef
                                                        .child(snapshot
                                                            .data![index].id)
                                                        .update({
                                                      "status": "accepted"
                                                    });
                                                  } catch (ex) {
                                                    Fluttertoast.showToast(
                                                        msg: ex.toString());
                                                  }
                                                },
                                                child: const Text(
                                                  "Approve",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                          title: const Text("Driver data"),
                                          content: Column(children: [
                                            const Text(
                                              "Libre",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 460,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    driversList.driverLibre,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const Divider(),
                                            const Text(
                                              "License",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 460,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    driversList.driverLicense,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ]),
                                        );
                                      }));
                                },
                                child: Card(
                                  child: Material(
                                    child: GridTile(
                                      footer: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    driversList.imagePath),
                                                radius: 60,
                                              ),
                                              const SizedBox(height: 15),
                                              Text("Name: ${driversList.name}"),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Phone: ${driversList.phone}"),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Email: ${driversList.email}"),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Car: ${driversList.carYear} ${driversList.carColor} ${driversList.carMake} ${driversList.carModel}"),
                                              const SizedBox(height: 5),
                                            ],
                                          )),
                                      child: const SizedBox(
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    })
              ],
            ))
      ],
    );
  }
}

class FirebaseRealtimeDatabaseService {
  Future<List<Driver>> getAllDrivers() async {
    List<Driver> drivers = [];
    try {
      DatabaseEvent dataSnapshot = await driversRef.once();

      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final driver = Driver(
            imagePath: value['driver_image'],
            name: value['name'],
            email: value['email'],
            phone: value['phone'],
            ratings: value['averageRating'],
            carMake: value['car_make'],
            carColor: value['car_color'],
            carModel: value['car_model'],
            carPlateNo: value['car_plateNo'],
            carYear: value['car_year'],
            id: value['id'],
            driverLicense: value['driver_license'],
            driverLibre: value['driver_libre'],
            status: value['status'],
          );
          drivers.add(driver);
        });
      }
    } catch (exp) {
      Fluttertoast.showToast(msg: "Error: $exp");
    }

    return drivers;
  }
}
