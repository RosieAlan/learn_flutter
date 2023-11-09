import 'package:flutter/material.dart';
import 'dart:math';
import 'result_notice.dart';
import 'package:flutter/services.dart';
import 'guess_app_bar.dart';
class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});
  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}
class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  bool _guessing = false;
  Random _random = Random();
  TextEditingController _guessCtrl =TextEditingController();
  void _generateRandomValue() {
    setState(() {
      _guessing = true; // 点击按钮时，表示游戏开始
      _value=_random.nextInt(100);
    });
  }
  void _onCheck(){
    print("---check $_value,猜的数字是${_guessCtrl.text}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _guessCtrl.dispose();//输入控制器有销毁的方法，需要覆写状态类的 dispose 方法，调用一下：
    // 也不知道为啥复写一下
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:GuessAppBar(
        onCheck: _onCheck,
        controller: _guessCtrl,
      ),
      body:Stack(
        children: [
          // Column(
          //   children: [
          //     resultNotice(color:Colors.greenAccent,info:'大了'),
          //     resultNotice(color:Colors.blueAccent,info:'小了'),
          //   ],
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if(!_guessing)
                  const Text('点击生成随机数值',),
                Text(
                  _guessing ? '**' : '$_value',
                  style: const TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
