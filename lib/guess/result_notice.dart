import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  final Color color;
  final String info;

  const ResultNotice({
    Key? key,
    required this.color,
    required this.info, required AnimationController controller,
  }) : super(key: key);

  @override
  State<ResultNotice> createState() => _ResultNoticeState();
}

class _ResultNoticeState extends State<ResultNotice>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: Container(
            alignment: Alignment.center,
            color: Colors.indigoAccent,
            child: AnimatedBuilder(
                animation: controller,
                builder: (_, child) => Text(widget.info,
                    style: TextStyle(
                      fontSize: 48 * controller.value,
                      color: Colors.white,
                    )))));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
}
