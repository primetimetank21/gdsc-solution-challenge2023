// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

/// Saves score to Firestore database
void saveScore(String quizName, int score) {
  Map<String, String> quizScore = {
    "quiz_name": "fill_in_the_blank",
    "score": score.toString()
  };
  FirebaseFirestore.instance.collection("quiz_scores").add(quizScore);
  print("$quizName score: $score");
}

// ignore: constant_identifier_names
const List fill_in_the_blank_questions_data = [
  {
    "id": 1,
    "question": "Having a(n) ______ will help you cover an unexpected bill.",
    "options": ["Emergency fund", "Generous grandma", "Budget"],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question":
        "After the ______ you will not be penalized for taking out money or closing your account.",
    "options": ["Deposit period", "Withdrawal period", "None of these"],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question":
        "Joey wants to save for a new game that comes out next month. This is an example of a ______ goal.",
    "options": ["Maturity date", "Long term", "Short term"],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question":
        "Tiana has always dreamed of opening a restaurant. She has saved all her tips for the last 3 years. Soon she will be able to open up her dream restaurant. This is an example of ______ saving.",
    "options": ["Mid term", "Long term", "Short term"],
    "answer_index": 1,
  },
  {
    "id": 5,
    "question":
        "A(n) ______ would be better for Jordan since they don’t plan on spending their birthday money now.",
    "options": ["Checking account", "IOU", "Savings account"],
    "answer_index": 2,
  },
  {
    "id": 6,
    "question":
        "Money placed in saving accounts gains ______, so your money will grow a certain amount the longer you keep it in there and the more you add.",
    "options": ["Interest", "Muscle", "Speed"],
    "answer_index": 0,
  },
  {
    "id": 7,
    "question":
        "Certificates of deposit have a maturity date, which means that you cannot withdraw them until a ______ date",
    "options": ["Random", "Specific", "Romantic"],
    "answer_index": 1,
  },
  {
    "id": 8,
    "question":
        "Money in savings accounts has more ______ than Certificates of Deposit because it can be withdrawn anytime.",
    "options": ["None of these", "Interest", "Liquidity"],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question":
        "Your ______ fund should be kept in a liquid savings account so that you can access it on short notice.",
    "options": ["Mutual", "Index", "Emergency"],
    "answer_index": 2,
  },
  {
    "id": 10,
    "question":
        "______ can be kept in bonds since they don’t need to be accessed at short notice.",
    "options": ["Savings", "Long term savings", "None of these"],
    "answer_index": 1,
  },
];
