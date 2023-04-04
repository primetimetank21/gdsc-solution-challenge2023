// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:finlitt_gdsc/videoPage.dart';
import 'package:finlitt_gdsc/screens/fill_in_the_blank/fill_in_the_blank_quiz.dart';
import "package:get/get.dart";

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

List<Widget> makeListOptions(context) {
  List listOptions = ["Saving", "Budgeting", "Investing", "more?"];
  List<Widget> listStuff = [];
  for (var i = 0; i < listOptions.length; i++) {
    listStuff.add(
      TextButton(
        onPressed: () {
          if (listOptions[i] == "Saving") {
            Get.to(fitbQuizPage());
          } else {
            Get.to(videoPage(listOptions[i]));
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
        child: SizedBox(
          height: 100,
          child: FittedBox(
            //fit: BoxFit.fitWidth,
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                listOptions[i],
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      /*FloatingActionButton(

         child: Icon(Icons.add),
         backgroundColor: Colors.black,
         onPressed: () {
           print("pressed it");


           //setState(() {});
         },
       ),*/
    );
  }

  return listStuff;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const mainScreen(),
      routes: {
        "home": (context) => const mainScreen(),
        "fitbQuiz": (context) => fitbQuizPage(),
      },
    );
  }
}

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);
  @override
  _mainScreen createState() => _mainScreen();
}

class _mainScreen extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GridView.count(
        crossAxisCount: 2,
        children: makeListOptions(context),
      ),
    );
  }
}
