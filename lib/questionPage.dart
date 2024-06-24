
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz/Score.dart';
import 'package:quiz/apiHelper.dart';

class QuestionPage extends StatefulWidget {
   final String cat;
  final String level;
  final String Qtype;
  final String Qamount;
  var name;

  QuestionPage({
    Key? key,
    required this.cat,
  })  : level = "",
        Qtype = "",
        Qamount = "";

  QuestionPage.full({
    Key? key,
    required this.cat,
    required this.level,
    required this.Qtype,
    required this.Qamount,
    required this.name,
  });


  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List responseData = [];
  int number = 0;
  late ApiHelper apiHelper;
  Color defaultt = Colors.blue;
  int score = 0;
  String view = "";
  bool optionSelected = false;
  List<String> options = [];
  int sec = 30;
  Timer? timer;
  int correct = 0;
  int wrong = 0;
  String selectedOption = "";

  @override
  void initState() {
    super.initState();
    apiHelper = ApiHelper(widget.cat, widget.level, widget.Qtype, widget.Qamount);
    fetchQuestions();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchQuestions() async {
    List data = await apiHelper.fetchQuestions();
    setState(() {
      responseData = data;
      optionAdd();
    });
  }

//displaying level
  String _level(String level) {
    switch (level) {
      case 'easy':
        return 'Easy';
      case 'medium':
        return 'Medium';
      case 'hard':
        return 'Hard';
      default:
        return 'Easy';
    }
  }

//displaying category name
  String _getCategoryName(String category) {
    switch (category) {
      case '9':
        return 'General Knowledge';
      case '10':
        return 'Book';
      case '17':
        return 'Science';
      case '22':
        return 'Geography';
      case '24':
        return 'Politics';
      case '27':
        return 'Animal';
      case '28':
        return 'Vehicle';
      case '23':
        return 'History';
      case '21':
        return 'Sports';
      case '30':
        return 'Gadgets';
      case '18':
        return 'Computer';
      case '19':
        return 'Music';
      case '11':
        return 'Film';
      case '20':
        return 'Mathematics';
      case '25':
        return 'Art';
      default:
        return '9';
    }
  }

//Incorrect and correct options adding to list options
  void optionAdd() {
    if (responseData.isNotEmpty) {
      options.clear();
      options.add(responseData[number]['correct_answer'].toString());
      options.addAll(responseData[number]['incorrect_answers'].cast<String>());
      options.shuffle();
    }
  }

  void nextQuestion() {
    setState(() {
      sec = 30;
      if (number < responseData.length - 1) {
        number++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Score(
                    score: score.toString(),
                    correct: correct.toString(),
                    wrong: wrong.toString(),
                    name: widget.name,
                  )),
        );
      }
      defaultt = Colors.blue;
      optionSelected = false;
      selectedOption = "";
      optionAdd();
    });
  }

//Timer
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sec--;
      });
      if (sec <= 0) {
        nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (responseData.isEmpty || number >= responseData.length) {
      return Scaffold(
        backgroundColor: Color(0xff243949),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Color(0xff517fa4),
            strokeWidth: 2,
          ),
        ),
      );
    }

String correctAnswer = responseData[number]['correct_answer'].toString();

    return Scaffold(
      backgroundColor: Color(0xff243949),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/question_marks.jpg"), // Background image
            fit: BoxFit.cover,
           
            alignment: Alignment.topCenter,
            scale: MediaQuery.of(context).size.width > 600 ? 0.5 : 1.0,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: buildQuestionLayout(correctAnswer, context),
                  ),
                ],
              );
            } else {
              return buildQuestionLayout(correctAnswer, context);
            }
          },
        ),
      ),
    );
  }

  Widget buildQuestionLayout(String correctAnswer, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${number + 1} / ${widget.Qamount}",
                  style: TextStyle(
                      fontSize: screenWidth < 400 ? 15 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Expanded(
                    child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '$sec',
                        style: TextStyle(
                            fontSize: screenWidth < 400 ? 20 : 24,
                            color: sec > 10 ? Colors.white : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      //Timer 
                      Container(
                        width: screenWidth < 400 ? 50 : 80,
                        height: screenWidth < 400 ? 50 : 80,
                        child: CircularProgressIndicator(
                          value: sec / 30,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    ],
                  ),
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        _level(widget.level),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _getCategoryName(widget.cat),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade200, width: 2),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  responseData.isNotEmpty
                      ? responseData[number]['question']
                      : '',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              for (var option in options)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!optionSelected) {
                          optionSelected = true;
                          selectedOption = option;
                          if (option == correctAnswer) {
                            correct++;
                            score += 5;
                          } else {
                            wrong++;
                          }
                        }
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color:  option == selectedOption
                              ? (option == correctAnswer ? Color.fromARGB(255, 127, 199, 103) : const Color.fromARGB(255, 229, 117, 109))
                              : Colors.blue.shade200,
                        border: Border.all(
                          color: option == selectedOption
                              ? (option == correctAnswer ? Color.fromARGB(255, 63, 246, 2) : Colors.red)
                              : Colors.blue,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (optionSelected) {
                    setState(() {
                      view = correctAnswer;
                    });
                  }
                },
                child: Text("View Answer"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 68, 171, 255),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    view = "";
                    optionSelected = false;
                    nextQuestion();
                  });
                },
                child: Text("Next"),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            view,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
