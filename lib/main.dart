import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

Widget calcbtn(String btntext, Color btncolor, Color textcolor){
return Container(
  child: RaisedButton(
    onPressed: (){
      //some functions
      calculate(btntext);
    },
    child: Text(btntext, 
    style: TextStyle(
      fontSize: 35, 
      color: textcolor,
    ),
    ),
    shape: CircleBorder(),
    color: btncolor,
    padding: EdgeInsets.all(20),
  ),
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //calculator display
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                  child: Text(text, 
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 80
                  ),
                  ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("AC", Colors.grey, Colors.black),
                  calcbtn("+/-", Colors.grey, Colors.black),
                  calcbtn("%", Colors.grey, Colors.black),
                  calcbtn("÷", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("7", Colors.grey[700], Colors.white),
                  calcbtn("8", Colors.grey[700], Colors.white),
                  calcbtn("9", Colors.grey[700], Colors.white),
                  calcbtn("x", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("4", Colors.grey[700], Colors.white),
                  calcbtn("5", Colors.grey[700], Colors.white),
                  calcbtn("6", Colors.grey[700], Colors.white),
                  calcbtn("-", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbtn("1", Colors.grey[700], Colors.white),
                  calcbtn("2", Colors.grey[700], Colors.white),
                  calcbtn("3", Colors.grey[700], Colors.white),
                  calcbtn("+", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //for 0 button 
                  RaisedButton(
                    // padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    padding: EdgeInsets.fromLTRB(34, 20, 158, 20),
                    onPressed: (){
                      //button function here 
                      calculate('0');
                    },
                    shape: StadiumBorder(),
                    child: Text("0", 
                    style: TextStyle(
                      fontSize: 35, 
                      color: Colors.white,
                    ),
                    ),
                    color: Colors.grey[700],
                  ),
                  calcbtn(".", Colors.grey[700], Colors.white),
                  calcbtn("=", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  dynamic text ='0';
  double first = 0;
  double second = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculate(btntext){
    if(btntext == "AC"){
      text = '0';
      first = 0;
      second = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    }
    
     else if (opr == "=" && btntext == "="){
      if(preOpr == '+') {
         finalResult = addition();
      } else if( preOpr == '-') {
          finalResult = substraction();
      } else if( preOpr == 'x') {
          finalResult = multiplication();
      } else if( preOpr == '÷') {
          finalResult = division();
      } 
    } else if(btntext == '+' || btntext == '-' || btntext == 'x' || btntext == '÷' || btntext == '='){
        if(first == 0) {
          first = double.parse(result);
      } else {
          second = double.parse(result);
      }
      if(preOpr == '+') {
         finalResult = addition();
      } else if( preOpr == '-') {
          finalResult = substraction();
      } else if( preOpr == 'x') {
          finalResult = multiplication();
      } else if( preOpr == '÷') {
          finalResult = division();
      } 

      preOpr = opr;
      opr = btntext;
      result = '';

    } else if(btntext == '%') {
     result = first / 100;
    finalResult = containDecimal(result);
    } else if(btntext == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    } else if(btntext == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;       
    } else {
        result = result + btntext;
        finalResult = result;       
    }
     setState(() {
          text = finalResult;
        });
  }

  String addition() {
         result = (first + second).toString();
         first = double.parse(result); 
         return containDecimal(result);         
  }

  String substraction() {
         result = (first - second).toString();
         first = double.parse(result);
         return containDecimal(result);  

  }
  String multiplication() {
         result = (first * second).toString();
         first = double.parse(result);
         return containDecimal(result);  

  }
  String division() {
          result = (first / second).toString();
          first = double.parse(result);
          return containDecimal(result);  

  }

   String containDecimal(dynamic result) {
    if(result.toString().contains('.')) {
        List<String> split = result.toString().split('.');
        if(!(int.parse(split[1]) > 0))
         return result = split[0].toString();
    }
    return result; 
  }
}