import 'dart:math';
import 'package:flame_audio/flame_audio.dart';
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
  int _cruValue = 0;
  int _counter = 0;
  AudioPool? pool;
  final Random _random = Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();//调用父类的 initState 方法
    _initAudioPool();
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool(
      'muyu_1.mp3',
      maxPlayers: 4,
    );
  }
  void _onKnock() {
    pool?.start();
    setState(() {
      int addCount = 1 + _random.nextInt(3);
      _cruValue = 1 + _random.nextInt(3);
      _counter += _cruValue;
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                MuyuAssetsImage(
                  image: 'assets/images/muyu.png',
                  onTap: _onKnock,
                ),
                if(_cruValue!=0) AnimateText(text:'功德+$_cruValue'),
              ],
            )
          ),
        ],
      ),
    );
  }

  void _toHistory() {}
  void _onTapSwitchAudio() {}
  void _onTapSwitchImage() {}
}

class AnimateText extends StatefulWidget {
  final String text;

  const AnimateText({Key? key, required this.text}) : super(key: key);

  @override
  State<AnimateText> createState() => _FadTextState();
}

class _FadTextState extends State<AnimateText> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> position;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);
    scale = Tween(begin: 1.0, end: 0.9).animate(controller);
    position = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero,).animate(controller);
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
          position: position,
          child: FadeTransition(
            opacity: opacity,
            child: Text(widget.text),
          )),
    );
  }

}