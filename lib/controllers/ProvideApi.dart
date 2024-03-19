import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_app/pages/createSectorAccountPage.dart';

//S   s w
class HeadingController extends ChangeNotifier {
  String? heading;
  void headingController(String value) {
    // this function will be resposible for
    //changing the center heading value according
    // to the dropdon value

    heading = value;
    notifyListeners();
  }
}

class studentInfoButtonBuilder extends ChangeNotifier {
  String? studentId;
  bool isvisible = false;
  bool generate = false;
  String? buttonName = "";

  void passValue(String? id, bool value, String name) {
    isvisible = true;
    generate = value;
    buttonName = name;
    studentId = id;
    notifyListeners();
  }
}

class CreateAccountButtonBuilder extends ChangeNotifier {
  bool addMember = false;
  String? buttonName = "";

  void passValue(bool value, String name) {
    addMember = value;
    buttonName = name;

    notifyListeners();
  }
}

class MultiIdGenerate extends ChangeNotifier {
  List<DocumentSnapshot> selectedstudents = [];

  void addToList(DocumentSnapshot student) {
    selectedstudents.add(student);
    notifyListeners();
  }

  void dropList() {
    selectedstudents.clear();
    notifyListeners();
  }

  void removeFromList(DocumentSnapshot student) {
    selectedstudents.removeWhere((element) => element == student);
    notifyListeners();
  }
}

class DropdownValueController extends ChangeNotifier {
  List<String> Sectors = ["Cafe", "kjgh", "fdaf"];
  String? buttonValue = sectors[0];

  Future<void> fetchSectors() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('Sectors').doc('').get();
    if (doc.exists) {
      Sectors = (doc['Sectors'] as List<dynamic>).cast<String>();
      // for (var item in catagoryList) {
      //   print(item);
      // }
    }
    notifyListeners();
  }
}
