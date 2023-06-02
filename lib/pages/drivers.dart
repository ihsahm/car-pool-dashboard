import 'package:car_pool_dashboard/main.dart';
import 'package:car_pool_dashboard/models/drivers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/controllers.dart';
import '../helpers/responsive.dart';
import '../widgets/custom_text.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final FirebaseRealtimeDatabaseService getAllDrivers =
      FirebaseRealtimeDatabaseService();

  void deleteDriver(String driverId) {
    DatabaseReference driverRef = driversRef.child(driverId);
    try {
      driverRef.remove();
    } catch (ex) {
      Fluttertoast.showToast(msg: "Error +$ex");
    }
  }

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
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Driver driversList = snapshot.data![index];
                              return ListTile(
                                title: Text("Driver Name: ${driversList.name}"),
                                leading: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this driver?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Yes"),
                                                  onPressed: () {
                                                    deleteDriver(
                                                        driversList.id);
                                                    Navigator.of(context).pop();

                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Driver deleted succesfully, refresh to see changes");
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("No"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                subtitle: Text("Email: ${driversList.email}"),
                                trailing:
                                    Text("Phone Number: ${driversList.phone}"),
                                onTap: () {
                                  // Do something when the user tile is tapped
                                },
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
            imagePath: value['userImage'],
            name: value['name'],
            email: value['email'],
            phone: value['phone'],
            ratings: value['ratings'],
            carMake: value['carMake'],
            carColor: value['carColor'],
            carModel: value['carModel'],
            carPlateNo: value['carPlateNo'],
            carYear: value['carYear'],
            id: value['id'],
          );
          drivers.add(driver);
        });
      }
    } catch (exp) {
      print(exp);
    }

    return drivers;
  }
}
