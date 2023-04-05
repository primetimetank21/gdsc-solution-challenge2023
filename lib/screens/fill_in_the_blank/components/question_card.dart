import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:finlitt_gdsc/screens/fill_in_the_blank/components/question_card.dart";
import "package:finlitt_gdsc/screens/fill_in_the_blank/models/Questions.dart";
import "package:finlitt_gdsc/constants.dart";
import "package:finlitt_gdsc/screens/fill_in_the_blank/components/option.dart";

import "../controllers/question_controller.dart";

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required Key key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),
              key: Key(index.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
