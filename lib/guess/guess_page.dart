import 'package:flutter/material.dart';
import 'dart:math';
class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});
  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}
class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  Random _random = Random();
  void _generateRandomValue() {
    setState(() {
      _value=_random.nextInt(100);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'click to make random Num:',
              style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color:Colors.grey ),
            ),
            Text(
              '$_value',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomValue,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}