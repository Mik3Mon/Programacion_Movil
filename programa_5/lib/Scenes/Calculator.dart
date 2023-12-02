import 'package:flutter/material.dart';

extension NumberParsing on String {
  double toDouble(){
    return double.parse(this);
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //Button Design
  Widget calcButton(String buttonText, Color buttonColor, Color textColor) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: buttonColor
    );

    return Container(
      child: ElevatedButton(
        onPressed: (){
          calculation(buttonText);
        },
        style: raisedButtonStyle,
        child: Text(buttonText,
          style: TextStyle(
            fontSize: 40,
            color: textColor,
          ),
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {

    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';

    } else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);

    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;

    } else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });

  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');

      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: calcButton("AC", Colors.grey, Colors.black),
                ),
                Expanded(
                    child: calcButton("+/-", Colors.grey, Colors.black),
                ),
                Expanded(
                    child: calcButton("%", Colors.grey, Colors.black),
                ),
                Expanded(
                    child:calcButton("/", Colors.pink, Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: calcButton("7", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("8", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("9", Colors.white12, Colors.white),
                ),
                Expanded(
                  child:calcButton("x", Colors.pink, Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: calcButton("4", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("5", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("6", Colors.white12, Colors.white),
                ),
                Expanded(
                  child:calcButton("-", Colors.pink, Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: calcButton("1", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("2", Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton("3", Colors.white12, Colors.white),
                ),
                Expanded(
                  child:calcButton("+", Colors.pink, Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: calcButton('0', Colors.white12, Colors.white),
                ),
                Expanded(
                  child: calcButton(".", Colors.white12, Colors.white),
                ),
                Expanded(
                  child:calcButton("=", Colors.pink, Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
