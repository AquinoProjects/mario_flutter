import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mario_flame/widgets/buttons.dart';
import 'package:mario_flame/widgets/jumping_mario.dart';
import 'package:mario_flame/widgets/mario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario_flame/widgets/shrooms.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 40;
  double shroomX = 0.5;
  double shroomY = 1.03;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;
  var gameFont = GoogleFonts.pressStart2p(textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void checkIfateShrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      //if eaten, move the shroom off the screen
      shroomX = 2;
      marioSize = 100;
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  //this first if statement disables the double jump
  void jump() {
    if (midjump == false) {
      midjump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    checkIfateShrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIfateShrooms();
      if (MyButton().userIsHoldingButton() == true && marioX + 0.02 < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    checkIfateShrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      checkIfateShrooms();
      if (MyButton().userIsHoldingButton() == true && marioX - 0.02 > -1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      alignment: Alignment(marioX, marioY),
                      duration: Duration(milliseconds: 0),
                      child: midjump
                          ? JumpingMario(
                              direction: direction,
                              size: marioSize,
                            )
                          : Mario(
                              direction: direction,
                              midrun: midrun,
                              size: marioSize,
                            ),
                      //Image.asset("assets/images/standingMario.png")
                    ),
                  ),
                  Container(
                    alignment: Alignment(shroomX, shroomY),
                    child: MyShroom(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'MARIO',
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'WORLD',
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'TIME',
                              style: gameFont,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                MyButton(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  function: moveLeft,
                ),
                MyButton(
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                  ),
                  function: jump,
                ),
                MyButton(
                  child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  function: moveRight,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
