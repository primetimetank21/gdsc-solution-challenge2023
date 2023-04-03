import 'package:flutter/material.dart';

class fitbQuizPage extends StatefulWidget {
  // fitbQuizPage(this.)
  @override
  _fitbQuizPage createState() => _fitbQuizPage();
}

class _fitbQuizPage extends State<fitbQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 100,
          ),
          const Center(
            child: Text(
              "Hello! This is the quizPage",
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
