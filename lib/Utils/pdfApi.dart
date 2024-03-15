// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pdf/widgets.dart';

// class PdfApi1 {
//   Future<File> generateSingleId(
//       DocumentSnapshot<Map<String, dynamic>> snapshot) async {}

// //  Future<File> generateMultiId(List studentList) {}

//   // Future<File> generateMultiIdOnSinglePage(List studentList) async {}
//   Widget IdFrontOage() {
//     return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//       SizedBox(height: 20),
//       Padding(
//           padding: const EdgeInsets.only(left: 5),
//           child: Row(children: [
//             //  Image(height: 99, width: 32, MemoryImage(imageData)),
//             Container(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: Text("KOTEBE",
//                         style: TextStyle(
//                           fontSize: 6,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   ),
//                   Text("UNIVERISTY OF EDUCATION",
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         fontSize: 6,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Text("STUDENT UNION MEMBER'S ID",
//                       style: TextStyle(
//                         fontSize: 6,
//                         fontWeight: FontWeight.bold,
//                       )),
//                 ])),
//           ])),
//       SizedBox(height: 5),
//       //  Image(height: 256, width: 86, MemoryImage(imageData1)),
//       SizedBox(height: 10),
//       Container(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//         Text("MIMIKO",
//             style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
//         Text("WATARU",
//             style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
//       ])),
//       SizedBox(height: 3),
//       Container(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//         Text("PSYCHOLOGY",
//             style: const TextStyle(
//               fontSize: 7,
//             )),
//         Text("UGR/38320/13",
//             style: const TextStyle(
//               fontSize: 7,
//             )),
//       ])),
//       SizedBox(height: 3),
//       Container(
//           height: 10,
//           decoration: BoxDecoration(color: PdfColor.fromHex("#06304b")),
//           child: Center(
//               child: Text("PHILANTHROPY SECTOR",
//                   style: TextStyle(
//                       fontSize: 5,
//                       fontWeight: FontWeight.bold,
//                       color: PdfColors.white))))
//     ]);
//   }

//   Widget IdBackPage() {
//     return Column(children: [
//       SizedBox(height: 30),
//       Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 "የተሰጠበት ቀን: 02/01/2023",
//                 //     style: TextStyle(fontSize: 6, font: ttf)
//               ),
//               Text("Date of Issue", style: const TextStyle(fontSize: 6)),
//               SizedBox(
//                 height: 3,
//               ),
//               Text(
//                 "የሚያበቃበት ቀን: 11/9/2023",
//                 //   style: TextStyle(fontSize: 6, font: ttf)
//               ),
//               Text("Expiry Date", style: const TextStyle(fontSize: 6)),
//             ]),
//             Container(
//                 height: 30,
//                 width: 30,
//                 child:
//                     BarcodeWidget(data: "1202568", barcode: Barcode.qrCode()))
//           ])),
//       SizedBox(height: 10),
//       Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(children: [
//                   //      Image(MemoryImage(sign), height: 200, width: 50),
//                   Text("Tarea Sisay",
//                       style: TextStyle(
//                         fontSize: 5,
//                         color: PdfColor.fromHex("#562e61"),
//                       )),
//                   Text("Student Union President",
//                       style: TextStyle(
//                           fontSize: 5,
//                           decoration: TextDecoration.underline,
//                           color: PdfColor.fromHex("#562e61"))),
//                   SizedBox(height: 3),
//                   Text(
//                     "የባለስልጣኑ ፊርማ",
//                     //  style: TextStyle(fontSize: 5, font: ttf)
//                   ),
//                   Text("Authorized Signature",
//                       style: TextStyle(
//                         fontSize: 5,
//                         color: PdfColor.fromHex("#562e61"),
//                       ))
//                 ]),
//                 //    Image(MemoryImage(stamp), height: 70, width: 100)
//               ])),
//       SizedBox(height: 3),
//       Center(
//           child: Column(children: [
//         Text("Asmara Road.", style: const TextStyle(fontSize: 5)),
//         Text("Yeka Sub-City, Woreda 11", style: const TextStyle(fontSize: 5)),
//         Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
//             style: const TextStyle(fontSize: 5)),
//         Text("studentunion@kue.edu.et", style: const TextStyle(fontSize: 5))
//       ])),
//       SizedBox(height: 3),
//       Container(height: 1.5, color: PdfColor.fromHex("#06304b")),
//       SizedBox(height: 5),
//       Center(
//           child: Column(children: [
//         Text(
//           "ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
//           //    style: TextStyle(fontSize: 5, font: ttf)
//         ),
//         Text(
//           "ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
//           //   style: TextStyle(fontSize: 5, font: ttf)
//         ),
//         Text("This ID should be returned to the Student Union Office",
//             style: const TextStyle(fontSize: 5)),
//         Text("up on termination or resignation.",
//             style: const TextStyle(fontSize: 5))
//       ])),
//       SizedBox(height: 5),
//       Container(color: PdfColor.fromHex("#06304b"), height: 40.5)
//     ]);
//   }
// }
