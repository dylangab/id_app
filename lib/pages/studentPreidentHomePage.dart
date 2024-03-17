import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/Utils/pdf.dart';
import 'package:id_app/Utils/pdfvie.dart';
import 'package:id_app/pages/createSectorAccountPage.dart';
import 'package:id_app/pages/selectstudents.dart';
import 'package:id_app/pages/studentInfoPage.dart';
import 'package:id_app/pages/viewMembersPage.dart';
import 'package:provider/provider.dart';
//import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import '../controllers/ProvideApi.dart';

class StudentPreidentHomePage extends StatefulWidget {
  const StudentPreidentHomePage({super.key});

  @override
  State<StudentPreidentHomePage> createState() =>
      _StudentPreidentHomePageState();
}

bool isAdd = true;
TextEditingController sectorController = TextEditingController();
FocusNode sectorNode = FocusNode();
TextEditingController roleController = TextEditingController();
FocusNode roleNode = FocusNode();
TextEditingController departmentController = TextEditingController();
FocusNode departmentNode = FocusNode();

class _StudentPreidentHomePageState extends State<StudentPreidentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 236, 239),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 130,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Student Union App",
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 1.5 + 1,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 500,
              child: AnimationConfiguration.staggeredGrid(
                position: 0,
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GridView(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      Provider.of<CreateAccountButtonBuilder>(
                                              context,
                                              listen: false)
                                          .passValue(true, "Add Member");
                                      Provider.of<HeadingController>(context,
                                              listen: false)
                                          .headingController("Add Member");
                                      Get.to(() => const SectorAccountCreate(),
                                          transition: Transition.fade);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Add Member",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      Get.to(() => const ViewMembersPage(),
                                          transition: Transition.fade);
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("View Members",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 233, 236, 239),
                                            title: Center(
                                              child: Material(
                                                elevation: 5,
                                                shape: const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Enter the student ID",
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none)),
                                                ),
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 120,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .yellow),
                                                      onPressed: () async {
                                                        var studentId;
                                                        Provider.of<studentInfoButtonBuilder>(
                                                                listen: false,
                                                                context)
                                                            .passValue(
                                                                studentId,
                                                                true,
                                                                "Generate ID");
                                                        Get.to(() =>
                                                            const StudentInfoPage());
                                                      },
                                                      child: const Text(
                                                          "Generate ID",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.5 + 1,
                                                              color: Colors
                                                                  .black))),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text("or"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () =>
                                                              const selectstudentsPage(),
                                                          transition: Transition
                                                              .fadeIn);
                                                    },
                                                    child: const SizedBox(
                                                      height: 15,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Create multiple ID",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .arrow_right_alt_sharp,
                                                              size: 18)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Generate ID",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 233, 236, 239),
                                            title: Center(
                                              child: Material(
                                                elevation: 5,
                                                shape: const OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Appoint from existing account(Enter the student ID)",
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none)),
                                                ),
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 120,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .yellow),
                                                      onPressed: () async {
                                                        var studentId;
                                                        Provider.of<studentInfoButtonBuilder>(
                                                                listen: false,
                                                                context)
                                                            .passValue(
                                                                studentId,
                                                                false,
                                                                "Appoint");
                                                        Get.to(
                                                            () =>
                                                                const StudentInfoPage(),
                                                            arguments:
                                                                studentId);
                                                      },
                                                      child: const Text(
                                                          "submit",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.5 + 1,
                                                              color: Colors
                                                                  .black))),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text("or"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Provider.of<CreateAccountButtonBuilder>(
                                                              context,
                                                              listen: false)
                                                          .passValue(false,
                                                              "Create Account");
                                                      Provider.of<HeadingController>(
                                                              context,
                                                              listen: false)
                                                          .headingController(
                                                              "Create Sector Leader Account");
                                                      Get.to(
                                                          () =>
                                                              const SectorAccountCreate(),
                                                          transition:
                                                              Transition.fade);
                                                    },
                                                    child: const SizedBox(
                                                      height: 15,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Create new account",
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .arrow_right_alt_sharp,
                                                              size: 18)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Create Sector Leader Account",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {},
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.qr_code,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Scan QR code",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 233, 236, 239),
                                                    title: Center(
                                                      child: Material(
                                                        elevation: 5,
                                                        shape:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        child: TextField(
                                                          controller:
                                                              sectorController,
                                                          focusNode: sectorNode,
                                                          decoration: InputDecoration(
                                                              hintText: isAdd
                                                                  ? "Insert new sector here"
                                                                  : "Insert sector you want to remove",
                                                              hintStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
                                                        ),
                                                      ),
                                                    ),
                                                    content: SizedBox(
                                                      height: 120,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow),
                                                              onPressed:
                                                                  () async {
                                                                if (isAdd) {
                                                                  List sectorList = await HelperFunctions().fetchCatagoires(
                                                                      "catagories",
                                                                      "sectors",
                                                                      "sectors");
                                                                  sectorList.add(
                                                                      sectorController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "sectors")
                                                                      .set({
                                                                    "sectors":
                                                                        sectorList
                                                                  });
                                                                } else {
                                                                  List sectorList = await HelperFunctions().fetchCatagoires(
                                                                      "catagories",
                                                                      "sectors",
                                                                      "sectors");
                                                                  sectorList.remove(
                                                                      sectorController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "sectors")
                                                                      .set({
                                                                    "sectors":
                                                                        sectorList
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                  isAdd
                                                                      ? "Add"
                                                                      : "Remove",
                                                                  style: const TextStyle(
                                                                      letterSpacing:
                                                                          1.5 +
                                                                              1,
                                                                      color: Colors
                                                                          .black))),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text("or"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                isAdd = !isAdd;
                                                              });
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              height: 20,
                                                              child: Text(
                                                                  "Remove Sector",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ));
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Add and remove sectors",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 233, 236, 239),
                                                    title: Center(
                                                      child: Material(
                                                        elevation: 5,
                                                        shape:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        child: TextField(
                                                          controller:
                                                              roleController,
                                                          focusNode: roleNode,
                                                          decoration: InputDecoration(
                                                              hintText: isAdd
                                                                  ? "Insert new role here"
                                                                  : "Insert role you want to remove",
                                                              hintStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
                                                        ),
                                                      ),
                                                    ),
                                                    content: SizedBox(
                                                      height: 120,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow),
                                                              onPressed:
                                                                  () async {
                                                                if (isAdd) {
                                                                  List
                                                                      roleList =
                                                                      await HelperFunctions().fetchCatagoires(
                                                                          "catagories",
                                                                          "roles",
                                                                          "roles");
                                                                  roleList.add(
                                                                      roleController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "roles")
                                                                      .set({
                                                                    "roles":
                                                                        roleList
                                                                  });
                                                                } else {
                                                                  List
                                                                      roleList =
                                                                      await HelperFunctions().fetchCatagoires(
                                                                          "catagories",
                                                                          "roles",
                                                                          "roles");
                                                                  roleList.remove(
                                                                      roleController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "roles")
                                                                      .set({
                                                                    "roles":
                                                                        roleList
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                  isAdd
                                                                      ? "Add"
                                                                      : "Remove",
                                                                  style: const TextStyle(
                                                                      letterSpacing:
                                                                          1.5 +
                                                                              1,
                                                                      color: Colors
                                                                          .black))),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text("or"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                isAdd = !isAdd;
                                                              });
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              height: 20,
                                                              child: Text(
                                                                  "Remove role",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ));
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Add and remove roles",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Material(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 233, 236, 239),
                                                    title: Center(
                                                      child: Material(
                                                        elevation: 5,
                                                        shape:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        child: TextField(
                                                          controller:
                                                              departmentController,
                                                          focusNode:
                                                              departmentNode,
                                                          decoration: InputDecoration(
                                                              hintText: isAdd
                                                                  ? "Insert new department here"
                                                                  : "Insert department you want to remove",
                                                              hintStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              fillColor:
                                                                  Colors.white,
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
                                                        ),
                                                      ),
                                                    ),
                                                    content: SizedBox(
                                                      height: 120,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow),
                                                              onPressed:
                                                                  () async {
                                                                if (isAdd) {
                                                                  List depatmentsList = await HelperFunctions().fetchCatagoires(
                                                                      "catagories",
                                                                      "depatments",
                                                                      "depatments");
                                                                  depatmentsList.add(
                                                                      departmentController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "depatments")
                                                                      .set({
                                                                    "depatments":
                                                                        depatmentsList
                                                                  });
                                                                } else {
                                                                  List roleList = await HelperFunctions().fetchCatagoires(
                                                                      "catagories",
                                                                      "depatments",
                                                                      "depatments");
                                                                  roleList.remove(
                                                                      departmentController
                                                                          .value
                                                                          .text);

                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "catagories")
                                                                      .doc(
                                                                          "depatments")
                                                                      .set({
                                                                    "depatments":
                                                                        roleList
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                  isAdd
                                                                      ? "Add"
                                                                      : "Remove",
                                                                  style: const TextStyle(
                                                                      letterSpacing:
                                                                          1.5 +
                                                                              1,
                                                                      color: Colors
                                                                          .black))),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text("or"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                isAdd = !isAdd;
                                                              });
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              height: 20,
                                                              child: Text(
                                                                  "Remove department",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ));
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 70,
                                          color: Colors.black,
                                        ),
                                        Text("Add and remove depatments",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300))
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
