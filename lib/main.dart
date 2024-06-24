import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz/Score.dart';
import 'package:quiz/introPage.dart';
import 'package:quiz/category.dart';
import 'package:quiz/optionPage.dart';
import 'package:quiz/questionPage.dart';

void main() {
 
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
 

   MyApp({super.key,});

  @override
  State<MyApp> createState() => _appState();
}

class _appState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(  
    debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => IntroPage(),
       "/categoryPage": (context) => const CategoryPage(),
      //"/questionPage":(context)=>QuestionPage(),
        
      },
     initialRoute: "/",
    );
  }
}