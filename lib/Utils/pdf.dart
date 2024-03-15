// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:open_document/my_files/init.dart';
// import 'package:pdf/pdf.dart';
// //import 'package:barcode_widget/barcode_widget.dart' ;
// import 'package:pdf/widgets.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:document_file_save_plus/document_file_save_plus.dart';

// class PdfApi {
//   Future<File> savefile({required String name, required Document pdf}) async {
//     final byte = await pdf.save();
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File("${dir.path}/$name.pdf");
//     await file.writeAsBytes(byte);

//     try {
//       DocumentFileSavePlus().saveFile(byte, "$name.pdf", "appliation/pdf");

//       print('File saved successfully');

//       // Display the PDF after saving
//     } catch (e) {
//       print('Error saving file: $e');
//       // Handle error gracefully
//     }

//     return file;
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>> getStudentDocument(
//       String collection, String documentId) async {
//     try {
//       // Reference to the Firestore collection
//       CollectionReference<Map<String, dynamic>> studentsCollection =
//           FirebaseFirestore.instance.collection(collection);

//       // Get the document snapshot using the document ID
//       DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await studentsCollection.doc(documentId).get();

//       return snapshot;
//     } catch (e) {
//       // Handle any errors that occurred during the get operation
//       print('Error getting document: $e');
//       rethrow; // Rethrow the exception to allow the caller to handle it
//     }
//   }

//   Future<File> generateSingleId(String studentId) async {
//     final pdf = Document();
//     DocumentSnapshot<Map<String, dynamic>> studentSnapshot =
//         await getStudentDocument("", studentId);
//     pdf.addPage(MultiPage(
//         pageFormat: const PdfPageFormat(
//             PdfPageFormat.inch * 2.125, PdfPageFormat.inch * 3.375),
//         build: (Context context) {
//           return [IdFrontOage()];
//         }));
//     pdf.addPage(MultiPage(build: (Context context) {
//       return [IdBackPage()];
//     }));
//     return savefile(name: "id7", pdf: pdf);
//   }

//   Future<File> generateMultiId(List studentList) {
//     final pdf = Document();
//     for (var element in studentList) {
//       pdf.addPage(MultiPage(build: (Context context) {
//         return [IdFrontOage()];
//       }));
//       pdf.addPage(MultiPage(build: (Context context) {
//         return [IdBackPage()];
//       }));
//     }
//     return savefile(name: "id7", pdf: pdf);
//   }

//   Future<File> generateMultiIdOnSinglePage() async {
//     final ByteData image =
//         await rootBundle.load('assets/images/univercitylogo.jpg');
//     final ByteData imagestamp =
//         await rootBundle.load('assets/images/stamp.jpg');
//     final ByteData person = await rootBundle.load('assets/images/id.jpg');
//     final font = await rootBundle.load("fonts/AbyssinicaSIL-R.ttf");

//     final ttf = Font.ttf(font);
//     final ByteData image2 = await rootBundle.load('assets/images/sign.jpg');
//     Uint8List sign = (image2).buffer.asUint8List();
//     Uint8List stamp = (imagestamp).buffer.asUint8List();
//     Uint8List imageData = (image).buffer.asUint8List();
//     Uint8List imageData1 = (person).buffer.asUint8List();
//   }

//   Future<File> generateMultiPage() async {
//     List<int> demolist = [1, 2, 3, 4, 5, 6, 7, 8, 9];
//     double page = 3;
//     int range = 0;
//     final pdf = Document();

//     // for (var i = 0; i < page; i++) {
//     //   List<Widget> list = [];
//     //   int counter = 0;

//     //   for (int id in demolist.getRange(range, demolist.length)) {
//     //     list.add(ID(id));
//     //     counter++;
//     //     if (counter == 8) {
//     //       counter = 0;
//     //       range = range + 3;
//     //       break;
//     //     }
//     //   }

//     //   pdf.addPage(MultiPage(
//     //     pageFormat: PdfPageFormat.a4,
//     //     build: (Context context) {
//     //       return list;
//     //     },
//     //   ));
//     // }

//     final ByteData image =
//         await rootBundle.load('assets/images/univercitylogo.jpg');
//     final ByteData imagestamp =
//         await rootBundle.load('assets/images/stamp.jpg');
//     final ByteData person = await rootBundle.load('assets/images/id.jpg');
//     final font = await rootBundle.load("fonts/AbyssinicaSIL-R.ttf");

//     final ttf = Font.ttf(font);
//     final ByteData image2 = await rootBundle.load('assets/images/sign.jpg');
//     Uint8List sign = (image2).buffer.asUint8List();
//     Uint8List stamp = (imagestamp).buffer.asUint8List();
//     Uint8List imageData = (image).buffer.asUint8List();
//     Uint8List imageData1 = (person).buffer.asUint8List();

//     pdf.addPage(MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (Context context) {
//           return [
//             Column(children: [
//               Container(
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                     Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: PdfColors.red)),
//                         height: PdfPageFormat.inch * 3.137,
//                         width: PdfPageFormat.inch * 2.125,
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(height: 20),
//                               Padding(
//                                   padding: const EdgeInsets.only(left: 5),
//                                   child: Row(children: [
//                                     Image(
//                                         height: 99,
//                                         width: 32,
//                                         MemoryImage(imageData)),
//                                     Container(
//                                         child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 15),
//                                             child: Text("KOTEBE",
//                                                 style: TextStyle(
//                                                   fontSize: 6,
//                                                   fontWeight: FontWeight.bold,
//                                                 )),
//                                           ),
//                                           Text("UNIVERISTY OF EDUCATION",
//                                               style: TextStyle(
//                                                 decoration:
//                                                     TextDecoration.underline,
//                                                 fontSize: 6,
//                                                 fontWeight: FontWeight.bold,
//                                               )),
//                                           Text("STUDENT UNION MEMBER'S ID",
//                                               style: TextStyle(
//                                                 fontSize: 6,
//                                                 fontWeight: FontWeight.bold,
//                                               )),
//                                         ])),
//                                   ])),
//                               SizedBox(height: 5),
//                               Image(
//                                   height: 256,
//                                   width: 86,
//                                   MemoryImage(imageData1)),
//                               SizedBox(height: 10),
//                               Container(
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                     Text("MIMIKO",
//                                         style: TextStyle(
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.bold)),
//                                     Text("WATARU",
//                                         style: TextStyle(
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.bold)),
//                                   ])),
//                               SizedBox(height: 3),
//                               Container(
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                     Text("PSYCHOLOGY",
//                                         style: const TextStyle(
//                                           fontSize: 7,
//                                         )),
//                                     Text("UGR/38320/13",
//                                         style: const TextStyle(
//                                           fontSize: 7,
//                                         )),
//                                   ])),
//                               SizedBox(height: 3),
//                               Container(
//                                   height: 10,
//                                   decoration: BoxDecoration(
//                                       color: PdfColor.fromHex("#06304b")),
//                                   child: Center(
//                                       child: Text("PHILANTHROPY SECTOR",
//                                           style: TextStyle(
//                                               fontSize: 5,
//                                               fontWeight: FontWeight.bold,
//                                               color: PdfColors.white))))
//                             ])),
//                     Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: PdfColors.red)),
//                         height: PdfPageFormat.inch * 3.137,
//                         width: PdfPageFormat.inch * 2.125,
//                         child: Column(children: [
//                           SizedBox(height: 30),
//                           Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20, right: 20),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("የተሰጠበት ቀን: 02/01/2023",
//                                               style: TextStyle(
//                                                   fontSize: 6, font: ttf)),
//                                           Text("Date of Issue",
//                                               style:
//                                                   const TextStyle(fontSize: 6)),
//                                           SizedBox(
//                                             height: 3,
//                                           ),
//                                           Text("የሚያበቃበት ቀን: 11/9/2023",
//                                               style: TextStyle(
//                                                   fontSize: 6, font: ttf)),
//                                           Text("Expiry Date",
//                                               style:
//                                                   const TextStyle(fontSize: 6)),
//                                         ]),
//                                     Container(
//                                         height: 30,
//                                         width: 30,
//                                         child: BarcodeWidget(
//                                             data: "1202568",
//                                             barcode: Barcode.qrCode()))
//                                   ])),
//                           SizedBox(height: 10),
//                           Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20, right: 20),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(children: [
//                                       Image(MemoryImage(sign),
//                                           height: 200, width: 50),
//                                       Text("Tarea Sisay",
//                                           style: TextStyle(
//                                             fontSize: 5,
//                                             color: PdfColor.fromHex("#562e61"),
//                                           )),
//                                       Text("Student Union President",
//                                           style: TextStyle(
//                                               fontSize: 5,
//                                               decoration:
//                                                   TextDecoration.underline,
//                                               color:
//                                                   PdfColor.fromHex("#562e61"))),
//                                       SizedBox(height: 3),
//                                       Text("የባለስልጣኑ ፊርማ",
//                                           style: TextStyle(
//                                               fontSize: 5, font: ttf)),
//                                       Text("Authorized Signature",
//                                           style: TextStyle(
//                                             fontSize: 5,
//                                             color: PdfColor.fromHex("#562e61"),
//                                           ))
//                                     ]),
//                                     Image(MemoryImage(stamp),
//                                         height: 70, width: 100)
//                                   ])),
//                           SizedBox(height: 3),
//                           Center(
//                               child: Column(children: [
//                             Text("Asmara Road.",
//                                 style: const TextStyle(fontSize: 5)),
//                             Text("Yeka Sub-City, Woreda 11",
//                                 style: const TextStyle(fontSize: 5)),
//                             Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
//                                 style: const TextStyle(fontSize: 5)),
//                             Text("studentunion@kue.edu.et",
//                                 style: const TextStyle(fontSize: 5))
//                           ])),
//                           SizedBox(height: 3),
//                           Container(
//                               height: 1.5, color: PdfColor.fromHex("#06304b")),
//                           SizedBox(height: 5),
//                           Center(
//                               child: Column(children: [
//                             Text("ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
//                                 style: TextStyle(fontSize: 5, font: ttf)),
//                             Text("ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
//                                 style: TextStyle(fontSize: 5, font: ttf)),
//                             Text(
//                                 "This ID should be returned to the Student Union Office",
//                                 style: const TextStyle(fontSize: 5)),
//                             Text("up on termination or resignation.",
//                                 style: const TextStyle(fontSize: 5))
//                           ])),
//                           SizedBox(height: 5),
//                           Container(
//                               color: PdfColor.fromHex("#06304b"), height: 40.5)
//                         ])),
//                   ]))
//             ])
//           ];
//         }));
//     // for (var i = 0; i < 20; i++) {}
//     // pdf.addPage(MultiPage(
//     //     pageFormat: PdfPageFormat(
//     //       PdfPageFormat.inch * 2.125,
//     //       PdfPageFormat.inch * 3.375,
//     //     ),
//     //     build: (Context context) {
//     //       return [
//     //         Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//     //           SizedBox(height: 20),
//     //           Padding(
//     //               padding: const EdgeInsets.only(left: 5),
//     //               child: Row(children: [
//     //                 Image(height: 99, width: 32, MemoryImage(imageData)),
//     //                 Container(
//     //                     child: Column(
//     //                         mainAxisAlignment: MainAxisAlignment.start,
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                       Padding(
//     //                         padding: const EdgeInsets.only(right: 15),
//     //                         child: Text("KOTEBE",
//     //                             style: TextStyle(
//     //                               fontSize: 6,
//     //                               fontWeight: FontWeight.bold,
//     //                             )),
//     //                       ),
//     //                       Text("UNIVERISTY OF EDUCATION",
//     //                           style: TextStyle(
//     //                             decoration: TextDecoration.underline,
//     //                             fontSize: 6,
//     //                             fontWeight: FontWeight.bold,
//     //                           )),
//     //                       Text("STUDENT UNION MEMBER'S ID",
//     //                           style: TextStyle(
//     //                             fontSize: 6,
//     //                             fontWeight: FontWeight.bold,
//     //                           )),
//     //                     ])),
//     //               ])),
//     //           SizedBox(height: 5),
//     //           Image(height: 256, width: 86, MemoryImage(imageData1)),
//     //           SizedBox(height: 10),
//     //           Container(
//     //               child: Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.center,
//     //                   children: [
//     //                 Text("MIMIKO",
//     //                     style: TextStyle(
//     //                         fontSize: 8, fontWeight: FontWeight.bold)),
//     //                 Text("WATARU",
//     //                     style: TextStyle(
//     //                         fontSize: 8, fontWeight: FontWeight.bold)),
//     //               ])),
//     //           SizedBox(height: 3),
//     //           Container(
//     //               child: Column(
//     //                   crossAxisAlignment: CrossAxisAlignment.center,
//     //                   children: [
//     //                 Text("PSYCHOLOGY",
//     //                     style: const TextStyle(
//     //                       fontSize: 7,
//     //                     )),
//     //                 Text("UGR/38320/13",
//     //                     style: const TextStyle(
//     //                       fontSize: 7,
//     //                     )),
//     //               ])),
//     //           SizedBox(height: 3),
//     //           Container(
//     //               height: 10,
//     //               decoration: BoxDecoration(color: PdfColor.fromHex("#06304b")),
//     //               child: Center(
//     //                   child: Text("PHILANTHROPY SECTOR",
//     //                       style: TextStyle(
//     //                           fontSize: 5,
//     //                           fontWeight: FontWeight.bold,
//     //                           color: PdfColors.white))))
//     //         ])
//     //       ];
//     //     }));
//     // pdf.addPage(MultiPage(
//     //     pageFormat: const PdfPageFormat(
//     //       PdfPageFormat.inch * 2.125,
//     //       PdfPageFormat.inch * 3.375,
//     //     ),
//     //     build: (Context context) {
//     //       return [
//     //         Column(children: [
//     //           SizedBox(height: 30),
//     //           Padding(
//     //               padding: const EdgeInsets.only(left: 20, right: 20),
//     //               child: Row(
//     //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                   children: [
//     //                     Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                           Text("የተሰጠበት ቀን: 02/01/2023",
//     //                               style: TextStyle(fontSize: 6, font: ttf)),
//     //                           Text("Date of Issue",
//     //                               style: const TextStyle(fontSize: 6)),
//     //                           SizedBox(
//     //                             height: 3,
//     //                           ),
//     //                           Text("የሚያበቃበት ቀን: 11/9/2023",
//     //                               style: TextStyle(fontSize: 6, font: ttf)),
//     //                           Text("Expiry Date",
//     //                               style: const TextStyle(fontSize: 6)),
//     //                         ]),
//     //                     Container(
//     //                         height: 30,
//     //                         width: 30,
//     //                         child: BarcodeWidget(
//     //                             data: "1202568", barcode: Barcode.qrCode()))
//     //                   ])),
//     //           SizedBox(height: 10),
//     //           Padding(
//     //               padding: const EdgeInsets.only(left: 20, right: 20),
//     //               child: Row(
//     //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                   crossAxisAlignment: CrossAxisAlignment.start,
//     //                   children: [
//     //                     Column(children: [
//     //                       Image(MemoryImage(sign), height: 200, width: 50),
//     //                       Text("Tarea Sisay",
//     //                           style: TextStyle(
//     //                             fontSize: 5,
//     //                             color: PdfColor.fromHex("#562e61"),
//     //                           )),
//     //                       Text("Student Union President",
//     //                           style: TextStyle(
//     //                               fontSize: 5,
//     //                               decoration: TextDecoration.underline,
//     //                               color: PdfColor.fromHex("#562e61"))),
//     //                       SizedBox(height: 3),
//     //                       Text("የባለስልጣኑ ፊርማ",
//     //                           style: TextStyle(fontSize: 5, font: ttf)),
//     //                       Text("Authorized Signature",
//     //                           style: TextStyle(
//     //                             fontSize: 5,
//     //                             color: PdfColor.fromHex("#562e61"),
//     //                           ))
//     //                     ]),
//     //                     Image(MemoryImage(stamp), height: 70, width: 100)
//     //                   ])),
//     //           SizedBox(height: 3),
//     //           Center(
//     //               child: Column(children: [
//     //             Text("Asmara Road.", style: const TextStyle(fontSize: 5)),
//     //             Text("Yeka Sub-City, Woreda 11",
//     //                 style: const TextStyle(fontSize: 5)),
//     //             Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
//     //                 style: const TextStyle(fontSize: 5)),
//     //             Text("studentunion@kue.edu.et",
//     //                 style: const TextStyle(fontSize: 5))
//     //           ])),
//     //           SizedBox(height: 3),
//     //           Container(height: 1.5, color: PdfColor.fromHex("#06304b")),
//     //           SizedBox(height: 5),
//     //           Center(
//     //               child: Column(children: [
//     //             Text("ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
//     //                 style: TextStyle(fontSize: 5, font: ttf)),
//     //             Text("ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
//     //                 style: TextStyle(fontSize: 5, font: ttf)),
//     //             Text("This ID should be returned to the Student Union Office",
//     //                 style: const TextStyle(fontSize: 5)),
//     //             Text("up on termination or resignation.",
//     //                 style: const TextStyle(fontSize: 5))
//     //           ])),
//     //           SizedBox(height: 5),
//     //           Container(color: PdfColor.fromHex("#06304b"), height: 40.5)
//     //         ])
//     //       ];
//     //     }));

//     return savefile(name: "id", pdf: pdf);
//   }

//   /* pdf.addPage(MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (Context context) {
//           return [
//             Column(children: [Text("llkjglkfjk"), Text("gdfgdfg")])
//           ];
//         }));

//     pdf.addPage(MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return [Center(child: Text("page 2"))];
//         }));
// */
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

// Widget ID(int id) {
//   return Center(
//       child: Container(
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//     Container(
//         decoration: BoxDecoration(border: Border.all(color: PdfColors.red)),
//         height: PdfPageFormat.inch * 3.137,
//         width: PdfPageFormat.inch * 2.125,
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           SizedBox(height: 20),
//           Padding(
//               padding: const EdgeInsets.only(left: 5),
//               child: Row(children: [
//                 //  Image(height: 99, width: 32, MemoryImage(imageData)),
//                 Container(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 15),
//                         child: Text("KOTEBE",
//                             style: TextStyle(
//                               fontSize: 6,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       ),
//                       Text("UNIVERISTY OF EDUCATION",
//                           style: TextStyle(
//                             decoration: TextDecoration.underline,
//                             fontSize: 6,
//                             fontWeight: FontWeight.bold,
//                           )),
//                       Text("STUDENT UNION MEMBER'S ID",
//                           style: TextStyle(
//                             fontSize: 6,
//                             fontWeight: FontWeight.bold,
//                           )),
//                     ])),
//               ])),
//           SizedBox(height: 5),
//           //  Image(height: 256, width: 86, MemoryImage(imageData1)),
//           SizedBox(height: 10),
//           Container(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                 Text("MIMIKO",
//                     style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
//                 Text("WATARU",
//                     style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
//               ])),
//           SizedBox(height: 3),
//           Container(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                 Text("PSYCHOLOGY",
//                     style: const TextStyle(
//                       fontSize: 7,
//                     )),
//                 Text("UGR/38320/13",
//                     style: const TextStyle(
//                       fontSize: 7,
//                     )),
//               ])),
//           SizedBox(height: 3),
//           Container(
//               height: 10,
//               decoration: BoxDecoration(color: PdfColor.fromHex("#06304b")),
//               child: Center(
//                   child: Text("PHILANTHROPY SECTOR",
//                       style: TextStyle(
//                           fontSize: 5,
//                           fontWeight: FontWeight.bold,
//                           color: PdfColors.white))))
//         ])),
//     Container(
//       decoration: BoxDecoration(border: Border.all(color: PdfColors.red)),
//       height: PdfPageFormat.inch * 3.137,
//       width: PdfPageFormat.inch * 2.125,
//     )
//   ])));
// }
// /*  int calculatepageNumber(int lenght) {
//     page = lenght / 3;
//     return page.ceil();
//   } */
