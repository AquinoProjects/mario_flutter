import 'package:flutter/material.dart';

class MyShroom extends StatelessWidget {
  const MyShroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      child: Image.asset("assets/images/pngwing.com.png"),
    );
  }
}
