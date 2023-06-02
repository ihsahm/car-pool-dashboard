import 'package:car_pool_dashboard/helpers/responsive.dart';
import 'package:car_pool_dashboard/main.dart';
import 'package:car_pool_dashboard/models/users.dart';
import 'package:car_pool_dashboard/widgets/custom_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final FirebaseRealtimeDatabaseService getAllUsers =
      FirebaseRealtimeDatabaseService();

  void deleteUser(String userId) {
    DatabaseReference usersRef = userRef.child(userId);
    try {
      usersRef.remove();
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
                FutureBuilder<List<Users>>(
                    future: getAllUsers.getAllUsers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Users>> snapshot) {
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
                              Users usersList = snapshot.data![index];
                              return ListTile(
                                title: Text("Name: ${usersList.name}"),
                                leading: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this user?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Yes"),
                                                  onPressed: () {
                                                    deleteUser(usersList.id);
                                                    Navigator.of(context).pop();

                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "User deleted succesfully, refresh to see changes");
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
                                subtitle: Text("Email: ${usersList.email}"),
                                trailing: Text("Phone: ${usersList.phone}"),
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
  Future<List<Users>> getAllUsers() async {
    List<Users> users = [];
    try {
      DatabaseEvent dataSnapshot = await userRef.once();

      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final user = Users(
              email: value['email'],
              imagePath: value['userImage'],
              name: value['name'],
              phone: value['phone'],
              id: value['id']);
          users.add(user);
        });
      }
    } catch (exp) {
      print(exp);
    }

    return users;
  }
}
