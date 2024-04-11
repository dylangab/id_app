import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/pdf.dart';
import 'package:id_app/models/member.dart';
import 'package:id_app/models/studentPreident.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
import 'package:gif_view/gif_view.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';

import 'package:id_app/pages/studentInfoPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

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
String passSector = "";
String passRole = "";
String passDepartment = "";
bool depVisibile = false;
bool roleVisible = false;
bool secVisible = false;
TextEditingController _roleController = TextEditingController();
FocusNode _roleNode = FocusNode();
TextEditingController _sectorController = TextEditingController();
FocusNode _sectorNode = FocusNode();
TextEditingController _departmentController = TextEditingController();
FocusNode _department = FocusNode();
List<Member> selectedStudent = [];
RoundedLoadingButtonController _buttonController =
    RoundedLoadingButtonController();
bool A4Selected = true;
bool scrollSelected = false;
final uid = FirebaseAuth.instance.currentUser!.uid;

class _ViewMembersPageState extends State<ViewMembersPage> {
  @override
  void initState() {
    super.initState();
  }

  void handleSelection(dynamic member) {
    setState(() {
      if (selectedStudent.contains(member)) {
        selectedStudent.remove(member);
      } else {
        selectedStudent.add(member);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: Consumer<MembersData>(
        builder: (context, data, child) => ListView(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "filter by :",
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data.depVisibile = !data.depVisibile;
                                data.filterByDepartment =
                                    !data.filterByDepartment;
                              });
                            },
                            child: Text("Departments",
                                style: TextStyle(
                                    fontWeight: data.depVisibile
                                        ? FontWeight.bold
                                        : FontWeight.w300,
                                    fontSize: 16,
                                    color: data.depVisibile
                                        ? Colors.yellow
                                        : Colors.black)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data.roleVisible = !data.roleVisible;
                                data.filterByRole = !data.filterByRole;
                              });
                            },
                            child: Text("Roles",
                                style: TextStyle(
                                    fontWeight: data.roleVisible
                                        ? FontWeight.bold
                                        : FontWeight.w300,
                                    fontSize: 16,
                                    color: data.roleVisible
                                        ? Colors.yellow
                                        : Colors.black)),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  data.secVisible = !data.secVisible;
                                  data.filterBySector = !data.filterBySector;
                                });
                              },
                              child: Text("Sectors",
                                  style: TextStyle(
                                      fontWeight: data.secVisible
                                          ? FontWeight.bold
                                          : FontWeight.w300,
                                      fontSize: 16,
                                      color: data.secVisible
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
                Column(children: [
                  Visibility(
                      maintainSize: false,
                      maintainState: false,
                      visible: data.depVisibile,
                      child: SizedBox(
                          width: 350,
                          height: 50,
                          child: DropdownButtonHideUnderline(
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
                              items: data.departmentList
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
                                  passDepartment = value.toString();
                                });
                                // Provider.of<MembersData>(context, listen: false)
                                //     .filterData(
                                //         passSector, passRole, value.toString());
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
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
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
                          ))),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                      maintainSize: false,
                      maintainState: false,
                      visible: data.secVisible,
                      child: SizedBox(
                          width: 350,
                          height: 50,
                          child: DropdownButtonHideUnderline(
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
                              items: data.sectorList
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
                                  passSector = value.toString();
                                });
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
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
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
                          ))),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainState: false,
                    visible: data.roleVisible,
                    child: SizedBox(
                        width: 350,
                        height: 50,
                        child: DropdownButtonHideUnderline(
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
                            items: data.roleList
                                .map((String item) => DropdownMenuItem<String>(
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
                                passRole = value.toString();
                              });
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
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
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
                        )),
                  ),
                ]),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<SelectStudentPageBuilder>(
            builder: (context, value, child) => Center(
              child: Text(value.header,
                  style: const TextStyle(
                    fontSize: 25,
                    letterSpacing: 1.5 + 1,
                  )),
            ),
          ),
          SizedBox(
              height: 500,
              child: FutureBuilder(
                future: data.filterData(passSector, passRole, passDepartment),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.yellow,
                        ));
                  } else if (snapshot.hasData) {
                    List<Member> result = snapshot.data!;
                    return AnimationConfiguration.staggeredList(
                        position: 0,
                        child: ScaleAnimation(
                            child: FadeInAnimation(
                          child: ListView.builder(
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                return Consumer<SelectStudentPageBuilder>(
                                  builder: (context, value, child) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 20, 15, 0),
                                    child: Material(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide.none),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide.none),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              result[index].studentPhoto!),
                                        ),
                                        title: Text(result[index].firstName!),
                                        subtitle:
                                            Text(result[index].studentId!),
                                        trailing: Visibility(
                                            visible: value.builder,
                                            maintainSize: false,
                                            maintainState: false,
                                            child: selectedStudent.contains(
                                                    data.membersList[index])
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.yellow,
                                                  )
                                                : const Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.grey,
                                                  )),
                                        onTap: () {
                                          bool select = Provider.of<
                                                      SelectStudentPageBuilder>(
                                                  context,
                                                  listen: false)
                                              .builder;
                                          if (select) {
                                            setState(() {
                                              if (!selectedStudent.contains(
                                                  data.membersList[index])) {
                                                selectedStudent.add(
                                                    data.membersList[index]);
                                              } else if (selectedStudent
                                                  .contains(data
                                                      .membersList[index])) {
                                                selectedStudent.removeWhere(
                                                    (element) =>
                                                        element ==
                                                        data.membersList[
                                                            index]);
                                              }
                                            });
                                          } else {
                                            Provider.of<studentInfoButtonBuilder>(
                                                    listen: false, context)
                                                .passValue(index, false,
                                                    "Generate ID");
                                            Get.to(
                                                () => const StudentInfoPage());
                                          }
                                        },
                                        onLongPress: () {
                                          bool select = Provider.of<
                                                      SelectStudentPageBuilder>(
                                                  context,
                                                  listen: false)
                                              .builder;
                                          if (select) {
                                            Provider.of<studentInfoButtonBuilder>(
                                                    listen: false, context)
                                                .passValue(index, false,
                                                    "Generate ID");
                                            Get.to(
                                                () => const StudentInfoPage());
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )));
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text("No members"),
                    );
                  }
                },
              )),
          const SizedBox(
            height: 15,
          ),
          Consumer<SelectStudentPageBuilder>(
            builder: (context, value, child) => Visibility(
              visible: value.builder,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      color: Colors.white,
                      elevation: 5,
                      shape:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Choose print layout",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5 + 1,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1.5)),
                                  child: const Image(
                                    image: AssetImage('assets/gif/A4.gif'),
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Image(
                                  image: AssetImage('assets/gif/scroll.gif'),
                                  width: 150,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (!scrollSelected) {
                                          A4Selected = !A4Selected;
                                        } else if (scrollSelected) {
                                          scrollSelected = false;
                                          A4Selected = !A4Selected;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: A4Selected
                                          ? Colors.yellow
                                          : Colors.grey,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (!A4Selected) {
                                          scrollSelected = !scrollSelected;
                                        } else if (A4Selected) {
                                          A4Selected = false;
                                          scrollSelected = !scrollSelected;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: scrollSelected
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 30),
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
                            StudentPreident? studentPreident;
                            studentPreident =
                                await Provider.of<StudentPresidentDataFetch>(
                                        context,
                                        listen: false)
                                    .getStudentData(uid);
                            if (A4Selected) {
                              try {
                                await PdfApi().generateMultiPage(
                                    selectedStudent, studentPreident!);

                                _buttonController.start();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                selectedStudent = [];
                                _buttonController.stop();

                                Get.to(() => const StudentPreidentHomePage());
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                                _buttonController.stop();
                              }
                            } else if (scrollSelected) {
                              try {
                                await PdfApi().generateMultiId(
                                    selectedStudent, studentPreident!);

                                _buttonController.start();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                selectedStudent = [];
                                _buttonController.stop();

                                Get.to(() => const StudentPreidentHomePage());
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                                _buttonController.stop();
                              }
                            } else if (!A4Selected && !scrollSelected) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please choose Print layout")));
                              _buttonController.stop();
                            }
                          },
                          child: Text(
                            "Generate IDs (${selectedStudent.length})",
                            style: const TextStyle(
                                fontSize: 15,
                                letterSpacing: 1.5 + 1,
                                color: Colors.black),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
