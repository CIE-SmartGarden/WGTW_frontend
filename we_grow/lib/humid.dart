import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:typed_data';

class Humidity extends StatefulWidget {
  @override
  _HumidityState createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  TextEditingController editingController = new TextEditingController();

  WebSocketChannel channel;

  TextEditingController controller;

  final List<String> list = ['''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'''];

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
          title: Text('Humidity'),
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
                    onPressed: (){_hour();},
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
                    onPressed: (){_day();},
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
                    onPressed: (){_week();},
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _hour() {
    channel.sink.add("data,hum,hour");
  }
    void _day() {
    channel.sink.add("data,hum,day");
  }
    void _week() {
    channel.sink.add("data,hum,week");
  }

}
