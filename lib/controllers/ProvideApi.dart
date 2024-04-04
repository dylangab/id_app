import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_app/models/member.dart';
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
  int? studentId;
  bool isvisible = false;
  bool generate = false;
  String? buttonName = "";

  void passValue(int? id, bool value, String name) {
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

class ValuePass extends ChangeNotifier {
  String roleValue = "";
  String departmentValue = "";
  String sectorValue = "";
  void roleValuePass(String v) {
    roleValue = v;
  }

  void departmentValuePass(String v) {
    departmentValue = v;
  }

  void sectorValuePass(String v) {
    sectorValue = v;
  }
}

class SelectStudentPageBuilder extends ChangeNotifier {
  bool builder = false;
  String header = "";

  void passValue(bool builderValue, String headerValue) {
    builder = builderValue;
    header = headerValue;
  }
}

class FilterData extends ChangeNotifier {
  List selectedStudents = [];
}

class MembersData extends ChangeNotifier {
  List<Member> membersList = [];
  List<String> departmentList = [];
  List<String> roleList = [];
  List<String> sectorList = [];
  bool filterByDepartment = false;
  bool filterBySector = false;
  bool filterByRole = false;
  bool depVisibile = false;
  bool roleVisible = false;
  bool secVisible = false;

  Future<List<Member>> filterData(
      String sector, String role, String department) async {
    List<Member> result = [];

    List<Member> swap = membersList;
    if (filterByDepartment || filterByRole || filterBySector) {
      Iterable<Member> filterd = [];
      if (filterByDepartment && filterByRole && filterBySector) {
        filterd = swap.where((element) =>
            element.department == department &&
            element.sector == sector &&
            element.role == role);

        result = filterd.toList();
      } else if (filterByDepartment && filterByRole) {
        filterd = swap.where((element) =>
            element.department == department && element.role == role);

        result = filterd.toList();
      } else if (filterByDepartment && filterBySector) {
        filterd = swap.where((element) =>
            element.department == department && element.sector == sector);

        result = filterd.toList();
      } else if (filterByRole && filterBySector) {
        filterd = swap.where(
            (element) => element.role == role && element.sector == sector);

        result = filterd.toList();
      } else if (filterByDepartment) {
        filterd = swap.where((element) => element.department == department);

        result = filterd.toList();
      } else if (filterByRole) {
        filterd = swap.where((element) => element.role == role);

        result = filterd.toList();
      } else if (filterBySector) {
        filterd = swap.where((element) => element.sector == sector);

        result = filterd.toList();
      }
    } else {
      result = membersList;
    }
    return result;
  }
}
