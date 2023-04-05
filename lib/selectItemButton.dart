import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:network_image_search/network_image_search.dart';
import 'miniBitMain.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'openAI.dart';

class itemButton extends StatefulWidget {
  itemButton(this.itemInfo);

  List itemInfo;

  @override
  _itemButton createState() => _itemButton();
}

class _itemButton extends State<itemButton> {
  @override
  @override
  String popData = "";

  Future<String> getGbt(String theObject, String thePrice) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var url = Uri.parse('https://api.openai.com/v1/completions');

    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $apiKey'
    };

    String promptData =
        //"give steps for kids for the proccess of how to save money for ${theObject} that costs ${thePrice} ";
        "steps and tips on how kids can save money to buy ${theObject} that costs ${thePrice}, respond like talking to a kid, don not make response too hard to understand ";

    print(promptData);
    final data = jsonEncode({
      "model": "text-davinci-003",
      "prompt": promptData,
      "temperature": 0.1,
      "max_tokens": 200,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    });

    var response = await http.post(url, headers: headers, body: data);
    print(response.body);

    final gptData = gptDataFromJson(response.body);
    print(gptData);
    return await gptData.choices[0].text;
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
          onPressed: () async {
            popData= await getGbt((widget.itemInfo[0]).toString().substring(2),(widget.itemInfo[1]).toString().substring(2));

            showDialog(
              context: context,
              builder: (context) => getPopup(context,popData),

            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${(widget.itemInfo[0]).toString().substring(2)}'),
              Unsplash(
                width: '40',
                height: '40',
                category:
                    'picture of ${(widget.itemInfo[0]).toString().substring(2)}',
                subcategory:
                    'picture of ${(widget.itemInfo[0]).toString().substring(2)}',
              ),
            ],
          ),
          //substring(1, (widget.itemInfo[0]).toString().length)
        ));
  }
    Widget getPopup(BuildContext context, String theData) {

    return new AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),

      content: Stack(
        //overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade50,
              ),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: ListView(
                      children: [
                        Text(
                          '${ theData}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              child:  Text('back'),
            ),
          )
        ],
      ),
      //https://stackoverflow.com/questions/53913192/flutter-how-to-change-the-width-of-an-alertdialog
    );
  }
}
