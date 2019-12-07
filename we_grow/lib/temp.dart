import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:typed_data';

class Tempereture extends StatefulWidget {
  @override
  _TemperetureState createState() => _TemperetureState();
}

class _TemperetureState extends State<Tempereture> {
  TextEditingController editingController = new TextEditingController();
  WebSocketChannel channel;
  TextEditingController controller;
  final List<String> list = [
    '''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'''
  ];
  void initState() {
    channel = IOWebSocketChannel.connect('ws://192.168.43.144:5679');
    controller = TextEditingController();
    channel.stream.listen((data) => setState(() => list.add(data)));
  }

  @override
  Widget build(BuildContext context) {
    print(list.last);
    String images = list.last;
    Uint8List bytes = base64.decode(images);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Temperature'),
          backgroundColor: Color.fromRGBO(76, 205, 67, 1.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.memory(bytes),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: NiceButton(
                width: 255,
                elevation: 4.0,
                radius: 52.0,
                text: "Hour",
                background: Color.fromRGBO(76, 205, 67, 1.0),
                onPressed: () {
                  _hour();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: NiceButton(
                width: 255,
                elevation: 4.0,
                radius: 52.0,
                text: "Day",
                background: Color.fromRGBO(76, 205, 67, 1.0),
                onPressed: () {
                  _day();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: NiceButton(
                width: 255,
                elevation: 4.0,
                radius: 52.0,
                text: "Week",
                background: Color.fromRGBO(76, 205, 67, 1.0),
                onPressed: () {
                  _week();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _hour() {
    channel.sink.add("data,temp,hour");
  }

  void _day() {
    channel.sink.add("data,temp,day");
  }

  void _week() {
    channel.sink.add("data,temp,week");
  }
}
