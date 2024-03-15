import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_app/models/member.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:dotted_border/dotted_border.dart';

class SectorAccountCreate extends StatefulWidget {
  const SectorAccountCreate({super.key});

  @override
  State<SectorAccountCreate> createState() => _SectorAccountCreateState();
}

String gender = "male";
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
bool isLoading = false;
double? _animationValue;

@override
void initState() {
  _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 1));
}

class _SectorAccountCreateState extends State<SectorAccountCreate>
    with SingleTickerProviderStateMixin {
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
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Department",
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
                      child: TextFormField(
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
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Role",
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
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Sector",
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
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            //   isUploaded = true;
                            isLoading = true;
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
                                                const Duration(seconds: 1),
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
                                              ? const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.done_rounded,
                                                      size: 30,
                                                      color: Colors.yellow,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Photo name.....",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300),
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
                              // child: isUploaded
                              //     ? Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           Icon(
                              //             Icons.done_rounded,
                              //             size: 30,
                              //             color: Colors.yellow,
                              //           ),
                              //           SizedBox(
                              //             height: 10,
                              //           ),
                              //           Text(
                              //             "Photo name.....",
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.w300),
                              //           )
                              //         ],
                              //       )
                              //     : const Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           Icon(
                              //             color: Colors.black,
                              //             Icons.upload_file_sharp,
                              //             size: 30,
                              //           ),
                              //           SizedBox(
                              //             height: 10,
                              //           ),
                              //           Text("Upload your student image")
                              //         ],
                              //       ),
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
                                XFile? file;
                                String? image;
                                ImagePicker imagePicker = ImagePicker();
                                file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                // Member member = Member(
                                //     firstName: "",
                                //     lastName: "",
                                //     department: "",
                                //     gender: gender,
                                //     role: "",
                                //     sector: "",
                                //     studentId: "",
                                //     studentPhoto: "");

                                // await CreateMemberAccount()
                                //     .createMemeberAccount(member);
                                print(file!.name.toString());
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
