import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:pdf/pdf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart';
import 'package:id_app/models/member.dart';

class HelperFunctions {
// login Page
  Future<void> roleCheck(String uid) async {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection("").doc(uid);
    late DocumentSnapshot document;

    documentReference.get().then((value) => document = value);

    if (document.get('role') == "president") {
      //   Get.to( ()=> StudentPreidentHomePage() );
    } else {
      //   Get.to( ()=> StudentPreidentHomePage() );
    }
  }

  // create sector leader page
  Future<void> createsectorLeader(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => FirebaseFirestore.instance
            .collection("")
            .doc(value.user!.uid)
            .set({}));
  }

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

  // create president account
  Future<void> createpresidentAccount(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => FirebaseFirestore.instance
            .collection("collectionPath")
            .doc(value.user!.uid)
            .set({}));
  }

  // president home page
  Future<void> createSingleId() async {
    // implement flutter pdf package here
  }

  Future<void> createMultiId() async {
    // use for loop here
    // implement flutter pdf package here
  }

  // View Member page

  Future<void> search() async {}
  void generateCustomPageSizePDF(double widthInCm, double heightInCm) {
    // Convert centimeters to points
    widthInCm = 6.7;
    heightInCm = 9.9;
    double marginInCm = 0.0; // No margin for simplicity

    double widthInPoints = widthInCm * PdfPageFormat.cm;
    double heightInPoints = heightInCm * PdfPageFormat.cm;
    double marginInPoints = marginInCm * PdfPageFormat.cm;

    // Create a custom page format
    final pdf = Document();
    pdf.addPage(Page(
      pageFormat: const PdfPageFormat(
          6 * PdfPageFormat.cm, 9 * PdfPageFormat.cm,
          marginAll: 1 * PdfPageFormat.cm),
      build: (context) {
        return Center(
          child: Text('Custom Page Size PDF'),
        );
      },
    ));

    // Add content to the PDF

    // Save the PDF to a file
    savePDFToFile(pdf);
  }

  void savePDFToFile(Document pdf) async {
    // Specify the file path
    final file = File('custom_page_size.pdf');

    // Write the PDF to the file
    // await file.writeAsBytes(pdf.save());
  }

  Future<Map<String, dynamic>?> getstudent() async {
    Map<String, dynamic>? student;
    // initiate FirebaseFirestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // get DocumentReference
    DocumentReference studentRef = firestore.collection("").doc('');
    //get DocumentSnapshot
    DocumentSnapshot snapshot = await studentRef.get();
    if (snapshot.exists) {
      student = snapshot.data() as Map<String, dynamic>;
    }
    return student;
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
    int result;
    for (var i = 0; i < studentList.length; i++) {
      if (studentList[i].studentId == id) {
        return i;
      }
    }
    return -1;
  }
}
