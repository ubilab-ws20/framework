import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubilab_scavenger_hunt/framework/gameMenuScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/hintScreen.dart';
import 'package:ubilab_scavenger_hunt/framework/game.dart';
import 'package:ubilab_scavenger_hunt/framework/storyText.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/MyAlertDialog.dart';
import 'package:ubilab_scavenger_hunt/puzzle_3/ThirdRoute.dart';
import 'puzzle3.dart';


class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}


double appBarHeight, statusBarHeight, x0 , x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11;
Color cursorColor = Color.fromRGBO(255, 0, 0, 0);
int xl = 0, xr = 28;
double yu = appBarHeight + 0, yd = appBarHeight + 28;
double xpos = 0.0, ypos = 0.0, nodex = x0, nodey = y0;

class _SecondRouteState extends State<SecondRoute > {

  List<String> hintGraph = [
    "Find the shortest path in the graph!",
  ];
  List<String> hintKnock = [
    "Notice how the sound icon changes when you produce a (louder) sound. Works best in silent environemnts!",
      "Why is there a door knocker in the background?",
        "What could the edge weights of the path represent?",
          "Try knocking with path nodes representing knocks, and edge weights representing pauses in between.",
  ];
  @override
  void initState() {
    super.initState();
    Game.getInstance().updateCurrentHints(hintGraph);
  }


  BuildContext scaffoldContext;
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;
  int lastNode = 0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    double X = details.position.dx;
    double Y = details.position.dy - statusBarHeight;
    xpos = X;
    ypos = Y;
    setState(() {
      x = X;
      y = Y;
    });

