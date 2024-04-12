import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

class ViewAccount extends StatefulWidget {
  const ViewAccount({super.key});

  @override
  State<ViewAccount> createState() => _ViewAccountState();
}

class _ViewAccountState extends State<ViewAccount> {
  bool isvisible = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isDeviceConnected = false;
  bool isAlert = false;
  StreamSubscription? subscription;

  void checkConnection() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      isDeviceConnected = await InternetConnection().hasInternetAccess;
      if (!isDeviceConnected && isAlert == false) {
        showAlertDialog();
        setState(() {
          isAlert = true;
        });
      }
    });
  }

  showAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Connection Problem",
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
          content: const Text(
            "No internet connection detected. Please connect to a network to continue.",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  Get.back();
                  setState(() {
                    isAlert = false;
                  });
                  Future.delayed(const Duration(seconds: 1));
                  isDeviceConnected =
                      await InternetConnection().hasInternetAccess;
                  if (!isDeviceConnected) {
                    showAlertDialog();
                    setState(() {
                      isAlert = true;
                    });
                  }
                },
                child: const Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: FutureBuilder(
        future:
            Provider.of<StudentPresidentDataFetch>(context).getStudentData(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.yellow,
              ),
            );
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.studentPhoto!),
                    radius: 70,
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Full Name",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.fullName!,
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.email!,
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Student ID",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.studentId!,
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.gender!,
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Department",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.department!,
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Signiture",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    width: 100,
                    child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data!.signature!)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Stamp",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: 100,
                    child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data!.stamp!)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: const Text("something went wrong"),
            );
          }
        },
      ),
    );
  }
}
