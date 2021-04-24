import 'package:devquiz/challenge/challange_controller.dart';
import 'package:devquiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:devquiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/result/result_page.dart';
import 'package:devquiz/shared/model/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallangePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallangePage({required this.questions, required this.title});

  @override
  _ChallangePageState createState() => _ChallangePageState();
}

class _ChallangePageState extends State<ChallangePage> {
  final challangeController = ChallangeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      challangeController.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear);
  }

  void onSelected(bool value) {
    if (value == true) {
      challangeController.anwsersRight ++;
    }
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: challangeController.currentPageNotifier,
                builder: (context, value, _) =>
                    QuestionIndicatorWidget(
                      currentPage: value,
                      lenght: widget.questions.length,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions.map((e) =>
            QuizWidget(question: e, onSelected:onSelected,)).toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: challangeController.currentPageNotifier,
            builder: (controller, value, _) =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (value < widget.questions.length)
                      Expanded(
                          child: NextButtonWidget.white(
                              label: "Pular",
                              onTap: nextPage)),
                    if (value == widget.questions.length) SizedBox(width: 7),
                    if (value == widget.questions.length)
                      Expanded(
                        child: NextButtonWidget.darkGreen(
                          label: "Confirmar",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResultPage(title: widget.title,
                                      length: widget.questions.length,
                                    result: challangeController.anwsersRight,),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
