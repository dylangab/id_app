import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class ViewAccount extends StatefulWidget {
  const ViewAccount({super.key});

  @override
  State<ViewAccount> createState() => _ViewAccountState();
}

class _ViewAccountState extends State<ViewAccount> {
  bool isvisible = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.fullName!,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.email!,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Student ID",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.studentId!,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.gender!,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Department",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    snapshot.data!.department!,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Signiture",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
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
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Stamp",
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
                SizedBox(
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
