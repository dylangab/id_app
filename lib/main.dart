import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/pages/createPresidentAccount.dart';
import 'package:id_app/pages/createSectorAccountPage.dart';
import 'package:id_app/pages/loginPage.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
import 'package:id_app/pages/viewMembersPage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ValuePass(),
        ),
        ChangeNotifierProvider(
          create: (context) => HeadingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => studentInfoButtonBuilder(),
        ),
        ChangeNotifierProvider(create: (context) => DropdownValueController()),
        ChangeNotifierProvider(create: (context) => MultiIdGenerate()),
        ChangeNotifierProvider(
          create: (context) => CreateAccountButtonBuilder(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: ViewMembersPage(),
    );
  }
}
