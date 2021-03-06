import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/main.dart';
import 'package:ubilab_scavenger_hunt/framework/framework.dart';

final String stringContinueToGame = "Continue";
final String stringIntroText = "Hey there!\n\n"
    "Before you start, we wanna give you a few explanations and clues. Please carefully ready through them.\n\n"
    "First of all: This game can only be played at the campus of the Faculty of Engineering of the University of Freiburg.\n\n"
    "During the game you will have to solve different kinds of riddles. "
    "In order to do that, make sure that you carefully pay attention to everything "
    "that you see, hear and read. Hints can be anywhere!\n\n"
    "Alternately you will have to search for specific locations and at these locations then solve riddles.\n\n"
    "From the top right corner of your screen you always can access your journal. "
    "As well as some hints, in case there are any available for your current situation.\n\n"
    "Also, make sure that your device has the following turned on and working:\n"
    "\t\t• Internet connection\n"
    "\t\t• Location services\n"
    "\t\t• Bluetooth\n"
    "\t\t• Sound & vibration\n\n"
    "That's it, have fun!";

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(title: Text(stringAppName)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  constraints: BoxConstraints.expand(),
                  margin: EdgeInsets.all(20.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                        stringIntroText,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: OutlinedButton(
                  child: Text(
                    stringContinueToGame,
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    continueToGame(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void continueToGame(BuildContext context) {
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.fade,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
      child: GameMainScreen(),
    ));
  }
}
