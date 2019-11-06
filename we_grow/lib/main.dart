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
        channel: new IOWebSocketChannel.connect("ws://192.168.43.144:5678"),
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
      appBar: new AppBar(
        title: new Text("WGTW"),
        backgroundColor: Color.fromRGBO(0, 255, 175, 100),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                decoration: new InputDecoration(labelText: "Send any message"),
                controller: editingController,
              ),
            ),
            new StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return new Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
            child: FloatingActionButton(
          child: new Icon(Icons.search),
          backgroundColor: Color.fromRGBO(0, 255, 175, 100),
          onPressed: _sendMyMessage,
          splashColor: Color(000000),
        )),
      ),
    );
  }

  void _sendMyMessage() {
    if (editingController.text.isNotEmpty) {
      widget.channel.sink.add(editingController.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
