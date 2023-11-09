import 'package:flutter/material.dart';

class resultNotice extends StatelessWidget{
  final Color color;
  final String info;

    const resultNotice({
      Key? key,
      required this.color,
      required this.info,
     }):super(key:key);


    @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Expanded(
        child: Container(
          alignment: Alignment.center,
          color: color,
          child: Text(
            info,
            style: TextStyle(
                fontSize: 54, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}