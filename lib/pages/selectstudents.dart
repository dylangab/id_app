//import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/Utils/pdf.dart';

class selectstudentsPage extends StatefulWidget {
  const selectstudentsPage({super.key});

  @override
  State<selectstudentsPage> createState() => _selectstudentsPageState();
}

List<Student> list = [
  Student(name: "blake", phoneNo: "8989898", isselected: false),
  Student(name: "tim", phoneNo: "8989898", isselected: false),
  Student(name: "penny", phoneNo: "8989898", isselected: false),
  Student(name: "fin", phoneNo: "8989898", isselected: false),
  Student(name: "buddy", phoneNo: "8989898", isselected: false),
  Student(name: "alan", phoneNo: "8989898", isselected: false),
  Student(name: "joe", phoneNo: "8989898", isselected: false),
];
List<Student>? demo = [];

class _selectstudentsPageState extends State<selectstudentsPage> {
  @override
  Widget build(BuildContext context) {
    int selectedindex = -1;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                        child: Text(
                      "All member",
                    ))
                  ],
                  onChanged: (value) {}),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_sharp, size: 14 + 15))
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: Text("Select Students",
              style: TextStyle(
                fontSize: 30 - 5,
                letterSpacing: 1.5 + 1,
              )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              HelperFunctions().ratio(500, MediaQuery.of(context).size.height),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return studentListTile(list[index].name, list[index].phoneNo,
                  list[index].isselected, index);
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
                onPressed: () async {
                  // await PdfApi().generateMultiPage().then((value) async =>
                  //     PDFViewer(document: await PDFDocument.fromFile(value)));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.yellow),
                child: Center(
                    child: Text(
                  "Generate IDs (${demo!.length ?? "34"})",
                  style: const TextStyle(
                      fontSize: 15,
                      letterSpacing: 1.5 + 1,
                      color: Colors.black),
                ))),
          ),
        )
      ]),
    );
  }

  Widget studentListTile(String? name, phoneNo, bool? isselected, int index) {
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
          leading: const CircleAvatar(),
          title: Text("$name"),
          subtitle: Text("$phoneNo"),
          trailing: isselected!
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.yellow,
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            print(MediaQuery.of(context).size.height);
            setState(() {
              list[index].isselected = !list[index].isselected!;
              if (list[index].isselected == true) {
                demo!.add(list[index]);
              } else if (list[index].isselected == false) {
                demo!.removeWhere((element) => element == list[index]);
              }
            });
          },
        ),
      ),
    );
  }
}

class Student {
  String? name, phoneNo;
  bool? isselected;
  Student({
    required this.name,
    required this.phoneNo,
    required this.isselected,
  });
}
/*
class selectstudentsPage extends StatefulWidget {
  const selectstudentsPage({super.key});

  @override
  State<selectstudentsPage> createState() => _selectstudentsPageState();
}

List<DocumentSnapshot>? studentList = [];
int selectedindex = -1;

class _selectstudentsPageState extends State<selectstudentsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("collectionPath")
            .where("field")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            studentList = snapshot.data!.docs;
            return Consumer<MultiIdGenerate>(
              builder: (context, value, child) {
                return Scaffold(
                  backgroundColor: const Color.fromARGB(255, 233, 236, 239),
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          /* const SizedBox(
                  height: 190,
                ),*/
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton(
                                  focusColor: Colors.white,
                                  dropdownColor: Colors.white,
                                  items: [
                                    const DropdownMenuItem(
                                        child: Text(
                                      "All member",
                                    ))
                                  ],
                                  onChanged: (value) {}),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search_sharp,
                                      size: 14 + 15))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                          child: Text("Select Students",
                              style: TextStyle(
                                fontSize: 30 - 5,
                                letterSpacing: 1.5 + 1,
                              )),
                        ),
                        Container(
                          height: 600,
                          child: ListView.builder(
                            itemCount: studentList!.length,
                            itemBuilder: (context, index) {
                              return studentListTile(studentList!, index);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.yellow),
                                child: Center(
                                    child: Text(
                                  "Generate IDs (${value.selectedstudents.length})",
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 1.5 + 1,
                                      color: Colors.black),
                                ))),
                          ),
                        )
                      ]),
                );
              },
            );
          } else {
            return const Scaffold(
                body: CircularProgressIndicator(
              color: Colors.yellow,
            ));
          }
        });
  }

  Widget studentListTile(List<DocumentSnapshot> list, int index) {
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
            backgroundImage: NetworkImage(list[index][""].toString()),
          ),
          title: Text("${list[index][""]}"),
          subtitle: Text("${list[index][""]}"),
          trailing: selectedindex == index
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.yellow,
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            setState(() {
              if (selectedindex != index) {
                selectedindex = index;
                Provider.of<MultiIdGenerate>(context, listen: false)
                    .addToList(list[index]);
              } else if (selectedindex == index) {
                selectedindex = -1;
                Provider.of<MultiIdGenerate>(context, listen: false)
                    .removeFromList(list[index]);
              }
            });
          },
        ),
      ),
    );
  }
}
*/