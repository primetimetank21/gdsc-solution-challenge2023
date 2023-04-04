import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finlitt_gdsc/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'openAI.dart';
import 'selectItemButton.dart';

class videoPage extends StatefulWidget {
  //const videoPage({Key? key}) : super(key: key);
  videoPage(this.thetopic);

  String thetopic;

  //topic=this.thetopic;
  @override
  _videoPage createState() => _videoPage();
}

class _videoPage extends State<videoPage> {
  String topic = "";
  int startAmount = 50;
  List userReponceList = [];
  List gptResponce = [];

  List itemsToPick = [];
  final userControl = TextEditingController();
  String apiKey = "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";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    //getData();
    setState(() {});
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        startAmount.toString(),
                        textScaleFactor: 3,
                      ),
                    ),
                  ],
                ),
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
                Column(
                  children: makeResponceList(userReponceList, gptResponce),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            child: Text(
              "Choose an item to buy!",
              textScaleFactor: 1,

            ),
          ),
           Column(children: [

           ],),

           Container(
             height: 100,
             child:            Expanded(
             child: ListView.builder(

                 scrollDirection: Axis.horizontal,
                 shrinkWrap: true,
                 itemCount: itemsToPick.length,
                 itemBuilder: (context, i) {
                   return itemButton(itemsToPick[i]);
                 }),
           ),
           ),


          Container(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  width: 200,
                  height: 100,
                  child: TextField(
                      textInputAction: TextInputAction.done,
                      controller: userControl,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      //https://www.tutorialkart.com/flutter/flutter-textfield/
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      onSubmitted: (value) {
                        //do not do nothing
                        //https://stackoverflow.com/questions/54860198/detect-enter-key-press-in-flutter
                      },
                      onChanged: (value) {}),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: 100,
                  height: 100,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    // onPressed: () {
                    //   FocusManager.instance.primaryFocus?.unfocus();
                    //
                    //   //print("togoooo ${userControl.text}");
                    //   userReponceList.add(userControl.text);
                    //   print(generateText(userControl.text));
                    //   setState(() {});
                    // },
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      //print("togoooo ${userControl.text}");
                      userReponceList.add(userControl.text);
                      //print(generateText(userControl.text));

                      var url =
                          Uri.parse('https://api.openai.com/v1/completions');

                      Map<String, String> headers = {
                        'Content-Type': 'application/json;charset=UTF-8',
                        'Charset': 'utf-8',
                        'Authorization': 'Bearer $apiKey'
                      };

                      //String promptData =
                      "Run simulation where the kid has \$40. Give the kid things to buy and see if the kid saves or spends their money respond like you are talking to a kid , keep reponses short ${userControl.value.text}";

                      String promptData =
                          "Give a list of 6 random items kids buy with their costs as the second seperated by comma not dollar sign that has something to do with the prompt ${userControl.value.text} ";

                      print(promptData);
                      final data = jsonEncode({
                        "model": "text-davinci-003",
                        "prompt": promptData,
                        "temperature": 0.1,
                        "max_tokens": 100,
                        "top_p": 1,
                        "frequency_penalty": 0,
                        "presence_penalty": 0
                      });

                      var response =
                          await http.post(url, headers: headers, body: data);
                      print(response.body);

                      final gptData = gptDataFromJson(response.body);
                      print(gptData);
                      GptData gptReponseData;

                      print(gptData.choices[0].text);
                      gptResponce.add(gptData.choices[0].text);
                      List a = gptData.choices[0].text.split("\n");

                      print(a);
                      //itemsToPick= gptData.choices[0].text
                      List actualItems = [];
                      for (var i = 0; i < a.length; i++) {
                        List b = a[i].toString().split(",");
                        print("goooo ${b}");
                        actualItems.add(b);
                      }
                      for (var i = actualItems.length - 1; i > -1; i--) {
                        print("hmmmm${actualItems[i].length}");
                        if (actualItems[i].length == 1) {
                          print("byee byee ${actualItems}");
                          actualItems.removeAt(i);
                        }
                      }
                      print(actualItems);
                      itemsToPick = actualItems;
                      setState(() {});
                    },
                    child: Text(
                      'go',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> makeItems(listOfItems) {
    List<Widget> widgetList = [];
    for (var i = 0; i < listOfItems.length; i++) {
      print("huhh ${listOfItems[i][0]}");
      if (listOfItems[i][0].length > 0) {
        widgetList.add(FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('${listOfItems[i][0]}'),
        ));
      }
    }

    return widgetList;
  }

  List<Widget> makeResponceList(userResponce, gptRespond) {
    List<Widget> widgetList = [];
    for (var i = 0; i < userResponce.length; i++) {
      widgetList.add(Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "${userResponce[i]}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )));
      widgetList.add(
        Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "${gptRespond[i]}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )),
      );
    }

    return widgetList;
  }
}
