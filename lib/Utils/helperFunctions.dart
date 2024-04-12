import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:id_app/models/member.dart';

class HelperFunctions {
  Future<String> uploadImage(XFile? file, String storageFolder) async {
    String? image;

    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceimage = reference.child(storageFolder);
    Reference referenceupload = referenceimage.child(filename);
    try {
      await referenceupload.putFile(File(file!.path));
      image = await referenceupload.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    return image!;
  }

  // add member
  Future<void> addmember(Member member) async {
    await FirebaseFirestore.instance
        .collection('collectionPath')
        .doc(member.studentId)
        .set({
      "full_name": member.firstName,
      "department": member.department,
      "student_id": member.studentId,
      "role": member.role,
      "gender": member.gender,
      "sector": member.gender,
      "studentPhoto": member.studentPhoto,
    });
  }

  double ratio(double lenght, double screenSize) {
    double result;
    result = lenght / screenSize;
    return result;
  }

  Future<List> fetchCatagoires(
      String collection, String docName, String fieldName) async {
    List list = [];
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(collection)
        .doc(docName)
        .get();
    if (doc.exists) {
      list = (doc[fieldName] as List<dynamic>).cast<String>();
    }
    return list;
  }

  Future<int> getIndexById(List<Member> studentList, String id) async {
    for (var i = 0; i < studentList.length; i++) {
      if (studentList[i].studentId == id) {
        return i;
      }
    }
    return -1;
  }

  Future<List> firebaseService(
      String docName, String collection, String field) async {
    List list = [];
    try {
      final DocumentReference reference =
          FirebaseFirestore.instance.collection(collection).doc(docName);
      late Stream<DocumentSnapshot> stream;
      late DocumentSnapshot documentSnapshot;

      reference.get().then((value) => documentSnapshot = value);

      stream = reference.snapshots();
      stream.listen((event) {
        documentSnapshot = event;
        list = (documentSnapshot.get(field) as List<dynamic>).cast<String>();
      });
      return list;
    } catch (e) {
      print(e.toString());
    }
    return list;
  }

  Future<String> dateformat1(DateTime dateTime) async {
    var format = DateFormat("dd/MM/yy");
    String formated = format.format(dateTime);
    return formated;
  }

  Future<String> adddate(DateTime dateTime) async {
    var add = dateTime.add(Duration(days: 1460));
    String result = await dateformat1(add);
    return result;
  }
}
