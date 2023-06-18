import 'package:car_pool_dashboard/constants/controllers.dart';
import 'package:car_pool_dashboard/main.dart';
import 'package:car_pool_dashboard/models/trips.dart';
import 'package:car_pool_dashboard/widgets/custom_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../helpers/responsive.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  final FirebaseRealtimeDatabaseService getAllTrips =
      FirebaseRealtimeDatabaseService();

  void deleteTrip(String tripId) {
    DatabaseReference tripRef = tripsRef.child(tripId);
    try {
      tripRef.remove();
    } catch (ex) {
      Fluttertoast.showToast(msg: "Error +$ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(() => Column(
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
                FutureBuilder<List<Trip>>(
                    future: getAllTrips.getAllTrips(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Trip>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No trips found'));
                      } else {
                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Trip tripsList = snapshot.data![index];
                              return ListTile(
                                title: Text(
                                    "Destination: ${tripsList.destinationLocation}"),
                                leading: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this trip?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Yes"),
                                                  onPressed: () {
                                                    deleteTrip(
                                                        tripsList.tripID);
                                                    Navigator.of(context).pop();

                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Trip deleted succesfully, refresh to see changes");
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
                                subtitle: Text(
                                    "Pickup location: ${tripsList.pickUpLocation}"),
                                trailing:
                                    Text("Scheduled: ${tripsList.status}"),
                                onTap: () {
                                  // Do something when the user tile is tapped
                                },
                              );
                            });
                      }
                    })
              ],
            )));
  }
}

class FirebaseRealtimeDatabaseService {
  Future<List<Trip>> getAllTrips() async {
    List<Trip> trips = [];
    try {
      DatabaseEvent dataSnapshot = await tripsRef.once();

      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final trip = Trip(
              driverID: value['driver_id'],
              price: value['estimatedCost'],
              pickUpLatPos: value['locationLatitude'],
              pickUpLongPos: value['locationLongitude'],
              dropOffLatPos: value['destinationLatitude'],
              dropOffLongPos: value['destinationLongitude'],
              tripID: value['tripID'],
              destinationLocation: value['destinationLocation'],
              pickUpLocation: value['pickUpLocation'],
              passengers: value['passengers'],
              status: value['status']);
          trips.add(trip);
        });
      }
    } catch (exp) {
      Fluttertoast.showToast(msg: "Error $exp");
    }

    return trips;
  }
}
