import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:id_app/pages/President%20Account/createPresidentAccount.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:flutter/animation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
FocusNode _emailNode = FocusNode();
FocusNode _passwordNode = FocusNode();
TextEditingController _forgotPassword = TextEditingController();
FocusNode _forgotPasswordNode = FocusNode();
bool _passwordVisability = true;
RoundedLoadingButtonController _buttonController =
    RoundedLoadingButtonController();
bool isForget = false;
bool loginButton = true;

class _LoginPageState extends State<LoginPage> {
  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _emailNode.dispose();
  //   _passwordController.dispose();
  //   _passwordNode.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 190,
          ),
          const Center(
              child: Text(
            "Student Union App",
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 1.5 + 1,
            ),
          )),
          const SizedBox(
            height: 90,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Login",
                style: TextStyle(
                  fontSize: 10 + 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.5 + 1,
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            child: Form(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Material(
                    elevation: 5,
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    child: TextFormField(
                      controller: _emailController,
                      focusNode: _emailNode,
                      cursorColor: Colors.yellow,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Material(
                    elevation: 5,
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    child: TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      cursorColor: Colors.yellow,
                      obscureText: _passwordVisability,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisability = !_passwordVisability;
                                });
                              },
                              icon: _passwordVisability
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    )
                                  : const Icon(Icons.visibility,
                                      color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          hintText: "Password",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w300)),
                    ),
                  ),
                )
              ],
            )),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isForget = !isForget;
                });
              },
              child: const Text(
                "Forgot password",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: isForget,
            maintainState: false,
            maintainSize: false,
            child: Animate(
              effects: [const ScaleEffect()],
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Material(
                        elevation: 5,
                        shape: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        child: TextFormField(
                          controller: _forgotPassword,
                          focusNode: _forgotPasswordNode,
                          cursorColor: Colors.yellow,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: "Enter account email",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w300)),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_forgotPassword.value.text.trim().isNotEmpty &&
                              _forgotPassword.value.text.trim().contains("@")) {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: _forgotPassword.value.text.trim());

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "email has been sent. please check your email")));
                            setState(() {
                              isForget = false;
                            });
                          } else if (_forgotPassword.value.text
                              .trim()
                              .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please enter your email address to reset your password")));
                          } else if (!_forgotPassword.value.text
                              .trim()
                              .contains("@")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "The email address you entered is invalid. Please enter a valid email address")));
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("Send"),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: RoundedLoadingButton(
                color: Colors.yellow,
                valueColor: Colors.black,
                borderRadius: 10,
                height: 45,
                width: MediaQuery.of(context).size.width,
                controller: _buttonController,
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.value.text,
                        password: _passwordController.value.text);

                    _buttonController.start();
                    await Future.delayed(const Duration(seconds: 1));
                    _buttonController.stop();
                    Get.to(() => const StudentPreidentHomePage());
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                    _buttonController.stop();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1.5 + 1,
                      color: Colors.black),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
              child: Text("or",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ))),
          SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 233, 236, 239),
                        title: const Center(
                          child: Text(
                            "Warning",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        content: const Text(
                          "Creating a new student president account will permanently delete the existing account and its associated data. Are you sure you want to proceed?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  Get.to(
                                      () => const CreatePresidentAccountPage());
                                },
                                child: const Text(
                                  "Proceed",
                                  style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      );
                    });
              },
              child: const Text("Create new student president account",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline)),
            ),
          )
        ],
      ),
    );
  }
}
