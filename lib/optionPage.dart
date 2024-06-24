
import 'package:flutter/material.dart';
import 'package:quiz/apiHelper.dart';
import 'package:quiz/questionPage.dart';

class Option extends StatefulWidget {
  final String cat;
  String selectedOption = "easy";
  String selectedQuestionType = "multiple";
  String selectedAmount = "10";

  Option({Key? key, required this.cat}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  late QuestionPage q;
  late ApiHelper helper;
  final List<String> difficultyLevel = ['easy', 'medium', 'hard'];
  final List<String> questionTypes = ['multiple', 'boolean']; 
  final List<String> questionAmount = ['10', '20','30','40','50'];

 

  @override
  void initState() {
    super.initState();
    q = QuestionPage.full(
      cat: widget.cat,
      level: widget.selectedOption,
      Qtype: widget.selectedQuestionType,
      Qamount: widget.selectedAmount,
      name: nameController.text.toUpperCase(),
      
    );
  }


  


  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screeWidth = MediaQuery.of(context).size.width;
    var screeHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       extendBodyBehindAppBar: false,
       
        backgroundColor: Color.fromARGB(255, 44, 64, 80),
        body: Padding(

          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
             gradient: LinearGradient(colors: [
                 Color(0xff243949),
                 Color(0xff517fa4),
             ]),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              height: screeHeight * 0.75,
              width: screeWidth * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: 20),
                  Text(
                    " Quiz Setting ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),  
                  SizedBox(height: 30),
                  
                  textfield("Your Name",nameController),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Number Of Questions: ",style: TextStyle(color: Colors.white),),
                      const SizedBox(width: 20,),
                      dropDownList(questionAmount, widget.selectedAmount, (String? newValue) {
                        setState(() {
                          widget.selectedAmount = newValue!;
                        });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Difficulty Level: ",style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 20,),
                      dropDownList(difficultyLevel, widget.selectedOption, (String? newValue) {
                        setState(() {
                          widget.selectedOption = newValue!;
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 10,), // Adjust spacing here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Question Type: ",style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 20,),
                      dropDownList(questionTypes, widget.selectedQuestionType, (String? newValue) {
                        if (newValue=="True False"){
                          setState(() {
                              widget.selectedQuestionType='boolean';
                          });
                         
                        
                        }
                         else{
                             setState(() {
                          widget.selectedQuestionType = newValue!;
                        });
                          }
                     
                      }),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: GestureDetector(
                      onTap: () {
                      
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionPage.full(  cat: widget.cat,
                level: widget.selectedOption,
                Qtype: widget.selectedQuestionType,
                Qamount: widget.selectedAmount,
                name: nameController.text.toUpperCase(),)));
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color:  Color.fromARGB(130, 36, 57, 73),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child:  Center(child: Text("Start",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily:"SpaceGrotesk"))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//Text field 
  Widget textfield(String hintValue,TextEditingController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          width: 300,
          child: TextField(
            controller: controller,
             style: TextStyle(color: Colors.white,fontSize: 24),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor:Color.fromARGB(151, 36, 57, 73),
              hintText: hintValue,
              hintStyle:  TextStyle(color: Colors.white),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white, width: 2)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white, width: 1)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white, width: 2)),
            ),
          ),
        ),
      ),
    );
  }
}

//drop down List
  Widget dropDownList(List<String> items, String value, void Function(String?) onChanged) {
    return Center(
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: Color.fromARGB(230, 53, 84, 108),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }