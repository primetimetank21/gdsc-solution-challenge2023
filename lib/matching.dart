import 'package:finlitt_gdsc/screens/fill_in_the_blank/models/Questions.dart';
import 'package:flutter/material.dart';
import 'package:finlitt_gdsc/main.dart';
import 'package:finlitt_gdsc/videoPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class MatchingGamePage extends StatefulWidget {
  @override
  _MatchingGamePageState createState() => _MatchingGamePageState();
}

class _MatchingGamePageState extends State<MatchingGamePage> {
  late List<ItemModel> items;
  late List<ItemModel> items2;

  late int score;
  late bool gameOver;

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          vocab: "Budget",
          definition:
              "A plan on how to spend your money to live life within your means"),
      ItemModel(
          vocab: "Income",
          definition: "The money you make from working or investing"),
      ItemModel(
          vocab: "Gross-pay",
          definition:
              "Total amount of money you earned, before anything is taken out"),
      ItemModel(
          vocab: "Expenses", definition: "Money needed to buy or do something"),
      ItemModel(
          vocab: "Fixed expenses",
          definition:
              "expenses that don't change from month to month (like rent or loan repayments)"),
      ItemModel(
          vocab: "Variable expenses",
          definition:
              "expenses that change from month to month (like groceries, certain utility bills, or entertainment)"),
      ItemModel(vocab: "Bill", definition: "Cost of an item or service"),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) gameOver = true;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Score: "),
              TextSpan(
                  text: "$score",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ))
            ])),
            if (!gameOver)
              Row(
                children: <Widget>[
                  Column(
                      children: items.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: Text(
                          item.vocab,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 15.0),
                        ),
                        feedback: Text(
                          item.vocab,
                          style: const TextStyle(
                              color: Colors.teal, fontSize: 15.0),
                        ),
                        child: Text(
                          item.vocab,
                          style: const TextStyle(
                              color: Colors.teal, fontSize: 15.0),
                        ),
                      ),
                    );
                  }).toList()),
                  const Spacer(),
                  Column(
                      children: items2.map((item) {
                    return DragTarget<ItemModel>(
                      onAccept: (receivedItem) {
                        if (item.definition == receivedItem.definition) {
                          setState(() {
                            items.remove(receivedItem);
                            items2.remove(item);
                            score += 10;
                            item.accepting = false;
                          });
                        } else {
                          setState(() {
                            score -= 5;
                            item.accepting = false;
                          });
                        }
                      },
                      onLeave: (receivedItem) {
                        setState(() {
                          item.accepting = false;
                        });
                      },
                      onWillAccept: (receivedItem) {
                        setState(() {
                          item.accepting = true;
                        });
                        return true;
                      },
                      builder: (context, acceptedItems, rejectedItem) =>
                          Container(
                        color: item.accepting ? Colors.red : Colors.teal,
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8.0),
                        child: Text(
                          item.definition,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    );
                  }).toList()),
                ],
              ),
            // if (gameOver)
            if (gameOver)
              const Text(
                "GameOver",
                style: TextStyle(
                  color: Colors.red,
                  // fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            if (gameOver)
              Center(
                child: ElevatedButton(
                  // style: ButtonStyle(
                  //     textStyle: TextStyle(color: Colors.white),
                  //     backgroundColor: Colors.pink),
                  child: const Text("New Game"),
                  onPressed: () {
                    saveScore("matching", score);
                    initGame();
                    setState(() {});
                  },
                ),
              ),
            if (gameOver)
              Center(
                child: ElevatedButton(
                  // style: ButtonStyle(
                  //     textStyle: TextStyle(color: Colors.white),
                  //     backgroundColor: Colors.pink),
                  child: const Text("Home"),
                  onPressed: () {
                    saveScore("matching", score);
                    Get.back();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String vocab;
  final String definition;
  bool accepting;

  ItemModel({this.vocab = '', this.definition = '', this.accepting = false});
}
