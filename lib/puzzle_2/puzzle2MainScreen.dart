import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen1.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen2.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen3.dart';
import 'package:ubilab_scavenger_hunt/puzzle_2/puzzle2Screen4.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'puzzle2Screen3.dart';

class Puzzle2MainScreen extends StatefulWidget {
  @override
  Puzzle2MainScreenState createState() => Puzzle2MainScreenState();
}

class Puzzle2MainScreenState extends State<Puzzle2MainScreen> {
  static Puzzle2MainScreenState _instance;

  Puzzle2MainScreenState() {
    _instance = this;
  }

  /// Static singleton method.
  static Puzzle2MainScreenState getInstance() {
    if (_instance == null) {
      _instance = Puzzle2MainScreenState();
    }
    return _instance;
  }

  void setStateCallback() {
    setState(() {});
  }

  Widget displayStory() {
    if (Puzzle2Variables.subPuzzle == 1) {
      return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: Text(
                Puzzle2Variables.story2_1,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: OutlinedButton(
                child: Text("Next"),
                onPressed: () {
                  displaySubPuzzle();
                },
              ),
            ),
          ],
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 2) {
      return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: Text(
                Puzzle2Variables.story2_2,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: OutlinedButton(
                child: Text("Next"),
                onPressed: () {
                  displaySubPuzzle();
                },
              ),
            ),
          ],
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 3) {
      return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: Text(
                Puzzle2Variables.story2_3,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: OutlinedButton(
                child: Text("Next"),
                onPressed: () {
                  displaySubPuzzle();
                },
              ),
            ),
          ],
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 4) {
      return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: Text(
                Puzzle2Variables.story2_4,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, right: 10.0, left: 10.0, bottom: 5.0),
              child: OutlinedButton(
                child: Text("Next"),
                onPressed: () {
                  displaySubPuzzle();
                },
              ),
            ),
          ],
        ),
      );
    } else if (Puzzle2Variables.subPuzzle == 5) {
      return Container();
    } else
      return Column();
  }

  displaySubPuzzle() {
    if (Puzzle2Variables.subPuzzle == 1) {
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_1_start);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen1(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 2) {
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_1_end);
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_2_start);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen2(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 3) {
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_2_end);
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_3_start);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen3(),
      ));
    } else if (Puzzle2Variables.subPuzzle == 4) {
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_3_end);
      Game.getInstance()
          .addTextsToAlreadyShown(Puzzle2Variables.textInsidePuzzle2_4_start);
      Navigator.of(context).push(PageTransition(
        type: PageTransitionType.bottomToTop,
        child: Puzzle2Screen4(),
      ));
    } else {}
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Finale: The Destiny'),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/blurMap.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              displayStory(),
            ],
          ),
        ),
      ),
    );
  }
}
