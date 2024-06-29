import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = '';
  String expression = '0';
  String result = '0';

  buttonPressed(text) {
    setState(() {
      if (text == 'C') {
        equation = '';
        result = '0';
      } else if (text == '⌫') {
        equation = equation.substring(0, equation.length - 1);
      } else if (text == '=') {

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch(e) {
          'Error';
        }
      } else {
        if(equation == '') {
          equation = text;
        }else {
          equation = equation + text;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                equation,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.grey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                numberSymbolButton(Colors.white, "C", Colors.blue),
                numberSymbolButton(Colors.white, "%", Colors.blue),
                numberSymbolButton(Colors.white, "⌫", Colors.blue),
                numberSymbolButton(Colors.white, "+", Colors.blue),
              ],
            ),
            Row(
              children: [
                numberSymbolButton(Colors.white, "7", Colors.black87),
                numberSymbolButton(Colors.white, "8", Colors.black87),
                numberSymbolButton(Colors.white, "9", Colors.black87),
                numberSymbolButton(Colors.white, "-", Colors.blue),
              ],
            ),
            Row(
              children: [
                numberSymbolButton(Colors.white, "4", Colors.black87),
                numberSymbolButton(Colors.white, "5", Colors.black87),
                numberSymbolButton(Colors.white, "6", Colors.black87),
                numberSymbolButton(Colors.white, "×", Colors.blue),
              ],
            ),
            Row(
              children: [
                numberSymbolButton(Colors.white, "1", Colors.black87),
                numberSymbolButton(Colors.white, "2", Colors.black87),
                numberSymbolButton(Colors.white, "3", Colors.black87),
                numberSymbolButton(Colors.white, "÷", Colors.blue),
              ],
            ),
            Row(
              children: [
                numberSymbolButton(Colors.white, "D", Colors.black87),
                numberSymbolButton(Colors.white, "0", Colors.black87),
                numberSymbolButton(Colors.white, ".", Colors.black87),
                numberSymbolButton(Colors.white, "=", Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget numberSymbolButton(
    Color bgColor,
    String text,
    Color textColor,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          buttonPressed(text);
        },
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: Colors.grey, width: 0),
          ),
          alignment: Alignment.center,
          height: 80,
          width: 80,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: textColor),
          ),
        ),
      ),
    );
  }
}
