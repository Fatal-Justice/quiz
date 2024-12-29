import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/quiz.dart';
import 'package:flutter_application_1/models/quiz_option.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:latext/latext.dart';

void main() async {
  TeXRederingServer.renderingEngine = const TeXViewRenderingEngine.katex();

  if (!kIsWeb) {
    await TeXRederingServer.run();
    await TeXRederingServer.initController();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentQuizIndex = 0;
  String selectedOptionId = "";
  bool isWrong = false;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final quiz = Quiz(statement: r'''<h2>\(\frac{4}{11}\) is</h2>''', options: [
      QuizOption('a', r'''unit fraction'''),
      QuizOption('b', r'''mixed fraction'''),
      QuizOption('c', r'''proper fraction'''),
      QuizOption('d', r'''improper fraction'''),
    ], correctOptionId: 'c');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purple, Colors.purpleAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'Question 1',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              padding: EdgeInsets.all(
                12,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: LaTexT(
                        laTeXCode: Text(
                          r'''$\frac{4}{11}\ is$''',
                        ),
                        equationStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: quiz.options.map((option) {
                      bool isCurrentSelected = selectedOptionId == option.id;
                      bool isCurrentCorrect =
                          option.id == quiz.correctOptionId &&
                              selectedOptionId == option.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOptionId = option.id;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrentCorrect
                                  ? Colors.green[500]!
                                  : isCurrentSelected
                                      ? Colors.black
                                      : Colors.grey[300]!,
                            ),
                            color: isCurrentCorrect
                                ? Colors.green[50]
                                : Colors.white,
                          ),
                          margin: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(
                                option.id,
                              ),
                              Expanded(
                                child: Center(
                                  child: LaTexT(
                                    laTeXCode: Text(option.option),
                                    equationStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isCurrentSelected
                                        ? Colors.green[100]
                                        : Colors.grey[200]!),
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                child: isCurrentCorrect
                                    ? FittedBox(
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.green[900]!,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedOptionId != quiz.correctOptionId) {
                  setState(() {
                    isWrong = true;
                  });
                } else {
                  setState(() {
                    isCorrect = true;
                  });
                }
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildOption(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: Text(
          'some option',
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300]!),
      );
}
