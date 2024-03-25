import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/pages/createSectorAccountPage.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/pages/SearchPage.dart';
import 'package:id_app/pages/studentInfoPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:switcher_button/switcher_button.dart';

class ViewMembersPage extends StatefulWidget {
  const ViewMembersPage({super.key});

  @override
  State<ViewMembersPage> createState() => _ViewMembersPageState();
}

List<String> roleItems = [];
List<String> sectors = [];
List<String> departments = [];
bool filterByDepartment = false;
bool filterBySector = false;
bool filterByRole = false;
bool filter = false;
String? sectorValue;
String? roleValue;
String? departmentValue;
bool depVisibile = false;
bool roleVisible = false;
bool secVisible = false;
TextEditingController _roleController = TextEditingController();
FocusNode _roleNode = FocusNode();
TextEditingController _sectorController = TextEditingController();
FocusNode _sectorNode = FocusNode();
TextEditingController _departmentController = TextEditingController();
FocusNode _department = FocusNode();

class _ViewMembersPageState extends State<ViewMembersPage> {
  void fetchdata() async {
    departments = await HelperFunctions().fetchCatagoires(
        "catagories", "departments", "departments") as List<String>;
    sectors = await HelperFunctions()
        .fetchCatagoires("catagories", "sectors", "sectors") as List<String>;
    roleItems = await HelperFunctions()
        .fetchCatagoires("catagories", "roles", "roles") as List<String>;
  }

