import "dart:math";

import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:finlitt_gdsc/screens/fill_in_the_blank/controllers/question_controller.dart";

import "package:finlitt_gdsc/screens/fill_in_the_blank/components/body.dart";

class fitbQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int keyNum = Random().nextInt(10);
    Key key = Key(keyNum.toString());

    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        // ],
      ),
      body: Body(key: key),
    );
  }
}
