import 'package:flutter/material.dart';
import 'package:finlitt_gdsc/videoPage.dart';

// Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

List<Widget> makeListOptions(context) {
  List listOptions = ["Saving", "Spending", "run", "jump", "sleep", "more?"];
  List<Widget> listStuff = [];
  for (var i = 0; i < listOptions.length; i++) {
    listStuff.add(
      TextButton(
        onPressed: () {
          print(listOptions[i]);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => videoPage(listOptions[i]),
              ));
        },
        style: TextButton.styleFrom(
          primary: Colors.black,
        ),
        child: Container(
          height: 100,
          child: FittedBox(
            //fit: BoxFit.fitWidth,
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                listOptions[i],
                style: TextStyle(
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
    return MaterialApp(
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
      home: mainScreen(),
    );
  }
}

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);
  @override
  _mainScreen createState() => _mainScreen();
}

class _mainScreen extends State<mainScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GridView.count(
        crossAxisCount: 2,
        children: makeListOptions(context),
      ),
/*
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(6,(index){
              return Center(child: Text("hi",        style: Theme.of(context).textTheme.headlineSmall,
              ));

            }),


          ),
    */
    );
  }
}


/*child: Text(
    listOptions[i],
      style: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,

  ),

 */