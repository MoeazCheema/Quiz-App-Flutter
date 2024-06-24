import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  String category="";
  String level="";
  String questionType="";
  String amount="";
 
   ApiHelper(this.category,this.level,this.questionType,this.amount);

  Future<List> fetchQuestions() async {
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=$amount&category=$category&type=$questionType&difficulty=$level'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      return data;
    }
   
     else {
      throw Exception('Failed to fetch questions');
    }
  }
}
