//import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:id_app/Utils/pdf.dart';
import 'package:id_app/models/member.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

String id = Get.arguments;

class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<studentInfoButtonBuilder>(
      builder: (context, value, child) => StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("members")
              .doc(value.studentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Return a loading indicator while waiting for data
              return const Scaffold(
                body: SizedBox(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                ),
              ); // or any loading widget you prefer
            } else if (snapshot.hasError) {
              // Handle error case
              return Scaffold(
                body: SizedBox(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                ),
              );
            } else {
              // Data has been received, proceed with building UI
              Member? member;
              if (snapshot.hasData && snapshot.data != null) {
                member = Member(
                    lastName: snapshot.data!["fullName"],
                    firstName: snapshot.data!["fullName"],
                    department: snapshot.data!["department"],
                    gender: snapshot.data!["gender"],
                    role: snapshot.data!["role"],
                    sector: snapshot.data!["sector"],
                    studentId: snapshot.data!["studentId"],
                    studentPhoto: snapshot.data!["studentPhoto"]);
              }
              if (member != null) {
                return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 233, 236, 239),
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Center(
                      child: Text(member.firstName!,
                          style: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5 + 1,
                            fontSize: 18 + 1 + 1,
                          )),
                    ),
                  ),
                  body: Column(children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Material(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(member.studentPhoto!)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 150,
                            width: 180),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Material(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 410,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Full Name:- ",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.firstName}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Gender:-",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.gender}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Department:-",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.department}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Student ID:-",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.studentId}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Sector:-",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.sector}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Role:-",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  ${member.role}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 15 + 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: RichText(
                                  text: const TextSpan(
                                      text: "Active Status:-",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: "  Active",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300))
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: value.isvisible,
                      maintainState: true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (value.generate == true) {
                                  await PdfApi().generateSingleId(member!);
                                  // await PdfApi().generateMultiPage().then(
                                  //     (value) async => PDFViewer(
                                  //         document: await PDFDocument.fromFile(value)));
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.yellow),
                              child: Center(
                                  child: Text(
                                value.buttonName!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1.5 + 1,
                                    color: Colors.black),
                              ))),
                        ),
                      ),
                    )
                  ]),
                );
              } else {
                return const Scaffold(
                  body: SizedBox(
                    child: Center(
                      child: Text("error"),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
