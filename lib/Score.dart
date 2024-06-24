import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quiz/introPage.dart';
import 'package:share/share.dart';

class Score extends StatefulWidget {
  final String score;
  final String correct;
  final String wrong;
  final String name;

  Score({Key? key, required this.score,required this.name,required this.correct, required this.wrong}) : super(key: key);
  
  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  late ConfettiController _controller;
  bool _visible=false;
  @override
  void initState() {
    super.initState();
    _controller = ConfettiController();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final size=MediaQuery.of(context).size;


   
   if(int.parse(widget.score)>=10){
     _controller.play();
   }
   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       backgroundColor:  Color(0xff517fa4).withOpacity(0.3),
        body: Column(
          children: [

            Stack(
              children: [
     Container(
              height: screenHeight*0.6,
              width: screenWidth*1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [  Color(0xff243949),
                Color(0xff243949),
                Color(0xff517fa4),],
                  
                ),
                borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20)),
              ),
            ),

            //Confetti 
             Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: [
                  const Color.fromARGB(255, 92, 6, 239),
                  const Color.fromARGB(255, 9, 241, 17),
                  Colors.amber,
                  Colors.pink,
                  Color.fromARGB(255, 255, 9, 214),
                ],
              ),
            ),
            Container(
              margin:  EdgeInsets.only(top: screenHeight*0.05),
              child: Center(
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                         
                      radius:screenWidth>395? screenHeight*0.15:screenHeight*0.18,
                      backgroundColor: Colors.white.withOpacity(0.4),

                      child: CircleAvatar(
                        radius:screenWidth>395? screenHeight*0.13:screenHeight*0.16,
                          backgroundColor: Colors.white.withOpacity(0.5),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.score,style: TextStyle(
                                
                                fontSize: screenWidth>395? screenWidth*0.06:screenHeight*0.1,
                              ),),
                              Text("Score",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                            ],
                          ),
                      )
                 ) ,
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [          
                  Row(children: [
                    Text("Correct Answers: ${widget.correct}",style: TextStyle(color: Colors.white)),
                    Icon(Icons.check_box_outlined,color: Colors.green,)
                  ],),
                   Row(children: [
                    Text("Wrong Answers: ${widget.wrong} ",style: TextStyle(color: Colors.white)),
                    Icon(Icons.dangerous_outlined,color: Colors.red,)
                  ],)
                ],
                 )
                 ]
                ),),
            ),
               Padding(
                 padding:  EdgeInsets.only(top: screenHeight*0.43),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Center(
                   child: int.parse(widget.score)<10?  Text(
                        'Try Next Time',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ):Text(
                        'Congratulations! ${widget.name}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                 ),
                   Container(
                    width: 120,
                    height: screenHeight*0.16,
                    child: Image.asset('asset/trophy.png'))
                 ],)
                
               ),
           ],
            ),
                SizedBox(
                  height: 20,
                ),
              AnimatedOpacity(
                opacity: _visible ?1: 0.0,
                duration: Duration(seconds: 2),
                curve: Curves.easeIn,
                child: Center(
                  child: Container(
                    height: screenHeight*0.25,
                    width: screenWidth*0.8,
                    decoration: BoxDecoration(
                    color:  Color(0xff517fa4),  
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      buildIconButton(() {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>IntroPage()),(Route<dynamic> route) =>false ,);
        }, Icons.refresh,"Play Again",context),
                        buildIconButton(() {
         showRateUsDialog(context);
        }, Icons.rate_review,"Rate Us",context),
                      buildIconButton(() {
         quitDialog(context);
                      
        }, Icons.close,"Quit",context),
           buildIconButton(() {
      sharee();
        }, Icons.share,"Share",context),
                    ],),
                  ),
                ),
              )
              ],
            ),
              ),
            );
  }
  //Score Sharing
  void sharee(){
    Share.share(widget.score.toString());
  }

    Widget buildIconButton(Function() onPressed, IconData iconData,String discription,BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
      width: 65, 
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:Color(0xff243949).withOpacity(0.5),
      ),
            child: IconButton(
              onPressed:onPressed,
              icon: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
          Text(discription,style: TextStyle(color: Colors.white,fontSize: 20),)
        ],
      );

      
  
  }

void quitDialog(BuildContext context){

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                 
                  title: Text('Quit App?'),
                  content: Text('Are you sure you want to quit the app?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () { 
                        SystemNavigator.pop();
                      },
                      child: Text('Quit'),
                    ),
                  ],
                );
              });
}

 void showRateUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double _rating = 0;
        return AlertDialog(
          title: Text('Rate Us'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please rate our app:'),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Not Now'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Rate Now'),
            ),
          ],
        );
      },);

}
}