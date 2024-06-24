import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz/category.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
@override
void initState() {
  super.initState();
  // Timer(Duration(seconds: 10), () { 
  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
  // });
  
}


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xff243949),
              Color(0xff243949),
              Color(0xff517fa4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: Center(
                    child: SizedBox(
                        height: screenHeight * 0.5,
                        width: screenWidth * 0.7,
                        child: Image.asset('asset/brain1.png'))),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
//Animated Text ....

              Padding(
                padding: EdgeInsets.all(screenHeight * 0.01),
                child: SizedBox(
                  width: screenWidth<400?screenWidth * 0.9:screenWidth*0.7,
                  height: screenHeight * 0.14,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: screenWidth<400?40:screenWidth*0.03,                                                                                                                                                                                                                                                                                                      
                        fontFamily: 'Bobbers',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                            'LET  ENHANCE  YOUR  KNOWNLEDGE  WITH  QUIZZY',
                            speed: const Duration(
                              milliseconds: 150,
                            ),
                            textStyle: TextStyle(
                                fontFamily: "SpaceGrotesk",
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth<400?40:screenWidth*0.03),),
                      ],
                    ),
                  ),
                ),
              ),
             // Text('$screenWidth , $screenHeight'),
              Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                          color:Color(0xff243949).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SpaceGrotesk"),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
