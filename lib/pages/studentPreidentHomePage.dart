import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/models/member.dart';
import 'package:id_app/pages/President%20Account/view_account.dart';
import 'package:id_app/pages/QR_scanner.dart';
import 'package:id_app/pages/createSectorAccountPage.dart';
import 'package:id_app/pages/studentInfoPage.dart';
import 'package:id_app/pages/viewMembersPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/ProvideApi.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class StudentPreidentHomePage extends StatefulWidget {
  const StudentPreidentHomePage({super.key});

  @override
  State<StudentPreidentHomePage> createState() =>
      _StudentPreidentHomePageState();
}

AnimationController? _controller;
bool isAdd = true;
TextEditingController sectorController = TextEditingController();
FocusNode sectorNode = FocusNode();
TextEditingController roleController = TextEditingController();
FocusNode roleNode = FocusNode();
TextEditingController departmentController = TextEditingController();
FocusNode departmentNode = FocusNode();
TextEditingController _searchController = TextEditingController();
FocusNode _searchNode = FocusNode();
late StreamSubscription? subscription;
bool isAlert = false;
bool isDeviceConnected = false;

class _StudentPreidentHomePageState extends State<StudentPreidentHomePage>
    with SingleTickerProviderStateMixin {
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

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.to(() => const ViewAccount());
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 20,
                child: Icon(
                  Icons.person,
                  size: 25,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () async {
                    await signOut();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    size: 30,
                  )),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 233, 236, 239),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 233, 236, 239),
        body: FutureBuilder(
          future: initateData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            } else if (snapshot.data == true) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 10,
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            Provider.of<CreateAccountButtonBuilder>(
                                                    context,
                                                    listen: false)
                                                .passValue(true, "Add Member");
                                            Provider.of<HeadingController>(
                                                    context,
                                                    listen: false)
                                                .headingController(
                                                    "Add Member");
                                            Get.to(
                                                () =>
                                                    const SectorAccountCreate(),
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
                                                      fontWeight:
                                                          FontWeight.w300))
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () async {
                                            Provider.of<SelectStudentPageBuilder>(
                                                    context,
                                                    listen: false)
                                                .passValue(false, "Members");
                                            Get.to(
                                                () => const ViewMembersPage(),
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
                                                      fontWeight:
                                                          FontWeight.w300))
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                                Consumer<MembersData>(
                                  builder: (context, data, child) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Material(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: BeveledRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3))),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) =>
                                                            AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              236,
                                                              239),
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
                                                                _searchController,
                                                            focusNode:
                                                                _searchNode,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Enter the student ID",
                                                                hintStyle: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .yellow),
                                                                    onPressed:
                                                                        () async {
                                                                      // PdfApi()
                                                                      //     .generateMultiPage();
                                                                      int index = await HelperFunctions().getIndexById(
                                                                          data
                                                                              .membersList,
                                                                          _searchController
                                                                              .value
                                                                              .text);
                                                                      if (index !=
                                                                          -1) {
                                                                        Provider.of<studentInfoButtonBuilder>(listen: false, context).passValue(
                                                                            index,
                                                                            true,
                                                                            "Generate ID");
                                                                        Get.to(() =>
                                                                            const StudentInfoPage());
                                                                      } else if (index ==
                                                                          -1) {
                                                                        setState(
                                                                          () {
                                                                            _controller!.reset();
                                                                            _controller!.forward();
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Student doesn't exists")));
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        "Generate ID",
                                                                        style: TextStyle(
                                                                            letterSpacing: 1.5 +
                                                                                1,
                                                                            color: Colors
                                                                                .black)))
                                                                .animate(
                                                                    autoPlay:
                                                                        false,
                                                                    effects: const [
                                                                      ShakeEffect(
                                                                          duration:
                                                                              Duration(seconds: 1))
                                                                    ],
                                                                    controller:
                                                                        _controller),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text("or"),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Provider.of<SelectStudentPageBuilder>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .passValue(
                                                                        true,
                                                                        "Select Members");
                                                                Get.to(
                                                                    () =>
                                                                        const ViewMembersPage(),
                                                                    transition:
                                                                        Transition
                                                                            .fadeIn);
                                                              },
                                                              child:
                                                                  const SizedBox(
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
                                                                                TextDecoration.underline,
                                                                            fontWeight: FontWeight.w400)),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Icon(
                                                                        Icons
                                                                            .arrow_right_alt_sharp,
                                                                        size:
                                                                            18)
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
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
                                                        fontWeight:
                                                            FontWeight.w300))
                                              ],
                                            )),
                                      ),
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Appoint from existing account(Enter the student ID)",
                                                            hintStyle:
                                                                const TextStyle(
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
                                                              var studentId;
                                                              Provider.of<studentInfoButtonBuilder>(
                                                                      listen:
                                                                          false,
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
                                                                    listen:
                                                                        false)
                                                                .passValue(
                                                                    false,
                                                                    "Create Account");
                                                            Provider.of<HeadingController>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .headingController(
                                                                    "Create Sector Leader Account");
                                                            Get.to(
                                                                () =>
                                                                    const SectorAccountCreate(),
                                                                transition:
                                                                    Transition
                                                                        .fade);
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
                                                                            FontWeight.w400)),
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
                                              Text(
                                                  "Create Sector Leader Account",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300)),
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            Get.to(() => const QrPage());
                                          },
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
                                                      fontWeight:
                                                          FontWeight.w300))
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      233,
                                                                      236,
                                                                      239),
                                                              title: Center(
                                                                child: Material(
                                                                  elevation: 5,
                                                                  shape: const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        sectorController,
                                                                    focusNode:
                                                                        sectorNode,
                                                                    decoration: InputDecoration(
                                                                        hintText: isAdd
                                                                            ? "Insert new sector here"
                                                                            : "Insert sector you want to remove",
                                                                        hintStyle: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w300),
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide: BorderSide.none)),
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
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .yellow),
                                                                        onPressed:
                                                                            () async {
                                                                          if (isAdd) {
                                                                            List
                                                                                sectorList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "sectors", "sectors");
                                                                            if (!sectorList.contains(sectorController.value.text.trim())) {
                                                                              sectorList.add(sectorController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("sectors").set({
                                                                                "sectors": sectorList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully Added")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (sectorController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input sector")));
                                                                            } else if (sectorList.contains(sectorController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sector already exists")));
                                                                            }
                                                                          } else {
                                                                            List
                                                                                sectorList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "sectors", "sectors");
                                                                            if (sectorList.contains(sectorController.value.text.trim())) {
                                                                              sectorList.remove(sectorController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("sectors").set({
                                                                                "sectors": sectorList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully Removed")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (sectorController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input sector")));
                                                                            } else if (!sectorList.contains(sectorController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sector doesn't exists")));
                                                                            }
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Add"
                                                                                : "Remove",
                                                                            style:
                                                                                const TextStyle(letterSpacing: 1.5 + 1, color: Colors.black))),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Text(
                                                                        "or"),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isAdd =
                                                                              !isAdd;
                                                                        });
                                                                      },
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            20,
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Remove Sector"
                                                                                : "Add sector",
                                                                            style:
                                                                                const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w400)),
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
                                                      fontWeight:
                                                          FontWeight.w300))
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      233,
                                                                      236,
                                                                      239),
                                                              title: Center(
                                                                child: Material(
                                                                  elevation: 5,
                                                                  shape: const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        roleController,
                                                                    focusNode:
                                                                        roleNode,
                                                                    decoration: InputDecoration(
                                                                        hintText: isAdd
                                                                            ? "Insert new role here"
                                                                            : "Insert role you want to remove",
                                                                        hintStyle: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w300),
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide: BorderSide.none)),
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
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .yellow),
                                                                        onPressed:
                                                                            () async {
                                                                          if (isAdd) {
                                                                            List
                                                                                roleList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "roles", "roles");
                                                                            if (!roleList.contains(roleController.value.text.trim())) {
                                                                              roleList.add(roleController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("roles").set({
                                                                                "roles": roleList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully Added")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (roleController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input role")));
                                                                            } else if (roleList.contains(roleController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("role already exists")));
                                                                            }
                                                                          } else {
                                                                            List
                                                                                roleList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "roles", "roles");
                                                                            if (roleList.contains(roleController.value.text.trim())) {
                                                                              roleList.remove(roleController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("roles").set({
                                                                                "roles": roleList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully removed")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (roleController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input role")));
                                                                            } else if (!roleList.contains(roleController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("role doesn't exists")));
                                                                            }

                                                                            //      initiateDataStream();
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Add"
                                                                                : "Remove",
                                                                            style:
                                                                                const TextStyle(letterSpacing: 1.5 + 1, color: Colors.black))),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Text(
                                                                        "or"),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isAdd =
                                                                              !isAdd;
                                                                        });
                                                                      },
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            20,
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Remove role"
                                                                                : "Add role",
                                                                            style:
                                                                                const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w400)),
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
                                                      fontWeight:
                                                          FontWeight.w300))
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
                                                      BorderRadius.circular(
                                                          3))),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      233,
                                                                      236,
                                                                      239),
                                                              title: Center(
                                                                child: Material(
                                                                  elevation: 5,
                                                                  shape: const OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        departmentController,
                                                                    focusNode:
                                                                        departmentNode,
                                                                    decoration: InputDecoration(
                                                                        hintText: isAdd
                                                                            ? "Insert new department here"
                                                                            : "Insert department you want to remove",
                                                                        hintStyle: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w300),
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide: BorderSide.none)),
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
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .yellow),
                                                                        onPressed:
                                                                            () async {
                                                                          if (isAdd) {
                                                                            List
                                                                                depatmentsList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "departments", "departments");
                                                                            if (!depatmentsList.contains(departmentController.value.text.trim())) {
                                                                              depatmentsList.add(departmentController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("departments").set({
                                                                                "departments": depatmentsList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully Added")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (departmentController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input department")));
                                                                            } else if (depatmentsList.contains(departmentController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("department already exists")));
                                                                            }
                                                                          } else {
                                                                            List
                                                                                departmentList =
                                                                                await HelperFunctions().fetchCatagoires("catagories", "departments", "departments");
                                                                            if (departmentList.contains(departmentController.value.text.trim())) {
                                                                              departmentList.remove(departmentController.value.text.toUpperCase().trim());

                                                                              await FirebaseFirestore.instance.collection("catagories").doc("departments").set({
                                                                                "departments": departmentList
                                                                              }).then((value) {
                                                                                Provider.of<MembersData>(context, listen: false).initateData();
                                                                              }).then((value) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully removed")));
                                                                                Get.back();
                                                                              });
                                                                            } else if (departmentController.value.text.trim().isEmpty) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("please input department")));
                                                                            } else if (!departmentList.contains(departmentController.value.text.trim())) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("department doesn't exists")));
                                                                            }
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Add"
                                                                                : "Remove",
                                                                            style:
                                                                                const TextStyle(letterSpacing: 1.5 + 1, color: Colors.black))),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Text(
                                                                        "or"),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isAdd =
                                                                              !isAdd;
                                                                        });
                                                                      },
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            20,
                                                                        child: Text(
                                                                            isAdd
                                                                                ? "Remove department"
                                                                                : "Add department",
                                                                            style:
                                                                                const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w400)),
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
                                                      fontWeight:
                                                          FontWeight.w300))
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
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const Text("something went wrong"),
              );
            }
          },
        ));
  }

  Future<List<Member>> fetchMemberData() async {
    final memberList = <Member>[]; // Create an empty list

    try {
      final collection = FirebaseFirestore.instance.collection('members');
      final snapshot = await collection.get();

      for (final doc in snapshot.docs) {
        final data = doc.data(); // Cast to Map

        final member = Member(
          lastName: data['fullName'] as String,
          firstName: data['fullName'] as String,
          department: data['department'] as String,
          studentId: data['studentId'] as String,
          role: data['role'] as String,
          gender: data['gender'] as String,
          sector: data['sector'] as String,
          studentPhoto: data['studentPhoto'] as String,
        );

        memberList.add(member);
      }

      // memberList is now populated with Member objects
    } catch (error) {
      print("Error fetching data: $error");
    }
    return memberList;
  }

  Future<bool> initateData() async {
    bool success = false;
    try {
      Provider.of<MembersData>(context, listen: false).membersList =
          await fetchMemberData();

      Provider.of<MembersData>(context, listen: false).departmentList =
          await HelperFunctions().fetchCatagoires(
              "catagories", "departments", "departments") as List<String>;
      Provider.of<MembersData>(context, listen: false).roleList =
          await HelperFunctions()
              .fetchCatagoires("catagories", "roles", "roles") as List<String>;
      Provider.of<MembersData>(context, listen: false).sectorList =
          await HelperFunctions().fetchCatagoires(
              "catagories", "sectors", "sectors") as List<String>;

      success = true;
    } catch (e) {
      print(e.toString());
    }
    return success;
  }

  // Stream<bool> initiateDataStream() async* {
  //   try {
  //     yield* Stream.fromFuture(fetchMemberData()).asyncMap((membersList) {
  //       Provider.of<MembersData>(context, listen: false).membersList =
  //           membersList;
  //       return true; // Emit a "true" event for successful member data fetch
  //     });
  //     yield* Stream.fromFuture(HelperFunctions()
  //             .fetchCatagoires("catagories", "departments", "departments"))
  //         .asyncMap((department) {
  //       Provider.of<MembersData>(context, listen: false).departmentList =
  //           department as List<String>;
  //       return true; // Emit a "true" event for successful member data fetch
  //     });

  //     yield* Stream.fromFuture(
  //             HelperFunctions().fetchCatagoires("catagories", "roles", "roles"))
  //         .asyncMap((role) {
  //       Provider.of<MembersData>(context, listen: false).roleList =
  //           role as List<String>;
  //       return true; // Emit a "true" event for successful member data fetch
  //     });
  //     yield* Stream.fromFuture(HelperFunctions()
  //             .fetchCatagoires("catagories", "sectors", "sectors"))
  //         .asyncMap((sector) {
  //       Provider.of<MembersData>(context, listen: false).sectorList =
  //           sector as List<String>;
  //       return true; // Emit a "true" event for successful member data fetch
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     yield false; // Emit a "false" event if any error occurs
  //   }
  // }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // Optionally navigate to login screen or handle state change
  }
}
