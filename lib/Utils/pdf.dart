import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:id_app/models/member.dart';
import 'package:id_app/pages/selectstudents.dart';
//import 'package:open_document/my_files/init.dart';
import 'package:pdf/pdf.dart';
//import 'package:barcode_widget/barcode_widget.dart' ;
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';

class PdfApi {
  Future<File> savefile({required String name, required Document pdf}) async {
    final byte = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$name.pdf");
    await file.writeAsBytes(byte);

    try {
      DocumentFileSavePlus().saveFile(byte, "$name.pdf", "appliation/pdf");

      print('File saved successfully');

      // Display the PDF after saving
    } catch (e) {
      print('Error saving file: $e');
      // Handle error gracefully
    }

    return file;
  }

  Future<File> generateSingleId(Member member) async {
    final ByteData image = await rootBundle.load('assets/images/logo.png');

    final ByteData imagestamp =
        await rootBundle.load('assets/images/stamp.jpg');

    final font = await rootBundle.load("assets/fonts/AbyssinicaSIL-R.ttf");

    final ttf = Font.ttf(font);
    final ByteData image2 = await rootBundle.load('assets/images/sign.jpg');
    Uint8List sign = (image2).buffer.asUint8List();
    Uint8List stamp = (imagestamp).buffer.asUint8List();

    Uint8List logo = (image).buffer.asUint8List();
    final pdf = Document();
    final img = await networkImage(member.studentPhoto!);
    pdf.addPage(MultiPage(
        pageFormat: const PdfPageFormat(
            PdfPageFormat.inch * 2.125, PdfPageFormat.inch * 3.375),
        build: (Context context) {
          return [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(children: [
                    Image(height: 99, width: 32, MemoryImage(logo)),
                    SizedBox(width: 5),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text("KOTEBE",
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Text("UNIVERISTY OF EDUCATION",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("STUDENT UNION MEMBER'S ID",
                              style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                              )),
                        ])),
                  ])),
              SizedBox(height: 5),
              SizedBox(
                child: Image(img, fit: BoxFit.fill),
                height: 120,
                width: 100,
              ),
              SizedBox(height: 10),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text(member.firstName!,
                        style: TextStyle(
                            fontSize: 8, fontWeight: FontWeight.bold)),
                    Text(member.lastName!,
                        style: TextStyle(
                            fontSize: 8, fontWeight: FontWeight.bold)),
                  ])),
              SizedBox(height: 3),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Text(member.department!,
                        style: const TextStyle(
                          fontSize: 7,
                        )),
                    Text(member.studentId!,
                        style: const TextStyle(
                          fontSize: 7,
                        )),
                  ])),
              SizedBox(height: 3),
              Container(
                  height: 10,
                  decoration: BoxDecoration(color: PdfColor.fromHex("#06304b")),
                  child: Center(
                      child: Text("${member.sector!} SECTOR",
                          style: TextStyle(
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white))))
            ])
          ];
        }));
    pdf.addPage(MultiPage(
        pageFormat: const PdfPageFormat(
            PdfPageFormat.inch * 2.125, PdfPageFormat.inch * 3.375),
        build: (Context context) {
          return [
            Column(children: [
              SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("የተሰጠበት ቀን: 02/01/2023",
                                  style: TextStyle(fontSize: 6, font: ttf)),
                              Text("Date of Issue",
                                  style: const TextStyle(fontSize: 6)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("የሚያበቃበት ቀን: 11/9/2023",
                                  style: TextStyle(fontSize: 6, font: ttf)),
                              Text("Expiry Date",
                                  style: const TextStyle(fontSize: 6)),
                            ]),
                        Container(
                            height: 30,
                            width: 30,
                            child: BarcodeWidget(
                                data: "1202568", barcode: Barcode.qrCode()))
                      ])),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: [
                          Image(MemoryImage(sign), height: 200, width: 50),
                          Text("Tarea Sisay",
                              style: TextStyle(
                                fontSize: 5,
                                color: PdfColor.fromHex("#562e61"),
                              )),
                          Text("Student Union President",
                              style: TextStyle(
                                  fontSize: 5,
                                  decoration: TextDecoration.underline,
                                  color: PdfColor.fromHex("#562e61"))),
                          SizedBox(height: 3),
                          Text("የባለስልጣኑ ፊርማ",
                              style: TextStyle(fontSize: 5, font: ttf)),
                          Text("Authorized Signature",
                              style: TextStyle(
                                fontSize: 5,
                                color: PdfColor.fromHex("#562e61"),
                              ))
                        ]),
                        Image(MemoryImage(stamp), height: 70, width: 100)
                      ])),
              SizedBox(height: 3),
              Center(
                  child: Column(children: [
                Text("Asmara Road.", style: const TextStyle(fontSize: 5)),
                Text("Yeka Sub-City, Woreda 11",
                    style: const TextStyle(fontSize: 5)),
                Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
                    style: const TextStyle(fontSize: 5)),
                Text("studentunion@kue.edu.et",
                    style: const TextStyle(fontSize: 5))
              ])),
              SizedBox(height: 3),
              Container(height: 1.5, color: PdfColor.fromHex("#06304b")),
              SizedBox(height: 5),
              Center(
                  child: Column(children: [
                Text("ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
                    style: TextStyle(fontSize: 5, font: ttf)),
                Text("ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
                    style: TextStyle(fontSize: 5, font: ttf)),
                Text("This ID should be returned to the Student Union Office",
                    style: const TextStyle(fontSize: 5)),
                Text("up on termination or resignation.",
                    style: const TextStyle(fontSize: 5))
              ])),
              SizedBox(height: 5),
              Container(color: PdfColor.fromHex("#06304b"), height: 40.5)
            ])
          ];
        }));
    return savefile(
        name: "${member.firstName} ${DateTime.timestamp()}", pdf: pdf);
  }

  Future<File> generateMultiId(List<Member> studentList) async {
    final ByteData image = await rootBundle.load('assets/images/logo.png');

    final ByteData imagestamp =
        await rootBundle.load('assets/images/stamp.jpg');

    final font = await rootBundle.load("assets/fonts/AbyssinicaSIL-R.ttf");

    final ttf = Font.ttf(font);
    final ByteData image2 = await rootBundle.load('assets/images/sign.jpg');
    Uint8List sign = (image2).buffer.asUint8List();
    Uint8List stamp = (imagestamp).buffer.asUint8List();

    Uint8List logo = (image).buffer.asUint8List();
    final pdf = Document();

    for (var element in studentList) {
      final img = await networkImage(element.studentPhoto!);
      pdf.addPage(MultiPage(
          pageFormat: const PdfPageFormat(
              PdfPageFormat.inch * 2.125, PdfPageFormat.inch * 3.375),
          build: (Context context) {
            return [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(children: [
                      Image(height: 99, width: 32, MemoryImage(logo)),
                      SizedBox(width: 5),
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text("KOTEBE",
                                  style: TextStyle(
                                    fontSize: 6,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Text("UNIVERISTY OF EDUCATION",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("STUDENT UNION MEMBER'S ID",
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                )),
                          ])),
                    ])),
                SizedBox(height: 5),
                SizedBox(
                  child: Image(img, fit: BoxFit.fill),
                  height: 120,
                  width: 100,
                ),
                SizedBox(height: 10),
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(element.firstName!,
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                      Text(element.lastName!,
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                    ])),
                SizedBox(height: 3),
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(element.department!,
                          style: const TextStyle(
                            fontSize: 7,
                          )),
                      Text(element.studentId!,
                          style: const TextStyle(
                            fontSize: 7,
                          )),
                    ])),
                SizedBox(height: 3),
                Container(
                    height: 10,
                    decoration:
                        BoxDecoration(color: PdfColor.fromHex("#06304b")),
                    child: Center(
                        child: Text("${element.sector!} SECTOR",
                            style: TextStyle(
                                fontSize: 5,
                                fontWeight: FontWeight.bold,
                                color: PdfColors.white))))
              ])
            ];
          }));
      pdf.addPage(MultiPage(
          pageFormat: const PdfPageFormat(
              PdfPageFormat.inch * 2.125, PdfPageFormat.inch * 3.375),
          build: (Context context) {
            return [
              Column(children: [
                SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("የተሰጠበት ቀን: 02/01/2023",
                                    style: TextStyle(fontSize: 6, font: ttf)),
                                Text("Date of Issue",
                                    style: const TextStyle(fontSize: 6)),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("የሚያበቃበት ቀን: 11/9/2023",
                                    style: TextStyle(fontSize: 6, font: ttf)),
                                Text("Expiry Date",
                                    style: const TextStyle(fontSize: 6)),
                              ]),
                          Container(
                              height: 30,
                              width: 30,
                              child: BarcodeWidget(
                                  data: "1202568", barcode: Barcode.qrCode()))
                        ])),
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            Image(MemoryImage(sign), height: 200, width: 50),
                            Text("Tarea Sisay",
                                style: TextStyle(
                                  fontSize: 5,
                                  color: PdfColor.fromHex("#562e61"),
                                )),
                            Text("Student Union President",
                                style: TextStyle(
                                    fontSize: 5,
                                    decoration: TextDecoration.underline,
                                    color: PdfColor.fromHex("#562e61"))),
                            SizedBox(height: 3),
                            Text("የባለስልጣኑ ፊርማ",
                                style: TextStyle(fontSize: 5, font: ttf)),
                            Text("Authorized Signature",
                                style: TextStyle(
                                  fontSize: 5,
                                  color: PdfColor.fromHex("#562e61"),
                                ))
                          ]),
                          Image(MemoryImage(stamp), height: 70, width: 100)
                        ])),
                SizedBox(height: 3),
                Center(
                    child: Column(children: [
                  Text("Asmara Road.", style: const TextStyle(fontSize: 5)),
                  Text("Yeka Sub-City, Woreda 11",
                      style: const TextStyle(fontSize: 5)),
                  Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
                      style: const TextStyle(fontSize: 5)),
                  Text("studentunion@kue.edu.et",
                      style: const TextStyle(fontSize: 5))
                ])),
                SizedBox(height: 3),
                Container(height: 1.5, color: PdfColor.fromHex("#06304b")),
                SizedBox(height: 5),
                Center(
                    child: Column(children: [
                  Text("ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
                      style: TextStyle(fontSize: 5, font: ttf)),
                  Text("ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
                      style: TextStyle(fontSize: 5, font: ttf)),
                  Text("This ID should be returned to the Student Union Office",
                      style: const TextStyle(fontSize: 5)),
                  Text("up on termination or resignation.",
                      style: const TextStyle(fontSize: 5))
                ])),
                SizedBox(height: 5),
                Container(color: PdfColor.fromHex("#06304b"), height: 40.5)
              ])
            ];
          }));
    }
    return savefile(name: "IDs ${DateTime.timestamp()}", pdf: pdf);
  }

  Future<File> generateMultiPage(List<Member> member) async {
    int page = calculatepageNumber(member.length);
    int range = 0;
    final pdf = Document();
    final ByteData image = await rootBundle.load('assets/images/logo.png');

    final ByteData imagestamp =
        await rootBundle.load('assets/images/stamp.jpg');

    final font = await rootBundle.load("assets/fonts/AbyssinicaSIL-R.ttf");

    final ttf = Font.ttf(font);
    final ByteData image2 = await rootBundle.load('assets/images/sign.jpg');
    Uint8List sign = (image2).buffer.asUint8List();
    Uint8List stamp = (imagestamp).buffer.asUint8List();

    Uint8List logo = (image).buffer.asUint8List();

    for (var i = 0; i < page; i++) {
      List<Widget> list = [];
      int counter = 0;

      for (var element in member.getRange(range, member.length)) {
        final img = await networkImage(element.studentPhoto!);
        list.add(Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: PdfColors.red)),
                height: PdfPageFormat.inch * 3.137,
                width: PdfPageFormat.inch * 2.125,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(children: [
                            Image(height: 99, width: 32, MemoryImage(logo)),
                            Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text("KOTEBE",
                                        style: TextStyle(
                                          fontSize: 6,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Text("UNIVERISTY OF EDUCATION",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("STUDENT UNION MEMBER'S ID",
                                      style: TextStyle(
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ])),
                          ])),
                      SizedBox(height: 5),
                      SizedBox(
                          height: 120,
                          width: 100,
                          child: Image(fit: BoxFit.fill, img)),
                      SizedBox(height: 10),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text(element.firstName!,
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold)),
                            Text(element.role!,
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.bold)),
                          ])),
                      SizedBox(height: 3),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text(element.department!,
                                style: const TextStyle(
                                  fontSize: 7,
                                )),
                            Text(element.studentId!,
                                style: const TextStyle(
                                  fontSize: 7,
                                )),
                          ])),
                      SizedBox(height: 3),
                      Container(
                          height: 10,
                          decoration:
                              BoxDecoration(color: PdfColor.fromHex("#06304b")),
                          child: Center(
                              child: Text("${element.sector!} SECTOR",
                                  style: TextStyle(
                                      fontSize: 5,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.white))))
                    ])),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: PdfColors.red)),
                height: PdfPageFormat.inch * 3.137,
                width: PdfPageFormat.inch * 2.125,
                child: Column(children: [
                  SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("የተሰጠበት ቀን: 02/01/2023",
                                      style: TextStyle(fontSize: 6, font: ttf)),
                                  Text("Date of Issue",
                                      style: const TextStyle(fontSize: 6)),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text("የሚያበቃበት ቀን: 11/9/2023",
                                      style: TextStyle(fontSize: 6, font: ttf)),
                                  Text("Expiry Date",
                                      style: const TextStyle(fontSize: 6)),
                                ]),
                            Container(
                                height: 30,
                                width: 30,
                                child: BarcodeWidget(
                                    data: "1202568", barcode: Barcode.qrCode()))
                          ])),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              Image(MemoryImage(sign), height: 200, width: 50),
                              Text("Tarea Sisay",
                                  style: TextStyle(
                                    fontSize: 5,
                                    color: PdfColor.fromHex("#562e61"),
                                  )),
                              Text("Student Union President",
                                  style: TextStyle(
                                      fontSize: 5,
                                      decoration: TextDecoration.underline,
                                      color: PdfColor.fromHex("#562e61"))),
                              SizedBox(height: 3),
                              Text("የባለስልጣኑ ፊርማ",
                                  style: TextStyle(fontSize: 5, font: ttf)),
                              Text("Authorized Signature",
                                  style: TextStyle(
                                    fontSize: 5,
                                    color: PdfColor.fromHex("#562e61"),
                                  ))
                            ]),
                            Image(MemoryImage(stamp), height: 70, width: 100)
                          ])),
                  SizedBox(height: 3),
                  Center(
                      child: Column(children: [
                    Text("Asmara Road.", style: const TextStyle(fontSize: 5)),
                    Text("Yeka Sub-City, Woreda 11",
                        style: const TextStyle(fontSize: 5)),
                    Text("PO.BOX 31248, Addis Ababa, ETHIOPIA",
                        style: const TextStyle(fontSize: 5)),
                    Text("studentunion@kue.edu.et",
                        style: const TextStyle(fontSize: 5))
                  ])),
                  SizedBox(height: 3),
                  Container(height: 1.5, color: PdfColor.fromHex("#06304b")),
                  SizedBox(height: 5),
                  Center(
                      child: Column(children: [
                    Text("ተማሪው ህብረቱን በሚለቅበት ጊዜ ይህን መታወቂያ ካርድ",
                        style: TextStyle(fontSize: 5, font: ttf)),
                    Text("ለህብረቱ ጽ/ቤት ተመላሽ ማድረግ አለበት።",
                        style: TextStyle(fontSize: 5, font: ttf)),
                    Text(
                        "This ID should be returned to the Student Union Office",
                        style: const TextStyle(fontSize: 5)),
                    Text("up on termination or resignation.",
                        style: const TextStyle(fontSize: 5))
                  ])),
                  SizedBox(height: 5),
                  Container(color: PdfColor.fromHex("#06304b"), height: 40.5)
                ])),
          ]),
          SizedBox(height: 10)
        ]));
        counter++;
        if (counter == 3) {
          counter = 0;
          range = range + 3;
          break;
        }
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return list;
        },
      ));
    }

    return savefile(name: "IDs ${DateTime.timestamp()}", pdf: pdf);
  }

  int calculatepageNumber(int lenght) {
    double page = 0;
    page = lenght / 3;
    return page.ceil();
  }
}