  @override
  void initState() {
    //  fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          /* const SizedBox(
          height: 190,
        ),*/
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 236, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "filter by :",
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                depVisibile = !depVisibile;
                                filterByDepartment = !filterByDepartment;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("Departments",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: depVisibile
                                          ? Colors.yellow
                                          : Colors.black)),
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                roleVisible = !roleVisible;
                                filterByRole = !filterByRole;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Text("Roles",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: roleVisible
                                          ? Colors.yellow
                                          : Colors.black)),
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                secVisible = !secVisible;
                                filterBySector = !filterBySector;
                              });
                            },
                            child: Text("Sectors",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: secVisible
                                        ? Colors.yellow
                                        : Colors.black))),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Visibility(
                    maintainSize: false,
                    maintainState: false,
                    visible: depVisibile,
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("catagories")
                            .doc("departments")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            departments =
                                (snapshot.data!["departments"] as List<dynamic>)
                                    .cast<String>();
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: departmentValue,
                                focusNode: _department,
                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Department",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                items: departments
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    departmentValue = value.toString();
                                  });
                                  Provider.of<ValuePass>(context, listen: false)
                                      .departmentValuePass(value.toString());
                                },
                                buttonStyleData: ButtonStyleData(
                                    width: 130,
                                    height: 65,
                                    elevation: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          style: BorderStyle.none,
                                        ))),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    )),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: _departmentController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _departmentController,
                                      focusNode: _department,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase());
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Text("error");
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainState: false,
                    visible: secVisible,
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("catagories")
                            .doc("sectors")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            sectors =
                                (snapshot.data!["sectors"] as List<dynamic>)
                                    .cast<String>();
                            print(sectors);
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: sectorValue,
                                focusNode: _sectorNode,
                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Sectors",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                items: sectors
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    sectorValue = value.toString();
                                  });
                                  Provider.of<ValuePass>(context, listen: false)
                                      .sectorValuePass(value.toString());
                                },
                                buttonStyleData: ButtonStyleData(
                                    width: 130,
                                    height: 65,
                                    elevation: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          style: BorderStyle.none,
                                        ))),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    // width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    )),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: _sectorController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _sectorController,
                                      focusNode: _sectorNode,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase());
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Text("error");
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainState: false,
                    visible: roleVisible,
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("catagories")
                            .doc("roles")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            roleItems =
                                (snapshot.data!["roles"] as List<dynamic>)
                                    .cast<String>();
                            print(sectors);
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: roleValue,
                                focusNode: _roleNode,
                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "roles",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                items: roleItems
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    roleValue = value.toString();
                                  });
                                  Provider.of<ValuePass>(context, listen: false)
                                      .roleValuePass(value.toString());
                                },
                                buttonStyleData: ButtonStyleData(
                                    width: 130,
                                    height: 65,
                                    elevation: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          style: BorderStyle.none,
                                        ))),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    // width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    )),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: _roleController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: _roleController,
                                      focusNode: _roleNode,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase());
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const Text("error");
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [

              //     Visibility(
              //       maintainState: false,
              //       maintainSize: false,
              //       visible: secVisible,
              //       child: SizedBox(
              //         width: 100,
              //         height: 50,
              //         child: FutureBuilder(
              //           future: FirebaseFirestore.instance
              //               .collection("catagories")
              //               .doc("sectors")
              //               .get(),
              //           builder: (context, snapshot) {
              //             if (snapshot.connectionState ==
              //                 ConnectionState.waiting) {
              //               return const SizedBox(
              //                 height: 15,
              //                 width: 15,
              //                 child: CircularProgressIndicator(
              //                   color: Colors.yellow,
              //                 ),
              //               );
              //             } else if (snapshot.hasData) {
              //               sectors =
              //                   (snapshot.data!["sectors"] as List<dynamic>)
              //                       .cast<String>();
              //               return CustomDropdown(
              //                 hintText: "Sectors",
              //                 //  initialItem: Sectors[0],
              //                 items: sectors,
              //                 onChanged: (p0) {
              //                   setState(() {
              //                     sectorValue = p0;
              //                   });
              //                 },
              //               );
              //             } else {
              //               return const Text("error");
              //             }
              //           },
              //         ),
              //       ),
              //     ),
              //     Visibility(
              //       maintainState: false,
              //       maintainSize: false,
              //       visible: roleVisible,
              //       child: SizedBox(
              //         width: 100,
              //         height: 50,
              //         child: FutureBuilder(
              //           future: FirebaseFirestore.instance
              //               .collection("catagories")
              //               .doc("roles")
              //               .get(),
              //           builder: (context, snapshot) {
              //             if (snapshot.connectionState ==
              //                 ConnectionState.waiting) {
              //               return const SizedBox(
              //                 height: 15,
              //                 width: 15,
              //                 child: CircularProgressIndicator(
              //                   color: Colors.yellow,
              //                 ),
              //               );
              //             } else if (snapshot.hasData) {
              //               roleItems =
              //                   (snapshot.data!["roles"] as List<dynamic>)
              //                       .cast<String>();
              //               return CustomDropdown<String>(
              //                 hintText: "role",
              //                 items: roleItems,
              //                 onChanged: (p0) {
              //                   Provider.of<ValuePass>(context, listen: false)
              //                       .valuePass(p0);
              //                   setState(() {
              //                     filterByRole = true;
              //                     filter = true;
              //                   });
              //                 },
              //               );
              //             } else {
              //               return const Text("error");
              //             }
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: Text("Members",
              style: TextStyle(
                fontSize: 30 - 5,
                letterSpacing: 1.5 + 1,
              )),
        ),
        Expanded(
            child: Consumer<ValuePass>(
          builder: (context, value, child) => FutureBuilder(
            future: filterData(
                value.sectorValue, value.roleValue, value.departmentValue),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                );
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List? members = snapshot.data;
                return Container(
                  child: AnimationConfiguration.staggeredList(
                    position: 0,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return studentListTile(
                                members![index]["fullName"],
                                members[index]["studentId"],
                                members[index]["studentPhoto"],
                                members[index]["studentId"]);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  child: const Center(child: Text("error")),
                );
              }
            },
            // child: Container(
            //   decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            //   child: AnimationConfiguration.staggeredList(
            //     position: 0,
            //     child: ScaleAnimation(
            //       child: FadeInAnimation(
            //         child: ListView.builder(
            //           itemCount: members.length,
            //           itemBuilder: (context, index) {
            //             return studentListTile(
            //                 members[index]["fullName"],
            //                 members[index]["studentId"],
            //                 members[index]["studentPhoto"],
            //                 members[index]["studentId"]);
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ))
      ]),
    );
  }

  Widget studentListTile(String? name, phoneNo, String photo, String id) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), side: BorderSide.none),
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide.none),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(photo),
          ),
          title: Text("$name"),
          subtitle: Text("$phoneNo"),
          onTap: () {
            Provider.of<studentInfoButtonBuilder>(listen: false, context)
                .passValue(id, false, "Generate ID");
            Get.to(() => const StudentInfoPage());
          },
        ),
      ),
    );
  }

  Future<List> filterData(String sector, String role, String department) async {
    List<Map<String, dynamic>> result = [];
    if (filterByDepartment || filterByRole || filterBySector) {
      if (filterByDepartment && filterByRole && filterBySector) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("department", isEqualTo: department)
            .where("role", isEqualTo: role)
            .where("sector", isEqualTo: sector)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterByDepartment && filterByRole) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("department", isEqualTo: department)
            .where("role", isEqualTo: role)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterByDepartment && filterBySector) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("department", isEqualTo: department)
            .where("sector", isEqualTo: sector)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterByRole && filterBySector) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("sector", isEqualTo: sector)
            .where("role", isEqualTo: role)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterByDepartment) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("department", isEqualTo: department)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterByRole) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("role", isEqualTo: role)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      } else if (filterBySector) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("members")
            .where("sector", isEqualTo: sector)
            .get();
        final documents = querySnapshot.docs;

        // Extract data from each document
        result = documents.map((doc) => doc.data()).toList();
      }
    } else {
      final querySnapshot =
          await FirebaseFirestore.instance.collection("members").get();
      final documents = querySnapshot.docs;

      // Extract data from each document
      result = documents.map((doc) => doc.data()).toList();
    }

    return result;
  }
}

// All Members

class demo {
  String? name, phoneNo;
  bool? isselected;
  demo({
    required this.name,
    required this.phoneNo,
    required this.isselected,
  });
}
