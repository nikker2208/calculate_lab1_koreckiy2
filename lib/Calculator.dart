import 'package:flutter/material.dart';
import 'butt_value.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body:SafeArea(
        bottom: false,
        child: Column(
          children: [
            //out
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "$number1$operand$number2".isEmpty
                          ? "0"
                          : "$number1$operand$number2",
                      style: const TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            //butt
            Wrap(
              children: Btn.buttonValues
                  .map(
                      (value) => SizedBox(
                        width: value==Btn.n0
                            ? screenSize.width/2
                            : (screenSize.width/4),
                        height: screenSize.width/5.5,
                        child: buildButt(value),
                      ),
                  )
                  .toList(),
            )
          ],
        ),
      )
    );
  }

  Widget buildButt(value){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            ),
          ),
        ),
      ),
    );
  }


  void onBtnTap(String value){
    if (value == Btn.del){
      delete();
      return;
    }
    if(value == Btn.clr){
      clear();
      return;
    }
    if(value==Btn.per){
      convertToPerc();
      return;
    }
    if(value==Btn.deg){
      deg();
      return;
    }
    if(value==Btn.fac){
      factorial();
      return;
    }
    if(value==Btn.chg){
      chg();
      return;
    }
    if(value==Btn.root){
      root();
      return;
    }
    if(value == Btn.calculate){
      calculate();
      return;
    }
    appendValue(value);
  }

  void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;

    double num1 = double.parse(number1);
    double num2 = double.parse(number2);

    var result = 0.0;
    switch(operand){
      case Btn.add:
        result = num1+num2;
        break;
      case Btn.multiply:
        result = num1*num2;
        break;
      case Btn.subtract:
        result = num1-num2;
        break;
      case Btn.divide:
        result = num1/num2;
        break;
      default:
    }
    
    setState(() {
      number1 = "$result";
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }
  void root(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      if(number > 0){
        number1 = "${(sqrt(number))}";
      }
      else if(number == 0){
        number1 = "${(0)}";
      }
      else{
        number1 = "err";
      }
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }
  void chg(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      if(number > 0){
        number1 = "${(number*(-1))}";
      }
      else if(number < 0){
        number1 = "${(number*(-1))}";
      }
      else{
        number1 = "${(0)}";
      }
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }
  void factorial(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    var fac = 1;
    setState(() {
      if(number == 0 || number == 1){
        number1 = "${(1)}";
      }
      else if(number < 0){
        number1 = "err";
      }
      else{
        for(int i = 1; i <= number; i++){
          fac = fac * i;
        }
        number1 = "${(fac)}";
      }
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }
  void deg(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number*number)}";
      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  void convertToPerc(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      calculate();
    }
    if(operand.isNotEmpty){
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number/100)}";
      operand = "";
      number2 = "";
    });
  }

  void clear(){
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  void delete(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length - 1);
    }else if(operand.isNotEmpty){
      operand = "";
    }else if(number1.isNotEmpty){
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }
  
  void appendValue(String value){
    if(value!=Btn.dot && int.tryParse(value)==null){
      if(operand.isNotEmpty&&number2.isNotEmpty){
        calculate();
      }
      if(number1.isEmpty){
        number1 = "0";
      }
      operand = value;
    }
    else if(number1.isEmpty || operand.isEmpty){
      if(value==Btn.dot && number1.contains(Btn.dot)) return;
      if(value==Btn.dot && (number1.isEmpty)){
        value = "0.";
      }
      else if(value==Btn.dot && number1 == "0"){
        value = ".";
      }
      else if(value == Btn.n0 && number1 == "0"){
        value = "";
      }
      else if(value != Btn.n0 && number1 == "0"){
        number1 = "";
      }
      number1 += value;
    }
    else if(number2.isEmpty || operand.isNotEmpty){
      if(value==Btn.dot && number2.contains(Btn.dot)) return;
      if(value==Btn.dot && (number2.isEmpty)){
        value = "0.";
      }
      else if(value==Btn.dot && number2 == "0"){
        value = ".";
      }
      else if(value == Btn.n0 && number2 == "0"){
        value = "";
      }
      else if(value != Btn.n0 && number2 == "0"){
        number2 = "";
      }
      number2 += value;
    }

    setState(() {});
  }
  Color getBtnColor(value){
    return [Btn.del,Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
      Btn.chg,
      Btn.root,
      Btn.fac,
      Btn.deg,
    ].contains(value)?Colors.orangeAccent: Colors.black;
  }
}