    if (X > x0 + xl && X < x0 + xr && Y > y0 + yu && Y < y0 + yd &&
        lastNode == 0) {
      nodex = x0;
      nodey = y0;
      lastNode = 1;
      Puzzle3.getInstance().c1 = Colors.green;
      cursorColor = Color.fromRGBO(255, 0, 0, 0.4);
      //print("first node");
    }
    if (checkReachedNode(X, Y)) {
      if (!(X > x0 + xl && X < x0 + xr && Y > y0 + yu && Y < y0 + yd) &&
          lastNode == 1) {
        if (X > x3 + xl && X < x3 + xr && Y > y3 + yu && Y < y3 + yd) {
          lastNode = 2;
          nodex = x3;
          nodey = y3;
          Puzzle3.getInstance().c2 = Colors.green;
          //print("second node");
        } else {
          Puzzle3.getInstance().c1 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if (!(X > x3 + xl && X < x3 + xr && Y > y3 + yu && Y < y3 + yd) &&
          lastNode == 2){
        if (X > x5 + xl && X < x5 + xr && Y > y5 + yu && Y < y5 + yd) {
          lastNode = 3;
          nodex = x5;
          nodey = y5;
          Puzzle3.getInstance().c3 = Colors.green;
          //print("thrid node");
        } else {
          Puzzle3.getInstance().c1 = Colors.blue;
          Puzzle3.getInstance().c2 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if (!(X > x5 + xl && X < x5 + xr && Y > y5 + yu && Y < y5 + yd) &&
          lastNode == 3){
        if (X > x11 + xl && X < x11 + xr && Y > y11 + yu && Y < y11 + yd) {
          lastNode = 4;
          nodex = x11;
          nodey = y11;
          Puzzle3.getInstance().c4 = Colors.green;
          //print("fourth node");
        } else {
          Puzzle3.getInstance().c1 = Colors.blue;
          Puzzle3.getInstance().c2 = Colors.blue;
          Puzzle3.getInstance().c3 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
          cursorColor = Color.fromRGBO(255, 0, 0, 0);
        }
      }

      if(!(X > x11 + xl && X < x11 + xr && Y > y11 + yu && Y < y11 + yd) && lastNode == 4){
        cursorColor = Color.fromRGBO(255, 0, 0, 0);
        if (X > x1+xl && X < x1+xr && Y > y1+yu && Y < y1+yd ) {
          lastNode = 5;
          Puzzle3.getInstance().c5 = Colors.green;
          // switch to the next screen
        } else {
          Puzzle3.getInstance().c1 = Colors.blue;
          Puzzle3.getInstance().c2 = Colors.blue;
          Puzzle3.getInstance().c3 = Colors.blue;
          Puzzle3.getInstance().c4 = Colors.blue;
          lastNode = 0;
          nodex = x0;
          nodey = y0;
        }
      }

    }

  }

  Widget ourButton(BuildContext context) {
    final snackBar = new SnackBar(content: new Text("aa"),
        backgroundColor: Colors.red);
    //Scaffold.of(context).showSnackBar(snackBar);
    return lastNode == 5 ?
    ElevatedButton(
      child: Text('Continue'),
      onPressed: () {
        Game.getInstance().updateCurrentHints(hintKnock);
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ThirdRoute()));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ThirdRoute()),
        );
      },
    ) :
    Container();
  }

  Widget ourText() {
    return lastNode == 5 ?
    Text("Congratulations! You have found the correct path!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: "VT323"))
        :
    Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16) );
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // Additional code
  }
  @override
  void dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    statusBarHeight = MediaQuery.of(context).padding.top;
    if (height < width) {
      double tmp = height;
      height = width;
      width = tmp;
    }
    Puzzle3.getInstance().heightRatio = height/Puzzle3.getInstance().refHeight;
    Puzzle3.getInstance().widthRatio = width/Puzzle3.getInstance().refWidth;
    double heightRatio = Puzzle3.getInstance().heightRatio;
    double widthRatio = Puzzle3.getInstance().widthRatio;
    x0 = 50*heightRatio; y0 = 150*widthRatio; x1 = 600*heightRatio; y1 = 150*widthRatio; x2 = 350*heightRatio; y2 = 50*widthRatio; x3 = 150*heightRatio; y3 = 50*widthRatio; x4 = 138*heightRatio; y4 = 113*widthRatio; x5 = 239*heightRatio ;
    y5 = 240*widthRatio; x6 = 135*heightRatio; y6 = 201*widthRatio; x7 = 400*heightRatio; y7 = 250*widthRatio; x8 = 489*heightRatio; y8 = 105*widthRatio; x9 = 350*heightRatio; y9 = 189*widthRatio; x10 = 230*heightRatio; y10 = 130*widthRatio; x11 = 530*heightRatio; y11 = 200*widthRatio;

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);

    AppBar appBar = AppBar(
      title: Text('The path'),
      automaticallyImplyLeading: false,
      actions: [
        hintIconButton(context),
        gameMenuIconButton(context),
      ],
    );
    appBarHeight = appBar.preferredSize.height;
    double iconsize = 24;
    //print(appBarHeight);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        appBar: appBar,
        body: Builder(
          builder: (context) => Stack(
              children: <Widget>[
                CustomPaint( //                       <-- CustomPaint widget
                    size: Size(1000, 1000),
                    painter: MyPainter()
                ),
                Positioned(
                  top: y1,
                  left: x1,
                  child: Column(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: iconsize,
                          icon: Icon(Icons.circle),
                          color: Puzzle3.getInstance().c5,
                          onPressed: () {
                          },
                        ),
                        Text("End")
                      ]),),
                Positioned(
                  top: y0,
                  left: x0,
                  child: Column(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: iconsize,
                          icon: Icon(Icons.circle),
                          color: Puzzle3.getInstance().c1,
                          //color: Color.fromRGBO(255, 255, 255, 0.5),
                          onPressed: () {
                          },
                        ),
                        Text("Start")
                      ]),),
                customIconbutton(y2, x2, Colors.blue, iconsize),
                customIconbutton(y3, x3, Puzzle3.getInstance().c2, iconsize),
                customIconbutton(y4, x4, Colors.blue, iconsize),
                customIconbutton(y5, x5, Puzzle3.getInstance().c3, iconsize),
                customIconbutton(y6, x6, Colors.blue, iconsize),
                customIconbutton(y7, x7, Colors.blue, iconsize),
                customIconbutton(y8, x8, Colors.blue, iconsize),
                customIconbutton(y9, x9, Colors.blue, iconsize),
                customIconbutton(y10, x10, Colors.blue, iconsize),
                customIconbutton(y11, x11, Puzzle3.getInstance().c4, iconsize),
                ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(1000.0, 1000.0)),
                  child: Listener(
                    onPointerDown: _incrementDown,
                    onPointerMove: _updateLocation,
                    onPointerUp: _incrementUp,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ),),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ourButton(context),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: ourText()
                    ),
                  ),
                ),
                customPositioned((y0+y3)/2+10, (x0+x3)/2+5, '1.8'),
                customPositioned((y5+y3)/2+15, (x5+x3)/2+30, '0.9'),
                customPositioned((y5+y11)/2+10, (x5+x11)/2+15, '0.9'),
                customPositioned((y11+y1)/2+12, (x11+x1)/2+7, '1.8'),
                customPositioned( (y0+y2)/2+15, (x0+x2)/2+65, '1.6'),
                customPositioned((y2+y5)/2+10, (x2+x5)/2+5, '2.7'),
                customPositioned((y10+y3)/2+10, (x10+x3)/2+25, '3.5'),
                customPositioned((y10+y7)/2+5, (x10+x7)/2+15, '3'),
                customPositioned((y11+y7)/2+10, (x11+x7)/2+15, '2'),
                customPositioned((y6+y8)/2+10, (x6+x8)/2+15, '3.5'),
                customPositioned((y9+y1)/2+10, (x9+x1)/2+15, '1'),
                customPositioned((y9+y2)/2+10, (x9+x2)/2+15, '3'),
                customPositioned((y0+y6)/2+5, (x0+x6)/2+15, '1.4'),
                customPositioned( (y4+y6)/2+10, (x4+x6)/2+15, '1.5'),
                customPositioned((y4+y3)/2+15, (x4+x3)/2+5, '1.7'),
                customPositioned((y2+y3)/2+10, (x2+x3)/2+15, '2'),
                customPositioned((y8+y2)/2+5, (x8+x2)/2+15, '2.5'),
                customPositioned((y8+y1)/2+5, (x8+x1)/2+15, '1.8'),
                customPositioned((y6+y5)/2+5, (x6+x5)/2+15, '3'),
                customPositioned((y7+y8)/2, (x7+x8)/2+15, '0.9'),
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
                          Game.getInstance().addTextsToAlreadyShown([StoryText('Life is like a graph. There are different scenarios (nodes) and different choices (edges) connecting them. On the way to your goal, there are many possible paths to chose from. To make a plan you optimally find the shortest path to your goal and make your choice accordingly.', true)]);
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return MyAlertDialog(title: 'Life is like a graph.', content: 'There are different scenarios (nodes) and different choices (edges) connecting them. On the way to your goal, there are many possible paths to chose from. To make a plan you optimally find the shortest path to your goal and make your choice accordingly.');
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
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        child: Text('Skip'),
                        onPressed: () {
                          Game.getInstance().updateCurrentHints(hintKnock);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => ThirdRoute()),
                          );
                        },
                      )
                    ),
                  ),
                ),
              ]),)
    ));
  }

}


