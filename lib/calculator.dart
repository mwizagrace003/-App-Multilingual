
import 'package:flutter/material.dart';



class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Calculation();
  }
}

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  List<dynamic> inputList = [0];
  String output = '0';

  void _handleClear() {
    setState(() {
      inputList = [0];
      output = '0';
    });
  }

  void _handlePress(String input) {
    setState(() {
      if (_isOperator(input)) {
        if (inputList.last is int) {
          inputList.add(input);
          output += input;
        }
      } else if (input == '=') {
        while (inputList.length > 2) {
          int firstNumber = inputList.removeAt(0) as int;
          String operator = inputList.removeAt(0);
          int secondNumber = inputList.removeAt(0) as int;
          int partialResult = 0;

          if (operator == '+') {
            partialResult = firstNumber + secondNumber;
          } else if (operator == '-') {
            partialResult = firstNumber - secondNumber;
          } else if (operator == '*') {
            partialResult = firstNumber * secondNumber;
          } else if (operator == '/') {
            partialResult = firstNumber ~/ secondNumber;
            // Protect against division by zero
            if (secondNumber == 0) {
              partialResult = firstNumber;
            }
          }

          inputList.insert(0, partialResult);
        }

        output = '${inputList[0]}';
      } else {
        int? inputNumber = int.tryParse(input);
        if (inputNumber != null) {
          if (inputList.last is int &&
              !_isOperator(output[output.length - 1])) {
            int lastNumber = (inputList.last as int);
            lastNumber = lastNumber * 10 + inputNumber;
            inputList.last = lastNumber;

            output =
                output.substring(0, output.length - 1) + lastNumber.toString();
          } else {
            inputList.add(inputNumber);
            output += input;
          }
        }
      }
    });
  }

  bool _isOperator(String input) {
    if (input == "+" || input == "-" || input == "*" || input == "/") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          TextField(
            style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            controller: TextEditingController()..text = output,
            readOnly: true,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                for (var i = 0; i <= 9; i++)
                  TextButton(
                    onPressed: () => _handlePress("$i"),
                    style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all(Colors.black12),
                      shape:
                      WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150.0),
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all(const Size(40, 40)),
                    ),
                    child: Text("$i", style: const TextStyle(fontSize: 40)),
                  ),
                TextButton(
                  onPressed: _handleClear,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                  ),
                  child: const Text("C", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () => _handlePress("+"),
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  child: const Text("+", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () => _handlePress("-"),
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  child: const Text("-", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () => _handlePress("*"),
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  child: const Text("*", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () => _handlePress("/"),
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  child: const Text("/", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () => _handlePress("="),
                  style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  child: const Text("=", style: TextStyle(fontSize: 40)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
