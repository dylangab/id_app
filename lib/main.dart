import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/pages/loginPage.dart';
import 'package:id_app/pages/studentPreidentHomePage.dart';
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
            create: (context) => StudentPresidentDataFetch()),
        ChangeNotifierProvider(create: (context) => MembersData()),
        ChangeNotifierProvider(create: (context) => SelectStudentPageBuilder()),
        ChangeNotifierProvider(
          create: (context) => HeadingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => studentInfoButtonBuilder(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateAccountButtonBuilder(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          Provider.of<MembersData>(context, listen: false).initateData;
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.yellow,
              ));
        } else {
          if (userSnapshot.hasData) {
            return const GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: StudentPreidentHomePage());
          }
          return const GetMaterialApp(
              debugShowCheckedModeBanner: false, home: LoginPage());
        }
      },
    );
  }
}