class MyPainter extends CustomPainter { //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    double offset = 12;
    final p0 = Offset(x0+offset, y0+offset);
    final p1 = Offset(x1+offset, y1+offset);
    final p2 = Offset(x2+offset, y2+offset);
    final p3 = Offset(x3+offset, y3+offset);
    final p4 = Offset(x4+offset, y4+offset);
    final p5 = Offset(x5+offset, y5+offset);
    final p6 = Offset(x6+offset, y6+offset);
    final p7 = Offset(x7+offset, y7+offset);
    final p8 = Offset(x8+offset, y8+offset);
    final p9 = Offset(x9+offset, y9+offset);
    final p10 = Offset(x10+offset, y10+offset);
    final p11 = Offset(x11+offset, y11+offset);
    final node = Offset(nodex+offset, nodey+offset);
    final cursor = Offset(xpos,ypos-appBarHeight);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;
    final paint1 = Paint()
      ..color = Puzzle3.getInstance().c2
      ..strokeWidth = 4;
    final paint2 = Paint()
      ..color = Puzzle3.getInstance().c3
      ..strokeWidth = 4;
    final paint3 = Paint()
      ..color = Puzzle3.getInstance().c4
      ..strokeWidth = 4;
    final paint4 = Paint()
      ..color = Puzzle3.getInstance().c5
      ..strokeWidth = 4;
    final paintCursor = Paint()
      ..color = cursorColor
      ..strokeWidth = 4;
    canvas.drawLine(p0, p3, paint1);
    canvas.drawLine(p3, p5, paint2);
    canvas.drawLine(p5, p11, paint3);
    canvas.drawLine(p11, p1, paint4);
    canvas.drawLine(p0, p2, paint);
    canvas.drawLine(p2, p5, paint);
    canvas.drawLine(p3, p10, paint);
    canvas.drawLine(p7, p10, paint);
    canvas.drawLine(p11, p7, paint);
    canvas.drawLine(p6, p8, paint);
    canvas.drawLine(p9, p1, paint);
    canvas.drawLine(p9, p2, paint);
    canvas.drawLine(p0, p6, paint);
    canvas.drawLine(p4, p6, paint);
    canvas.drawLine(p4, p3, paint);
    canvas.drawLine(p3, p2, paint);
    canvas.drawLine(p8, p2, paint);
    canvas.drawLine(p8, p1, paint);
    canvas.drawLine(p6, p5, paint);
    canvas.drawLine(p7, p8, paint);
    canvas.drawLine(node,cursor, paintCursor);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

Positioned customPositioned(double Top, double Left, String text) {
  return Positioned(
    top: Top,
    left: Left,
    child: Column(
        children: <Widget>[
          Text(text)
        ]),);
}

Positioned customIconbutton(double Top, double Left, Color color, double iconsize) {
  return Positioned(
    top: Top,
    left: Left,
    child: IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      iconSize: iconsize,
      icon: Icon(Icons.circle),
      color: color,
      onPressed: () {
      },
    ),);
}

bool checkReachedNode(double x, double y) {
  if ( (x > x0+xl && x < x0+xr && y > y0+yu && y < y0+yd) || (x > x1+xl && x < x1+xr && y > y1+yu && y < y1+yd) ||
      (x > x2+xl && x < x2+xr && y > y2+yu && y < y2+yd) || (x > x3+xl && x < x3+xr && y > y3+yu && y < y3+yd) ||
      (x > x4+xl && x < x4+xr && y > y4+yu && y < y4+yd) || (x > x5+xl && x < x5+xr && y > y5+yu && y < y5+yd) ||
      (x > x6+xl && x < x6+xr && y > y6+yu && y < y6+yd) || (x > x7+xl && x < x7+xr && y > y7+yu && y < y7+yd) ||
      (x > x8+xl && x < x8+xr && y > y8+yu && y < y8+yd) || (x > x9+xl && x < x9+xr && y > y9+yu && y < y9+yd) ||
      (x > x10+xl && x < x10+xr && y > y10+yu && y < y10+yd) || (x > x11+xl && x < x11+xr && y > y11+yu && y < y11+yd)) {
    return true;
  }
  return false;
}