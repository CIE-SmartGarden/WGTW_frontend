import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'humid.dart';
import 'camera.dart';
import 'temp.dart';
import 'aboutus.dart';
import 'textform.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: MyHomePage(
        channel: new IOWebSocketChannel.connect('ws://192.168.43.144:5679'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;
  const MyHomePage({Key key, this.channel}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = new TextEditingController();
  WebSocketChannel channel;
  TextEditingController controller;
  final List<String> list = [];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.43.144:5679');
    controller = TextEditingController();
    channel.stream.listen((data) => setState(() => list.add(data)));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(76, 205, 67, 1.0),
        shape: CustomShapeBorder(),
        leading: IconButton(
          icon: Icon(Icons.security),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Textform()),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 180,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(183, 255, 3, 1.0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "WGTW",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CupertinoButton(
                        child: Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(76, 205, 67, 1.0),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius:
                                    10.0, // has the effect of softening the shadow
                                spreadRadius:
                                    5.0, // has the effect of extending the shadow
                                offset: Offset(
                                  10.0, // horizontal, move right 10
                                  10.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Humidity",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Image.asset('assets/Humidity.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Humidity()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CupertinoButton(
                        child: Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(76, 205, 67, 1.0),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius:
                                    10.0, // has the effect of softening the shadow
                                spreadRadius:
                                    5.0, // has the effect of extending the shadow
                                offset: Offset(
                                  10.0, // horizontal, move right 10
                                  10.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Temperature",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child:
                                          Image.asset('assets/Temperature.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tempereture()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CupertinoButton(
                          child: Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(76, 205, 67, 1.0),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius:
                                      10.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      5.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Camera",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Image.asset('assets/Camera.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Camera()),
                            );
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CupertinoButton(
                          child: Container(
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(76, 205, 67, 1.0),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius:
                                      10.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      5.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "About us",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(35.0),
                                        child: Image.asset('assets/Info.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => About()),
                            );
                          },
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    return scaffold;
  }
}

// ws://192.168.43.144:5678
// ws://echo.websocket.org
class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double innerCircleRadius = 120.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30,
        rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75,
        rect.height + 50);
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30,
        rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
