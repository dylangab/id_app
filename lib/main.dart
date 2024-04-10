import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:id_app/controllers/ProvideApi.dart';
import 'package:id_app/models/studentPreident.dart';
import 'package:id_app/pages/Id_error_page.dart';
import 'package:id_app/pages/President%20Account/createPresidentAccount.dart';
import 'package:id_app/pages/President%20Account/view_account.dart';
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
        ChangeNotifierProvider(create: (context) => FilterData()),
        ChangeNotifierProvider(create: (context) => SelectStudentPageBuilder()),
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

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StudentPreidentHomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
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
