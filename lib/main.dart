import 'package:flutter/material.dart';
import 'counter/counter_page.dart';
import 'guess/guess_page.dart';
import 'package:flutter/src/material/colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const GuessPage(title: '猜数字'),
    );
  }
}



