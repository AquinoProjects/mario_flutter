import 'dart:math';

import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  final direction;
  final midrun;
  final size;
  const Mario({Key? key, this.direction, this.midrun, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: size,
        height: size,
        child: midrun ? Image.asset("assets/images/standingMario.png") : Image.asset("assets/images/runningMario.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midrun ? Image.asset("assets/images/standingMario.png") : Image.asset("assets/images/runningMario.png"),
        ),
      );
    }
  }
}
