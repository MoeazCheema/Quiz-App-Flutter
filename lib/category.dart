import 'package:flutter/material.dart';
import 'package:quiz/optionPage.dart';
import 'package:quiz/questionPage.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
String category = ""; 


late QuestionPage p;
@override
  void initState() {
    
    super.initState();
    Option o =Option(cat: category);
    p=QuestionPage(cat: category);

  }

  @override
  Widget build(BuildContext context) {
    var screensize=MediaQuery.of(context).size;
  
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              Stack(
                children: [
                     Container(
                  height: screensize.height*0.45,
                  width:screensize.width*1,
                decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
                gradient: LinearGradient(colors:[
                Color(0xff243949),
                Color(0xff243949),
                Color(0xff517fa4),   
              ],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
              )
            ),
              ),
              Padding(
                padding:  EdgeInsets.all(screensize.height*0.03),
                child: Center(
                  child: SizedBox(
                  height: screensize.height*0.4,
                  width:screensize.width*1,
                   child: Image.asset("asset/category.png"),
                  ),
                ),
              ),
            
          
          
                ],
          
              ),
              const SizedBox(height: 30.0,),
           Container(
          margin: const EdgeInsets.only(right: 170),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("Categories",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),),
            ),
           ),
           const Divider(thickness: 2,),
        
          Wrap(
            children: [
              CategoryBox("asset/computer.png", "Computer", () {category="18";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
              CategoryBox("asset/math.png", "Mathematics", () {category="20";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
               CategoryBox("asset/knowledge.png", "General Knowledge", () {category="9";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),

                CategoryBox("asset/gadget.png", "Gadgets", () {category="30";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
               CategoryBox("asset/vehicle.png", "Vehicle", () {category="28";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
              CategoryBox("asset/science.png", "Science", () {category="17";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),

              
               CategoryBox("asset/sport.png", "Sports", () {category="21";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),
                CategoryBox("asset/music.png", "Music", () {category="12";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),
               CategoryBox("asset/film.png", "Film", () {category="11";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),
              CategoryBox("asset/animal.png", "Animal", () {category="27";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
             
               CategoryBox("asset/politics.png", "Politics", () {category="24";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
               CategoryBox("asset/geography2.png", "Geography", () {category="22";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),
              CategoryBox("asset/book.png", "Book", () { category="10";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
             
                 CategoryBox("asset/art.png", "Art", () {category="25";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              });}, context),
             
               CategoryBox("asset/history2.png", "History", () {category="23";Navigator.push(context, MaterialPageRoute(builder: (context)=>Option(cat: category,))); setState(() {
                
              }); }, context),
                
              Text(category)
            ],
          )
            ],
          ),
        ),
      ),
    );
  }
}

Widget CategoryBox(String image,String text,VoidCallback onTap,BuildContext context){
  var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
   return Flexible(
    fit: FlexFit.loose,
     child: GestureDetector(
        onTap: onTap,
        child:Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color:  Color(0xff517fa4),
            borderRadius: BorderRadius.circular(20),
          
          ),
          height:screenHeight*0.2,
          width:screenWidth*0.30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                height:screenHeight*0.12,
                
              ),
              const SizedBox(height: 0),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      )),
   );
}

