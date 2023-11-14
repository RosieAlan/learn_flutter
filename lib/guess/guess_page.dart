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

class _GuessPageState extends State<GuessPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool? _isBig;
  int _value = 0;
  bool _guessing = false;
  Random _random = Random();
  TextEditingController _guessCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this, //vsync 用于指定 AnimationController 的 ticker，一般指定当前的 State
      duration: const Duration(milliseconds: 200), //duration 用于指定动画的时长
    );
  }

  void _generateRandomValue() {
    setState(() {
      _guessing = true; // 点击按钮时，表示游戏开始
      _value = _random.nextInt(100);
    });
  }

  void _onCheck() {
    print("---check $_value,猜的数字是${_guessCtrl.text}");
    int guessValue = int.parse(_guessCtrl.text);
    if (!_guessing || guessValue == null) return;
    _controller.forward(from: 0.0); //动画从头开始播放
    if (guessValue == _value) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('恭喜你猜对了'),
              content: Text('数字是$_value'),
              actions: <Widget>[
                TextButton(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      setState(() {
        _isBig = null; //猜对了，把 _isBig 的值设置为 null
        _guessing = false;
      });

      return;
    } else {
      setState(() {
        //猜错了，根据猜的数字和随机数值的大小，设置 _isBig 的值
        _isBig = guessValue > _value; //猜的数字大了
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _guessCtrl.dispose(); //输入控制器有销毁的方法，需要覆写状态类的 dispose 方法，调用一下：
    // 也不知道为啥复写一下
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _guessCtrl,
      ),
      body: Stack(
        children: [
          if (_isBig != null)
            Column(
              children: [
                if (_isBig!) //如果猜的数字大了，显示大了的提示
                  ResultNotice(
                    color: Colors.greenAccent,
                    info: '大了',
                    controller: _controller,
                  ),
                Spacer(),
                if (!_isBig!) //如果猜的数字小了，显示小了的提示
                  ResultNotice(
                    color: Colors.blueAccent,
                    info: '小了',
                    controller: _controller,
                  ),
              ],
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing)
                  const Text(
                    '点击生成随机数值',
                  ),
                Text(
                  _guessing ? '**' : '$_value',
                  style: const TextStyle(
                      fontSize: 68, fontWeight: FontWeight.bold),
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
