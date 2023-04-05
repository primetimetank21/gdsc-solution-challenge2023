import 'package:flutter/widgets.dart';
import "package:finlitt_gdsc/screens/fill_in_the_blank/models/Questions.dart";
// We use get package for our state management
import 'package:get/get.dart';

class QuestionController extends GetxController {
  late PageController _pageController;
  PageController get pageController => this._pageController;

  final List<Question> _questions = fill_in_the_blank_questions_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns)
      _numOfCorrectAns += 10;
    else
      _numOfCorrectAns -= 5;

    // It will stop the counter
    update();

    // Once user select an ans after 1.5s it will go to the next qn
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      // Save user's score to Firestore
      saveScore("fill_in_the_blank", _numOfCorrectAns);

      // Get package provide us simple way to navigate another page
      Get.back();
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
