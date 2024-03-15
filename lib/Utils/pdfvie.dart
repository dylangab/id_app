// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// //import 'package:open_document/open_document.dart';
// import 'dart:io';
// //import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
// import 'package:pdf/pdf.dart';

// class PdfDisplay extends StatefulWidget {
//   const PdfDisplay({super.key});

//   @override
//   State<PdfDisplay> createState() => _PdfDisplayState();
// }

// class _PdfDisplayState extends State<PdfDisplay> {
//   @override
//   void initState() {
//     super.initState();
//     load();
//   }

//   PDFDocument? document;
//   void load() async {
//     document = await PDFDocument.fromFile(Get.arguments);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PDFViewer(document: document!),
//     );
//   }
// }
