import 'package:flutter/material.dart';
import 'package:green_book/Utils/SizeConfig.dart';
import 'package:green_book/Utils/Utils.dart';
import 'package:green_book/helper/UIHelper.dart';
import 'package:green_book/models/CategoryModel.dart';
import 'package:green_book/models/QuestionModel.dart';

import '../api.dart';

class QuizScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  QuizScreen(this.categoryModel);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuestionModel> questionList = [];
  int count = 0;
  bool isCorrect = false;
  bool isOptionSelected = false;
  int selectedOptionIndex = -1;
  List<int> answers = [];

  @override
  void initState() {
    super.initState();
    API().fetchQuestion(widget.categoryModel.apiLink).then((value) {
      print(value);
      value.forEach((question) {
        print(question);
        QuestionModel questionModel = new QuestionModel();
        questionModel.question = question['q'];
        questionModel.options.add(question['o1']!.toString());
        questionModel.options.add(question['o2']!.toString());
        questionModel.options.add(question['o3']!.toString());
        questionModel.options.add(question['o4']!.toString());

        questionModel.correctOption = question['co']!.toString();

        setState(() {
          questionList.add(questionModel);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return questionList.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Utils.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: UIHelper.getAppBarView(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF236D72), Color(0xFF4D9196)],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.safeBlockVertical * 0.5),
                          child: Text(
                            widget.categoryModel.name!,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Utils.white),
                          ),
                        ),
                        Text(
                          "Level-1",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 2.5,
                              color: Utils.white),
                        ),
                      ],
                    ),
                  ),
                  Row(children: _buildStatusBar()),
                  Text((count + 1).toString() +
                      "/" +
                      questionList.length.toString()),
                  Card(
                    margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 4),
                    elevation: 1.0,
                    child: ListTile(
                      title: Text(questionList[count].question!),
                      // subtitle: Text(questionList[]),
                    ),
                  ),
                  ListView.builder(
                    itemCount: questionList[count].options.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return getOptionView(questionList[count].options, index);
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 4),
              child: UIHelper.getBottomText(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              height: 44,
              width: SizeConfig.screenWidth * 2 / 3,
              child: FloatingActionButton.extended(
                onPressed: () {
                  answers.add(-1);
                  if (isCorrect) {
                    answers[count] = 1;
                  } else {
                    answers[count] = 0;
                  }

                  count++;
                  if (count == questionList.length) {
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      isOptionSelected = false;
                      isCorrect = false;
                      selectedOptionIndex = -1;
                    });
                  }
                  // Add your onPressed code here!
                },
                label: Text(
                  isCorrect ? "Next" : "Skip",
                  style: TextStyle(
                    color: isCorrect ? Utils.white : Utils.mustard,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  side: BorderSide(
                    color: isCorrect ? Utils.lightGreen : Utils.mustard,
                  ),
                ),
                backgroundColor: isCorrect ? Utils.lightGreen : Utils.newGrey,
              ),
            ),
          );
  }

  Widget getOptionView(List options, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: isOptionSelected && selectedOptionIndex == index
                ? isCorrect
                    ? Utils.green
                    : Utils.red
                : Utils.lightGrey),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 4,
          vertical: SizeConfig.safeBlockVertical * 0.5),
      elevation: 1.0,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOptionSelected && selectedOptionIndex == index
                  ? isCorrect
                      ? Utils.green
                      : Utils.red
                  : Utils.grey),
          child: Icon(isOptionSelected && selectedOptionIndex == index
              ? isCorrect
                  ? Icons.done
                  : Icons.close
              : null),
        ),
        onTap: () {
          isOptionSelected = true;
          selectedOptionIndex = index;

          if (options[index] == questionList[count].correctOption) {
            setState(() {
              isCorrect = true;
            });
          } else {
            setState(() {
              isCorrect = false;
            });
          }
        },
        title: Text(options[index]),
      ),
    );
  }

  _buildStatusBar() {
    List<Widget> statusBar = [];
    answers.forEach(
      (element) {
        statusBar.add(
          Container(
            height: 6,
            width: SizeConfig.screenWidth / questionList.length,
            color: element == -1
                ? Utils.grey
                : element == 0
                    ? Utils.red
                    : Utils.mustard,
          ),
        );
      },
    );
    return statusBar;
  }
}
