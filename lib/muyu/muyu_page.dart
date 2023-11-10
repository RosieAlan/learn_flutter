import 'dart:math';
import 'package:flutter/material.dart';
import 'muyu_image.dart';
import 'count_panel.dart';
class MuyuPage extends StatefulWidget {
  const MuyuPage({Key? key}) : super(key: key);

  @override
  State<MuyuPage> createState() => _MuyuPageState();
  //这是 StatefulWidget 的一个重要部分。createState 方法是 StatefulWidget 的一个重载（override）方法
  // 它的作用是创建与 StatefulWidget 相关联的 State 对象。在这里，它返回一个 _MuyuPageState 实例。
  // 这意味着当 Flutter 需要构建 MuyuPage 组件时，它将使用 _MuyuPageState 来管理这个组件的状态。
}

class _MuyuPageState extends State<MuyuPage> {
  int _counter = 0;
  final Random _random = Random();

  void _onKnock() {
    setState(() {
      int addCount = 1 + _random.nextInt(3);
      _counter += addCount;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('电子木鱼'),
        elevation: 0, //去掉阴影
        backgroundColor: Colors.blueGrey[900], //背景色
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          //图标主题
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: _toHistory,
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CountPanel(
              count: _counter,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTapSwitchImage: _onTapSwitchImage,
            ),
          ),
          Expanded(
            child: MuyuAssetsImage(
              image: 'assets/images/muyu.png',
              onTap: _onKnock,
            ),
          ),
        ],
      ),
    );
  }

  void _toHistory() {}
  void _onTapSwitchAudio() {}
  void _onTapSwitchImage() {}
}

