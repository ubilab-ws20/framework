import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/MyAlertDialog.dart';
import 'puzzle3.dart';


class ThirdRoute extends StatefulWidget {
  ThirdRoute({
    Key key,
    this.parameter,
  }): super(key: key);
  final parameter;
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

double soundIconSize = 60;

class _ThirdRouteState extends State<ThirdRoute > with WidgetsBindingObserver {

  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;
  int lastKnock = 0;
  int lastKnockTime = 0;
  bool disableKnock = false;
  int disableTime = 0;
  List<int> growableList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _noiseMeter = new NoiseMeter(onError);
    start();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        stop();
        //print('paused');
        break;
      case AppLifecycleState.resumed:
        start();
        //print('resumed');
        break;
      case AppLifecycleState.inactive:
        stop();
        //('inactive');
        break;
      case AppLifecycleState.detached:
        stop();
        //print('inactive');
        break;
    }

  }

  void onData(NoiseReading noiseReading) {
    //print('data');
    if (this.mounted) {
      this.setState(() {
        if (!this._isRecording) {
          this._isRecording = true;
        }
      });
    }

    if (DateTime.now().millisecondsSinceEpoch - disableTime > 100) {
      Puzzle3.getInstance().c5 = Colors.blue;
      soundIconSize = 60;
    }
    if (DateTime.now().millisecondsSinceEpoch - disableTime > 250) {
      disableKnock = false;
    }

    if (noiseReading.maxDecibel > 73 && !disableKnock) {
      int time = DateTime.now().millisecondsSinceEpoch;
      growableList.add(time);
      //print('knock');
      Puzzle3.getInstance().c5 = Colors.red;
      soundIconSize = 100;
      disableKnock = true;
      disableTime = DateTime.now().millisecondsSinceEpoch;

      //Check for pattern 2 1 1 2
      if (growableList.length >= 5) {
        int len = growableList.length;
        int distance = growableList[4] - growableList[0], distance43 = growableList[4] - growableList[3], distance32 = growableList[3] - growableList[2], distance21 = growableList[2] - growableList[1], distance10 = growableList[1] - growableList[0];
        if (distance > 2000 && distance < 5000) {
          if ( distance43 > (distance/3 - 150)  && distance43 < (distance/3 + 150) &&
              distance32 > (distance/6 - 150)  && distance32 < (distance/6 + 150) &&
              distance21 > (distance/6 - 150)  && distance21 < (distance/6 + 150) &&
              distance10 > (distance/3 - 150)  && distance10 < (distance/3 + 150)) {
            //print('Puzzle solved');
            //finish puzzle
            Puzzle3.getInstance().onFinished();
            Navigator.of(context).pop();
          } else {
            //print('pattern not correct');
          }
        } else {
          //print('total pattern too long');
        }
        growableList.removeAt(0);
      }
    }
  }

  void onError(PlatformException e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    //print('start');
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        //print('stop');
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    double heightRatio = Puzzle3.getInstance().heightRatio;
    double widthRatio = Puzzle3.getInstance().widthRatio;
    return Scaffold(
        appBar: AppBar(
          title: Text('The path'),
          automaticallyImplyLeading: false,
          actions: [
            hintIconButton(context),
            gameMenuIconButton(context),
          ],
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/door2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
                children: <Widget>[
                  CustomPaint( //                       <-- CustomPaint widget
                      size: Size(1000, 1000),
                      painter: MyPainter2()
                  ),
                  Positioned(
                    top: 50*heightRatio,
                    left: 15*widthRatio,
                    child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.circle),
                            color: Colors.green,
                            onPressed: () {
                            },
                          ),
                          Text('Start')
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: 123*widthRatio,
                    child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.circle),
                            color: Colors.green,
                            onPressed: () {
                            },
                          ),
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: 177*widthRatio,
                    child: IconButton(
                      icon: Icon(Icons.circle),
                      color: Colors.green,
                      onPressed: () {
                      },
                    ),),
                  Positioned(
                    top: 50*heightRatio,
                    left: 231*widthRatio,
                    child: IconButton(
                      icon: Icon(Icons.circle),
                      color: Colors.green,
                      onPressed: () {
                      },
                    ),),
                  Positioned(
                    top: 50*heightRatio,
                    left: 340*widthRatio,
                    child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.circle),
                            color: Colors.green,
                            onPressed: () {
                            },
                          ),
                          Text('End')
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: (15*widthRatio+123*widthRatio)/2+20,
                    child: Column(
                        children: <Widget>[
                          Text('1.8', style:  TextStyle(fontWeight: FontWeight.bold))
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: (123*widthRatio+177*widthRatio)/2+20,
                    child: Column(
                        children: <Widget>[
                          Text('0.9', style:  TextStyle(fontWeight: FontWeight.bold))
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: (177*widthRatio+231*widthRatio)/2+20,
                    child: Column(
                        children: <Widget>[
                          Text('0.9', style:  TextStyle(fontWeight: FontWeight.bold))
                        ]),),
                  Positioned(
                    top: 50*heightRatio,
                    left: (231*widthRatio+340*widthRatio)/2+20,
                    child: Column(
                        children: <Widget>[
                          Text('1.8', style:  TextStyle(fontWeight: FontWeight.bold))
                        ]),),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          icon: Icon(Icons.text_snippet_outlined),
                          iconSize: 60,
                          color: Colors.blue,
                          onPressed: () {
                            Game.getInstance().addTextsToAlreadyShown([StoryText("Use your imagination. Sometimes there is no well known solution for a problem and some creativity is required. Imagination is a powerfull tool, to think outside the box and to make sense of seemingly unconnected things. How could the information of the extracted path connect to this sound icon?", true)]);
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return MyAlertDialog(title: 'Use your imagination.', content: 'Sometimes there is no well known solution for a problem and some creativity is required. Imagination is a powerfull tool, to think outside the box and to make sense of seemingly unconnected things. How could the information of the extracted path connect to this sound icon?');
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.volume_up),
                          iconSize: soundIconSize,
                          color: Puzzle3.getInstance().c5,
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            child: Text('Skip'),
                            onPressed: () {
                              //stop();
                              Puzzle3.getInstance().onFinished();
                              Navigator.of(context).pop();
                            },
                          )
                      ),
                    ),
                  ),
                ]
            ))
    );
  }

}

class MyPainter2 extends CustomPainter { //         <-- CustomPainter class
  double heightRatio = Puzzle3.getInstance().heightRatio;
  double widthRatio = Puzzle3.getInstance().widthRatio;
  @override
  void paint(Canvas canvas, Size size) {
    final p0 = Offset(15*widthRatio+25, 50*heightRatio+25);
    final p1 = Offset(123*widthRatio+25, 50*heightRatio+25);
    final p2 = Offset(177*widthRatio+25, 50*heightRatio+25);
    final p3 = Offset(231*widthRatio+25, 50*heightRatio+25);
    final p4 = Offset(340*widthRatio+25, 50*heightRatio+25);
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4;
    canvas.drawLine(p0, p1, paint);
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p2, p3, paint);
    canvas.drawLine(p3, p4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}