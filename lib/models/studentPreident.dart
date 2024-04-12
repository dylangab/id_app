import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class StudentPreident {
  String? signature;
  String? email;
  String? password;
  String? stamp;
  String? gender;
  String? studentId;
  String? fullName;
  String? department;
  String? studentPhoto;

  StudentPreident({
    required this.email,
    required this.fullName,
    required this.password,
    required this.department,
    required this.gender,
    required this.signature,
    required this.stamp,
    required this.studentId,
    required this.studentPhoto,
  });

  factory StudentPreident.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return StudentPreident(
        email: data["email"],
        fullName: data["fullName"],
        password: data["password"],
        department: data["department"],
        gender: data["gender"],
        signature: data["signature"],
        stamp: data["stamp"],
        studentId: data["studentId"],
        studentPhoto: data["studentPhoto"]);
  }
}

class CreateStudentPresidentAccount {
  Future<void> createAccount(StudentPreident studentPreident) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: studentPreident.email!, password: studentPreident.password!)
        .then((value) => FirebaseFirestore.instance
                .collection("student_president_account")
                .doc(value.user!.uid)
                .set({
              "password": studentPreident.password,
              "email": studentPreident.email,
              "fullName": studentPreident.fullName,
              "department": studentPreident.department,
              "studentId": studentPreident.studentId,
              "stamp": studentPreident.stamp,
              "gender": studentPreident.gender,
              "studentPhoto": studentPreident.studentPhoto,
              "signature": studentPreident.signature
            }));
  }
}
