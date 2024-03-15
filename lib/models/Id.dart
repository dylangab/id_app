import 'package:flutter/material.dart';
import 'package:id_app/models/studentPreident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//S   s
class StudentID extends StudentPreident {
  String? universityName;
  String? universityLogo;
  String? dateOfIssue;
  String? expiryDate;
  String? universitystamp;
  String? universityAddress;
  String? poBox;
  String? website;
  String? additionalNotice;
  StudentID(
      {required this.additionalNotice,
      required this.dateOfIssue,
      required this.expiryDate,
      required this.poBox,
      required this.universityAddress,
      required this.universityLogo,
      required this.universityName,
      required this.universitystamp,
      required this.website,
      String? signature,
      String? firstName,
      String? lastName,
      String? department,
      String? studentId,
      String? role,
      String? gender,
      String? sector,
      String? studentPhoto})
      : super(
            lastName: lastName,
            signature: signature,
            firstName: firstName,
            department: department,
            studentId: studentId,
            role: role,
            gender: gender,
            sector: sector,
            studentPhoto: studentPhoto);
  factory StudentID.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    // Extract data from the snapshot
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Initialize YourObject with the extracted data
    return StudentID(
        universityName: data['field1'] ?? '',
        universityLogo: data['field2'] ?? 0,
        dateOfIssue: data['field1'] ?? '',
        expiryDate: data['field1'] ?? '',
        universitystamp: data['field1'] ?? '',
        universityAddress: data['field1'] ?? '',
        website: data['field1'] ?? '',
        additionalNotice: data['field1'] ?? '',
        signature: data['field1'] ?? '',
        firstName: data['field1'] ?? '',
        lastName: data[''],
        department: data['field1'] ?? '',
        studentId: data['field1'] ?? '',
        role: data['field1'] ?? '',
        gender: data['field1'] ?? '',
        sector: data['field1'] ?? '',
        studentPhoto: data['field1'] ?? '',
        poBox: "");
  }
  Future<List<StudentID>> gettudentList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('your_collection').get();

    List<StudentID> userList = querySnapshot.docs
        .map((doc) => StudentID.fromDocumentSnapshot(doc))
        .toList();

    return userList;
  }
}
