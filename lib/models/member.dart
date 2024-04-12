import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String? firstName;
  String? lastName;
  String? department;
  String? studentId;
  String? role;
  String? gender;
  String? sector;
  String? studentPhoto;

  Member(
      {required this.lastName,
      required this.firstName,
      required this.department,
      required this.gender,
      required this.role,
      required this.sector,
      required this.studentId,
      required this.studentPhoto});
}

class CreateMemberAccount {
  Future<void> createMemeberAccount(Member member) async {
    await FirebaseFirestore.instance
        .collection("members")
        .doc(member.studentId)
        .set({
      "fullName": "${member.firstName} ${member.lastName}",
      "department": member.department,
      "studentId": member.studentId,
      "role": member.role,
      "gender": member.gender,
      "sector": member.sector,
      "studentPhoto": member.studentPhoto,
    });
  }
}
