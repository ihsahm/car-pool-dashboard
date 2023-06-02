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
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Users usersList = snapshot.data![index];
                              return Card(
                                child: Material(
                                  child: GridTile(
                                    footer: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                usersList.imagePath),
                                            radius: 60,
                                          ),
                                          const SizedBox(height: 15),
                                          Text("Name: ${usersList.name}"),
                                          const SizedBox(height: 5),
                                          Text("Email: ${usersList.email}"),
                                          const SizedBox(height: 5),
                                          Text("Phone: ${usersList.phone}"),
                                          const SizedBox(height: 5),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Delete"),
                                                        content: const Text(
                                                            "Are you sure you want to delete this user?"),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                "Yes"),
                                                            onPressed: () {
                                                              deleteUser(
                                                                  usersList.id);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "User deleted succesfully, refresh to see changes");
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                "No"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
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
                                        ],
                                      ),
                                    ),
                                    child: const SizedBox(height: 0),
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
      Fluttertoast.showToast(msg: "Error: $exp");
    }

    return users;
  }
}
