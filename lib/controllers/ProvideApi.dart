import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/models/member.dart';
import 'package:id_app/models/studentPreident.dart';

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

class SelectStudentPageBuilder extends ChangeNotifier {
  bool builder = false;
  String header = "";

  void passValue(bool builderValue, String headerValue) {
    builder = builderValue;
    header = headerValue;
  }
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

  Future<List<Member>> fetchMemberData() async {
    final memberList = <Member>[]; // Create an empty list

    try {
      final collection = FirebaseFirestore.instance.collection('members');
      final snapshot = await collection.get();

      for (final doc in snapshot.docs) {
        final data = doc.data(); // Cast to Map

        final member = Member(
          lastName: data['fullName'] as String,
          firstName: data['fullName'] as String,
          department: data['department'] as String,
          studentId: data['studentId'] as String,
          role: data['role'] as String,
          gender: data['gender'] as String,
          sector: data['sector'] as String,
          studentPhoto: data['studentPhoto'] as String,
        );

        memberList.add(member);
      }

      // memberList is now populated with Member objects
    } catch (error) {
      print("Error fetching data: $error");
    }
    return memberList;
  }

  Future<bool> initateData() async {
    bool success = false;
    try {
      membersList = await fetchMemberData();

      departmentList = await HelperFunctions().fetchCatagoires(
          "catagories", "departments", "departments") as List<String>;
      roleList = await HelperFunctions()
          .fetchCatagoires("catagories", "roles", "roles") as List<String>;
      sectorList = await HelperFunctions()
          .fetchCatagoires("catagories", "sectors", "sectors") as List<String>;

      success = true;
    } catch (e) {
      print(e.toString());
    }
    return success;
  }
}

class StudentPresidentDataFetch extends ChangeNotifier {
  Future<StudentPreident?> getStudentData(String docId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(
              'student_president_account') // Replace with actual collection name
          .doc(docId)
          .get();

      if (!snapshot.exists) {
        return null; // Handle document not found scenario
      }

      // final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      final studentID = StudentPreident.fromDocumentSnapshot(snapshot);
      return studentID;
    } catch (error) {
      // Handle errors appropriately, e.g., logging, throwing exceptions
      print('Error fetching student data: $error');
      return null; // Or rethrow for further handling
    }
  }
}
