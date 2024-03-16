import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_app/Utils/Widgets/dropdownButton.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/models/member.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SectorAccountCreate extends StatefulWidget {
  const SectorAccountCreate({super.key});

  @override
  State<SectorAccountCreate> createState() => _SectorAccountCreateState();
}

String gender = "male";
String? RoleValue;
String? sectorValue;
String? departmentValue;
bool isUploaded = false;
AnimationController? _animationController;
FocusNode _maleRadioButton = FocusNode();
FocusNode _femaleRadioButton = FocusNode();
TextEditingController _emailController = TextEditingController();
FocusNode _emailNode = FocusNode();
TextEditingController _passwordController = TextEditingController();
FocusNode _passwordNode = FocusNode();
TextEditingController _departmentController = TextEditingController();
FocusNode _department = FocusNode();
TextEditingController _studentIdController = TextEditingController();
FocusNode _studentIdNode = FocusNode();
TextEditingController _confirmPasswordController = TextEditingController();
FocusNode _confirmPasswordNode = FocusNode();
TextEditingController _firstNameController = TextEditingController();
FocusNode _firstNode = FocusNode();
TextEditingController _lastNameController = TextEditingController();
FocusNode _LastNode = FocusNode();
TextEditingController _roleController = TextEditingController();
FocusNode _roleNode = FocusNode();
TextEditingController _sectorController = TextEditingController();
FocusNode _sectorNode = FocusNode();
bool isLoading = false;
double? _animationValue;
XFile? file;
String? image;
final List<String> Roleitems = [
  'Club Presidents',
  'Vice Presidents',
  'Treasurers',
  'Secretaries',
  'Event Coordinators',
  'Marketing/Publicity Officers',
  'Membership Coordinators',
];
final List<String> sectors = [
  'Student Government/Student Council',
  'Clubs and Organizations',
  'Recreational Facilities',
  'Student Services',
  'Events and Programming',
  'Food Services and Dining',
  'Student Publications and Media',
  'Volunteer and Community Engagement',
  'Student Advocacy and Support',
  'Financial Resources',
  'Technology and IT Services',
  'Student Union Facilities and Spaces'
];
final List<String> departments = [
  'History',
  'Philosophy',
  'Linguistics',
  'Theatre Arts/Drama',
  'Psychology',
  'Anthropology',
  'Political Science',
  'Economics',
  'Geology',
  'Computer Science',
  'Electrical Engineering',
  'Mechanical Engineering',
  'Civil Engineering',
  'Chemical Engineering',
  'Information Technology'
];

class _SectorAccountCreateState extends State<SectorAccountCreate>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController!.addListener(() {
      setState(() {
        _animationValue = _animationController!.value;
        if (_animationValue! >= 0.2 && _animationValue! < 0.5) {
          isLoading = true;
        } else if (_animationValue! > 0.5) {
          isLoading = false;
          isUploaded = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
    _firstNameController.dispose();
    _firstNode.dispose();
    _lastNameController.dispose();
    _LastNode.dispose();
    _studentIdController.dispose();
    _studentIdNode.dispose();
    _department.dispose();
    _departmentController.dispose();
    _sectorController.dispose();
    _sectorNode.dispose();
    _roleController.dispose();
    _roleNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadingController>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 236, 239),
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                value.heading.toString(),
                style: const TextStyle(
                  fontSize: 30 - 5,
                  letterSpacing: 1.5 + 1,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _firstNameController,
                        focusNode: _firstNode,
                        decoration: const InputDecoration(
                            hintText: "Student First Name",
                            helperStyle: TextStyle(fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _lastNameController,
                        focusNode: _LastNode,
                        decoration: const InputDecoration(
                            hintText: "Student last Name",
                            helperStyle: TextStyle(fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDropDownButton(
                          dropdownItems: departments,
                          hintText: "Department",
                          selectedValue: departmentValue,
                          searchController: _departmentController,
                          searchNode: _department),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _studentIdController,
                        focusNode: _studentIdNode,
                        decoration: const InputDecoration(
                            hintText: "Student ID",
                            helperStyle: TextStyle(fontWeight: FontWeight.w100),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                        elevation: 5,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomDropDownButton(
                            dropdownItems: Roleitems,
                            hintText: "Select your role",
                            selectedValue: RoleValue,
                            searchController: _roleController,
                            searchNode: _roleNode)),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 100,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(13, 14, 13, 0),
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        const Text("Male",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(
                                          width: 30,
                                          child: RadioListTile(
                                              focusNode: _maleRadioButton,
                                              fillColor:
                                                  const MaterialStatePropertyAll(
                                                Colors.yellow,
                                              ),
                                              value: "male",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                  print(value);
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        const Text("Female",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(
                                          width: 30,
                                          child: RadioListTile(
                                              focusNode: _femaleRadioButton,
                                              fillColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.yellow),
                                              value: "female",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                  print(value);
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      elevation: 5,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomDropDownButton(
                          dropdownItems: sectors,
                          hintText: "Sector",
                          selectedValue: sectorValue,
                          searchController: _sectorController,
                          searchNode: _sectorNode),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            ImagePicker imagePicker = ImagePicker();
                            file = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                          setState(() {
                            _animationController!.forward();
                          });
                        },
                        child: Material(
                          elevation: 5,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          child: DottedBorder(
                            strokeWidth: 1,
                            dashPattern: [5, 5],
                            radius: const Radius.circular(10),
                            color: Colors.yellow,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  isLoading
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 3),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                        )
                                      : AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          child: isUploaded
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.done_rounded,
                                                      size: 30,
                                                      color: Colors.yellow,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                                file!.name),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isUploaded =
                                                                      false;
                                                                  isLoading =
                                                                      false;
                                                                  _animationController!
                                                                      .reset();
                                                                  file = null;
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                                size: 20,
                                                              ))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      color: Colors.black,
                                                      Icons.upload_file_sharp,
                                                      size: 30,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        "Upload your student image")
                                                  ],
                                                ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<CreateAccountButtonBuilder>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 10),
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                String imageUrl = await HelperFunctions()
                                    .uploadImage(file, "student_picture");
                                Member member = Member(
                                    firstName: _firstNameController.value.text,
                                    lastName: _lastNameController.value.text,
                                    department: "",
                                    gender: gender,
                                    role: "",
                                    sector: "",
                                    studentId: "",
                                    studentPhoto: imageUrl);

                                // await CreateMemberAccount()
                                //     .createMemeberAccount(member);
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
                      );
                    },
                  )
                ],
              )),
            )
          ],
        ),
      );
    });
  }
}
