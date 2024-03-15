import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:id_app/models/member.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentPreident extends Member {
  String? signature;
  StudentPreident(
      {required this.signature,
      String? email,
      String? password,
      required String? firstName,
      required String? lastName,
      required String? department,
      required String? studentId,
      required String? role,
      required String? gender,
      required String? sector,
      required String? studentPhoto})
      : super(
            password: password,
            email: email,
            lastName: lastName,
            firstName: firstName,
            department: department,
            studentId: studentId,
            role: role,
            gender: gender,
            sector: sector,
            studentPhoto: studentPhoto);
}

class CreateStudentPresidentAccount {
  Future<void> createAccount(StudentPreident studentPreident) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: studentPreident.email!, password: studentPreident.password!)
        .then((value) => FirebaseFirestore.instance
                .collection("student_president_account")
                .doc(value.toString())
                .set({
              "password": studentPreident.password,
              "email": studentPreident.email,
              "fullName":
                  "${studentPreident.firstName} ${studentPreident.lastName}",
              "department": studentPreident.department,
              "studentId": studentPreident.studentId,
              "role": studentPreident.role,
              "gender": studentPreident.gender,
              "sector": studentPreident.sector,
              "studentPhoto": studentPreident.studentPhoto,
              "signature": studentPreident.signature
            }));
  }
}
