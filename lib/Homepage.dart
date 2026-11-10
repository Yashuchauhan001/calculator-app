import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayInput = "";
  String result = "0";
  String operator = "";
  double num1 = 0;
  String currentInput = "";

  void onButtonClick(String value) {
    setState(() {
      if (value == "C") {
        displayInput = "";
        currentInput = "";
        result = "0";
        operator = "";
        num1 = 0;
      } else if (value == "⌫") {
        if (currentInput.isNotEmpty) {
          currentInput = currentInput.substring(0, currentInput.length - 1);
          result = currentInput.isEmpty ? "0" : currentInput;
        }
      } else if (value == "%") {
        // % ka logic
        if (currentInput.isNotEmpty) {
          double val = double.tryParse(currentInput) ?? 0;
          val = val / 100;
          currentInput = val.toString().endsWith(".0")
              ? val.toInt().toString()
              : val.toString();
          result = currentInput;
        }
      } else if (value == "+/-") {
        if (currentInput.isNotEmpty) {
          if (currentInput.startsWith("-")) {
            currentInput = currentInput.substring(1);
          } else {
            currentInput = "-$currentInput";
          }
          result = currentInput;
        }
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        if (currentInput.isNotEmpty) {
          num1 = double.tryParse(currentInput) ?? 0;
          operator = value;
          displayInput = "$currentInput $operator";
          currentInput = "";
        }
      } else if (value == "=") {
        if (currentInput.isNotEmpty && operator.isNotEmpty) {
          double num2 = double.tryParse(currentInput) ?? 0;
          double res = 0;
          if (operator == "+") res = num1 + num2;
          if (operator == "-") res = num1 - num2;
          if (operator == "×") res = num1 * num2;
          if (operator == "÷") res = num2 != 0 ? num1 / num2 : 0;

          result = res.toString().endsWith(".0")
              ? res.toInt().toString()
              : res.toStringAsFixed(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

          displayInput = "$num1 $operator $num2 =";
          currentInput = result;
          operator = "";
        }
      } else {
        if (value == "." && currentInput.contains(".")) return;
        if (result == "0" && value != "." && currentInput == "") {
          currentInput = value;
        } else {
          currentInput += value;
        }
        result = currentInput;
      }
    });
  }

  Widget calcButton(String text, {Color bgColor = const Color(0xFF333333), Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: SizedBox(
          height: 75,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: textColor,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            onPressed: () => onButtonClick(text),
            child: Text(text, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Calculator', style: TextStyle(color: Colors.white70)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(displayInput, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(result,
                        style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          // Buttons - Play Store Style
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    calcButton("C", bgColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    calcButton("+/-", bgColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    calcButton("%", bgColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    calcButton("÷", bgColor: const Color(0xFFFF9F0A)),
                  ],
                ),
                Row(
                  children: [
                    calcButton("7"),
                    calcButton("8"),
                    calcButton("9"),
                    calcButton("×", bgColor: const Color(0xFFFF9F0A)),
                  ],
                ),
                Row(
                  children: [
                    calcButton("4"),
                    calcButton("5"),
                    calcButton("6"),
                    calcButton("-", bgColor: const Color(0xFFFF9F0A)),
                  ],
                ),
                Row(
                  children: [
                    calcButton("1"),
                    calcButton("2"),
                    calcButton("3"),
                    calcButton("+", bgColor: const Color(0xFFFF9F0A)),
                  ],
                ),
                Row(
                  children: [
                    calcButton("⌫"),
                    calcButton("0"),
                    calcButton("."),
                    calcButton("=", bgColor: const Color(0xFFFF9F0A)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}