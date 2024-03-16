import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/pages/SearchPage.dart';
import 'package:id_app/pages/studentInfoPage.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ViewMembersPage extends StatefulWidget {
  const ViewMembersPage({super.key});

  @override
  State<ViewMembersPage> createState() => _ViewMembersPageState();
}

List<demo> list = [
  demo(name: "blake", phoneNo: "8989898", isselected: false),
  demo(name: "tim", phoneNo: "8989898", isselected: false),
  demo(name: "penny", phoneNo: "8989898", isselected: false),
  demo(name: "fin", phoneNo: "8989898", isselected: false),
  demo(name: "buddy", phoneNo: "8989898", isselected: false),
  demo(name: "alan", phoneNo: "8989898", isselected: false),
  demo(name: "joe", phoneNo: "8989898", isselected: false),
  demo(name: "blake", phoneNo: "8989898", isselected: false),
  demo(name: "tim", phoneNo: "8989898", isselected: false),
  demo(name: "penny", phoneNo: "8989898", isselected: false),
  demo(name: "fin", phoneNo: "8989898", isselected: false),
  demo(name: "buddy", phoneNo: "8989898", isselected: false),
  demo(name: "alan", phoneNo: "8989898", isselected: false),
  demo(name: "joe", phoneNo: "8989898", isselected: false),
];

class _ViewMembersPageState extends State<ViewMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownValueController>(
      builder: (context, value, child) {
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
                  CustomDropdown(
                    initialItem: value.Sectors[0],
                    items: value.Sectors,
                    onChanged: (p0) {
                      value.buttonValue = p0;
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(() => const searchPage(),
                            transition: Transition.fadeIn);
                      },
                      icon: const Icon(Icons.search_sharp, size: 14 + 15))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text("${value.buttonValue}",
                  style: const TextStyle(
                    fontSize: 30 - 5,
                    letterSpacing: 1.5 + 1,
                  )),
            ),
            Expanded(
              child: Container(
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return studentListTile(
                              list[index].name,
                              list[index].phoneNo,
                              list[index].isselected,
                              index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        );
      },
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
          onTap: () {
            Get.to(() => const StudentInfoPage());
          },
        ),
      ),
    );
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
/*
class ViewMembersPage extends StatefulWidget {
  const ViewMembersPage({super.key});

  @override
  State<ViewMembersPage> createState() => _ViewMembersPageState();
}

List<DocumentSnapshot> list = [];

class _ViewMembersPageState extends State<ViewMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownValueController>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("collectionPath")
                .where("field")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                list = snapshot.data!.docs;
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
                              CustomDropdown(
                                initialItem: value.Sectors[0],
                                items: value.Sectors,
                                onChanged: (p0) {
                                  value.buttonValue = p0;
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => searchPage(),
                                        transition: Transition.fadeIn);
                                  },
                                  icon: Icon(Icons.search_sharp, size: 14 + 15))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text("${value.buttonValue}",
                              style: TextStyle(
                                fontSize: 30 - 5,
                                letterSpacing: 1.5 + 1,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            child: AnimationConfiguration.staggeredList(
                              position: 0,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return studentListTile(list, index);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
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
      },
    );
  }

  Widget studentListTile(List<DocumentSnapshot> studentListTile, int index) {
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
            backgroundImage:
                NetworkImage(studentListTile[index][""].toString()),
          ),
          title: Text("${studentListTile[index][""]}"),
          subtitle: Text("${studentListTile[index][""]}"),
          onTap: () {
            Get.to(() => const StudentInfoPage());
          },
        ),
      ),
    );
  }
}
*/