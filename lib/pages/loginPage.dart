import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
FocusNode _emailNode = FocusNode();
FocusNode _passwordNode = FocusNode();
bool _passwordVisability = true;
RoundedLoadingButtonController _buttonController =
    RoundedLoadingButtonController();

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();

    super.dispose();
  }

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
            height: 60,
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
          )
        ],
      ),
    );
  }
}
