// https://flutter.dev/docs/cookbook/networking/web-sockets

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(
        channel: new IOWebSocketChannel.connect(
            "ws://echo.websocket.org"), //ws://192.168.43.144:5678
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;
  MyHomePage({@required this.channel});

  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("WGTW"),
      //   backgroundColor: Color.fromRGBO(0, 255, 175, 100),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Color.fromRGBO(0, 255, 175, 100),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: new Text("WE GROW THE WORLD"),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: new StreamBuilder(
                stream: widget.channel.stream,
                builder: (context, snapshot) {
                  return new Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Text(snapshot.hasData ? '${snapshot.data}' : 'SORRY'),
                    
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        height: 72.0,
        width: 72.0,
        child: FittedBox(
            child: FloatingActionButton(
          child: new Icon(Icons.golf_course),
          backgroundColor: Color.fromRGBO(0, 255, 175, 100),
          onPressed: _startf,
        )),
      ),
    );
  }

  void _startf() {
    widget.channel.sink.add("start");
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
