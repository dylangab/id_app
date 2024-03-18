import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class CreatePresidentAccount extends StatefulWidget {
  const CreatePresidentAccount({super.key});

  @override
  State<CreatePresidentAccount> createState() => _CreatePresidentAccountState();
}

final _formkey = GlobalKey<FormState>();
String gender = "male";
bool visabile = true;
RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();
String? departmentValue;

AnimationController? _studPicAnimationController;
AnimationController? _signAnimationController;
AnimationController? _stampPicAnimationController;
XFile? studentPic;
XFile? signiture;
XFile? stamp;
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
List<String> departments = [];
double? _studanimationValue;
double? _signAnimationValue;
double? _stampAnimationValue;
bool studisLoading = false;
bool studisUploaded = false;
bool signisLoading = false;
bool signisUploaded = false;
bool stampisLoading = false;
bool stampisUploaded = false;

class _CreatePresidentAccountState extends State<CreatePresidentAccount>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    fetchdata();
    super.initState();
    _studPicAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _studPicAnimationController!.addListener(() {
      setState(() {
        _studanimationValue = _studPicAnimationController!.value;
        if (_studanimationValue! >= 0.2 && _studanimationValue! < 0.5) {
          studisLoading = true;
        } else if (_studanimationValue! > 0.5) {
          studisLoading = false;
          studisUploaded = true;
        }
      });
    });
    _signAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _signAnimationController!.addListener(() {
      setState(() {
        _signAnimationValue = _signAnimationController!.value;
        if (_signAnimationValue! >= 0.2 && _signAnimationValue! < 0.5) {
          signisLoading = true;
        } else if (_signAnimationValue! > 0.5) {
          signisLoading = false;
          signisUploaded = true;
        }
      });
    });
    _stampPicAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _stampPicAnimationController!.addListener(() {
      setState(() {
        _stampAnimationValue = _stampPicAnimationController!.value;
        if (_stampAnimationValue! >= 0.2 && _stampAnimationValue! < 0.5) {
          stampisLoading = true;
        } else if (_stampAnimationValue! > 0.5) {
          stampisLoading = false;
          stampisUploaded = true;
        }
      });
    });
  }

  void fetchdata() async {
    departments = await HelperFunctions().fetchCatagoires(
        "catagories", "departments", "departments") as List<String>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              "Create President Account",
              style: TextStyle(
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
                key: _formkey,
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
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message = "First name should not be empty";
                            }
                            return message;
                          },
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
                              helperStyle:
                                  TextStyle(fontWeight: FontWeight.w300),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message = "Last name should not be empty";
                            }
                            return message;
                          },
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
                          controller: _studentIdController,
                          focusNode: _studentIdNode,
                          decoration: const InputDecoration(
                              hintText: "Student ID",
                              helperStyle:
                                  TextStyle(fontWeight: FontWeight.w100),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message = "Student Id should not be empty";
                            }
                            return message;
                          },
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            focusNode: _department,
                            hint: const Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Choose your department",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            items: departments
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
                            value: departmentValue,
                            onChanged: (value) {
                              setState(() {
                                departmentValue = value.toString();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                                width: MediaQuery.of(context).size.width,
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
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              ImagePicker imagePicker = ImagePicker();
                              studentPic = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            setState(() {
                              _studPicAnimationController!.forward();
                            });
                          },
                          child: Material(
                            elevation: 5,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            child: DottedBorder(
                              strokeWidth: 1,
                              dashPattern: const [5, 5],
                              radius: const Radius.circular(10),
                              color: Colors.yellow,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
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
                                    studisLoading
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 3),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                          )
                                        : AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 1),
                                            child: studisUploaded
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                  studentPic!
                                                                      .name),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    studisLoading =
                                                                        false;
                                                                    studisUploaded =
                                                                        false;
                                                                    _studPicAnimationController!
                                                                        .reset();
                                                                    studentPic =
                                                                        null;
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              ImagePicker imagePicker = ImagePicker();
                              signiture = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            setState(() {
                              _signAnimationController!.forward();
                            });
                          },
                          child: Material(
                            elevation: 5,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            child: DottedBorder(
                              strokeWidth: 1,
                              dashPattern: const [5, 5],
                              radius: const Radius.circular(10),
                              color: Colors.yellow,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
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
                                    signisLoading
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 3),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                          )
                                        : AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 1),
                                            child: signisUploaded
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                  signiture!
                                                                      .name),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    signisLoading =
                                                                        false;
                                                                    signisUploaded =
                                                                        false;
                                                                    _signAnimationController!
                                                                        .reset();
                                                                    signiture =
                                                                        null;
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                          "Upload your signiture")
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
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              ImagePicker imagePicker = ImagePicker();
                              stamp = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                            setState(() {
                              _stampPicAnimationController!.forward();
                            });
                          },
                          child: Material(
                            elevation: 5,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            child: DottedBorder(
                              strokeWidth: 1,
                              dashPattern: const [5, 5],
                              radius: const Radius.circular(10),
                              color: Colors.yellow,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
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
                                    stampisLoading
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 3),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                          )
                                        : AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 1),
                                            child: stampisUploaded
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                  stamp!.name),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    stampisLoading =
                                                                        false;
                                                                    stampisUploaded =
                                                                        false;
                                                                    _stampPicAnimationController!
                                                                        .reset();
                                                                    stamp =
                                                                        null;
                                                                  });
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                          "Upload your university stamp")
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
                          controller: _emailController,
                          focusNode: _emailNode,
                          decoration: const InputDecoration(
                              hintText: "Email",
                              helperStyle:
                                  TextStyle(fontWeight: FontWeight.w100),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message = "Email should not be empty";
                            }
                            return message;
                          },
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
                          obscureText: visabile,
                          controller: _passwordController,
                          focusNode: _passwordNode,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      visabile = !visabile;
                                    });
                                  },
                                  icon: visabile
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintText: "Password",
                              helperStyle:
                                  const TextStyle(fontWeight: FontWeight.w100),
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty ?? value.length > 7) {
                              message =
                                  "Password empty or password length less than 8";
                            }
                            return message;
                          },
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
                          obscureText: visabile,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordNode,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      visabile = !visabile;
                                    });
                                  },
                                  icon: visabile
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintText: "Confirm password",
                              helperStyle:
                                  TextStyle(fontWeight: FontWeight.w100),
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            String? message;
                            if (value!.isEmpty) {
                              message = "password should be the same";
                            }
                            return message;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                        child: RoundedLoadingButton(
                            valueColor: Colors.black,
                            elevation: 5,
                            successColor: Colors.yellow,
                            color: Colors.yellow,
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 10,
                            controller: _btnController,
                            onPressed: () async {
                              if (studentPic == null ??
                                  stamp == null ??
                                  signiture == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("please upload your photo"),
                                ));
                              } else if (departmentValue == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("please insert your department"),
                                ));
                              } else if (_formkey.currentState!.validate()) {
                                String studentPicUrl = await HelperFunctions()
                                    .uploadImage(studentPic, "student_picture");
                                String signiturePicUrl = await HelperFunctions()
                                    .uploadImage(signiture, "signiture");
                                String stampPicUrl = await HelperFunctions()
                                    .uploadImage(stamp, "stamp");
                              }
                              _btnController.success();
                              await Future.delayed(const Duration(seconds: 1));
                              Get.back();
                            },
                            child: Text(
                              "Create Account",
                              style: const TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5 + 1,
                                  color: Colors.black),
                            ))),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
