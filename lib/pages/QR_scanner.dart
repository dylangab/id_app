import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_app/Utils/helperFunctions.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/models/member.dart';
import 'package:id_app/pages/studentInfoPage.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  QrPageState createState() => QrPageState();
}

class QrPageState extends State<QrPage> {
  Result? currentResult;
  int? output = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRCodeDartScanView(
        typeScan: TypeScan.live,
        scanInvertedQRCode: true,
        onCapture: (Result result) async {
          List<Member> list =
              Provider.of<MembersData>(context, listen: false).membersList;
          setState(() {
            currentResult = result;
          });
          output =
              await HelperFunctions().getIndexById(list, currentResult!.text);
          if (output == 1) {
            Provider.of<studentInfoButtonBuilder>(listen: false, context)
                .passValue(output, false, "Generate ID");
            Get.to(() => const StudentInfoPage());
          }
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                output == -1
                    ? Text('Text: ${currentResult?.text} ID does not exist')
                    : const Text("Scan ID"),
                //   Text('Format: ${currentResult?.barcodeFormat ?? 'Not found'}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
