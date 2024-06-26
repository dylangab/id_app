import 'package:flutter/material.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/models/member.dart';
import 'package:provider/provider.dart';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  QrPageState createState() => QrPageState();
}

class QrPageState extends State<QrPage> {
  int? output;
  String barcode = "";
  @override
  Widget build(BuildContext context) {
    List<Member> list =
        Provider.of<MembersData>(context, listen: false).membersList;
    return Scaffold(
      body: AiBarcodeScanner(
        validator: (value) {
          return getIndexById(list, value);
        },
        canPop: false,
        onScan: (String value) async {},
        onDetect: (p0) {},
        onDispose: () {
          debugPrint("Barcode scanner disposed!");
        },
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
        ),
      ),
    );
  }

  bool getIndexById(List<Member> studentList, String id) {
    for (var i = 0; i < studentList.length; i++) {
      if (studentList[i].studentId == id) {
        return true;
      }
    }
    return false;
  }
}
