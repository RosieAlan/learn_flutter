import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
        leading: const Icon(Icons.menu, color: Colors.black,),
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: (){},
              icon: const Icon(Icons.run_circle_outlined, color: Colors.blue,)
          )
        ],
        title:const TextField(
          keyboardType: TextInputType.number, //键盘类型: 数字
          decoration: InputDecoration( //装饰
              filled: true, //填充
              fillColor: Color(0xffF3F6F9), //填充颜色
              constraints: BoxConstraints(maxHeight: 35), //约束信息
              border: UnderlineInputBorder( //边线信息
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              hintText: "输入 0~99 数字", //提示字
              hintStyle: TextStyle(fontSize: 14) //提示字样式
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}