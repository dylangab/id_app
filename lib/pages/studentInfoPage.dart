//import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

/* const SizedBox(
            height: 190,
          ),*/
class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text("Alan Blake",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5 + 1,
                fontSize: 18 + 1 + 1,
              )),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                width: 180),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 410,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Full Name:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Alan Blake",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Gender:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Male",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Department:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  IT",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Student ID:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  34567875",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Sector:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Cafe",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Team:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Inventory",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Role:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  _________",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15 + 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RichText(
                      text: const TextSpan(
                          text: "Active Status:-",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: [
                            TextSpan(
                                text: "  Active",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Consumer<studentInfoButtonBuilder>(
          builder: (context, value, child) {
            return Visibility(
              visible: value.isvisible,
              maintainState: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (value.generate == true) {
                          // await PdfApi().generateMultiPage().then(
                          //     (value) async => PDFViewer(
                          //         document: await PDFDocument.fromFile(value)));
                        } else {
                          print("appointed");
                        }
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
              ),
            );
          },
        )
      ]),
    );
  }
}

/*
class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

/* const SizedBox(
            height: 190,
          ),*/
class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  void initState() {
    super.initState();
    // String studentId = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("collectionPath")
            .doc("")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 233, 236, 239),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Center(
                  child: Text("Alan Blake",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5 + 1,
                        fontSize: 18 + 1 + 1,
                      )),
                ),
              ),
              body: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        width: 180),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 450,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Full Name:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  Alan Blake",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Gender:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  Male",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Department:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  IT",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Student ID:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  34567875",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Sector:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  Cafe",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Team:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  Inventory",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Role:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  _________",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15 + 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: RichText(
                              text: const TextSpan(
                                  text: "Active Status:-",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: [
                                    TextSpan(
                                        text: "  Active",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer<AppointLeader>(
                  builder: (context, value, child) {
                    return Visibility(
                      visible: value.isvisible,
                      maintainState: true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.yellow),
                              child: const Center(
                                  child: Text(
                                "Appoint",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 1.5 + 1,
                                    color: Colors.black),
                              ))),
                        ),
                      ),
                    );
                  },
                )
              ]),
            );
          } else {
            return const Scaffold(
                body: CircularProgressIndicator(
              color: Colors.yellow,
            ));
          }
        });
  }
}
*/