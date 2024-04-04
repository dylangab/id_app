//import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/pdf.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

String id = Get.arguments;
RoundedLoadingButtonController _buttonController =
    RoundedLoadingButtonController();

class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  Widget build(BuildContext context) {
    final buttonBuilder = Provider.of<studentInfoButtonBuilder>(context);
    final memberData = Provider.of<MembersData>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child:
              Text(memberData.membersList[buttonBuilder.studentId!].firstName!,
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5 + 1,
                    fontSize: 18 + 1 + 1,
                  )),
        ),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(memberData
                        .membersList[buttonBuilder.studentId!].studentPhoto!)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 150,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 410,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].firstName}",
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].gender}",
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].department}",
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].studentId}",
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].sector}",
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
                                text:
                                    "  ${memberData.membersList[buttonBuilder.studentId!].role}",
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
                          style: TextStyle(color: Colors.black, fontSize: 18),
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
          visible: buttonBuilder.isvisible,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: SizedBox(
              height: 45,
              child: RoundedLoadingButton(
                  color: Colors.yellow,
                  valueColor: Colors.black,
                  borderRadius: 10,
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  controller: _buttonController,
                  onPressed: () async {
                    if (buttonBuilder.generate == true) {
                      await PdfApi().generateSingleId(
                          memberData.membersList[buttonBuilder.studentId!]);
                      _buttonController.start();
                      await Future.delayed(const Duration(seconds: 1));
                      _buttonController.stop();
                      Get.to(() => const StudentPreidentHomePage());
                    } else {}
                  },
                  child: Center(
                      child: Text(
                    buttonBuilder.buttonName!,
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
  }
}
