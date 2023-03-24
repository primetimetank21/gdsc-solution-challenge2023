import 'package:flutter/material.dart';
import 'package:finlitt_gdsc/main.dart';




class videoPage extends StatefulWidget {
  //const videoPage({Key? key}) : super(key: key);
   videoPage(this.thetopic);
   String thetopic;

  //topic=this.thetopic;
  @override
  _videoPage createState() => _videoPage();
}

class _videoPage extends State<videoPage> {
   String topic="";
  void initState() {
    //getData();
    setState(() {});
    super.initState();
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 100,
          ),
          Center(
            child: Text(
              widget.thetopic,

              textScaleFactor: 3,
            ),
          ),
          Container(
            height: 50,
          ),
          Container(
            height: 50,





          ),

        ],
      ),
    );
  }
}
