import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
FocusNode _emailNode = FocusNode();
FocusNode _passwordNode = FocusNode();
bool _passwordVisability = false;

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
                                      Icons.visibility,
                                      color: Colors.yellow,
                                    )
                                  : const Icon(Icons.visibility_off,
                                      color: Colors.yellow)),
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
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                  onPressed: () async {
                    Get.to(() => const StudentPreidentHomePage());
                    /*   try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.value.text,
                              password: _passwordController.value.text)
                          .then((value) => null);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("No user found for that email."),
                        ));

                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Wrong password provided for that user."),
                        ));

                        print('Wrong password provided for that user.');
                      }
                    }  */
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.yellow),
                  child: const Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1.5 + 1,
                        color: Colors.black),
                  ))),
            ),
          )
        ],
      ),
    );
  }
}
