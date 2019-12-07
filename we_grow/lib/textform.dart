import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Textform extends StatefulWidget {
  @override
  _TextformState createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  TextEditingController editingController = new TextEditingController();

  WebSocketChannel channel;

  TextEditingController controller;

  final List<String> list = [' '];

  void initState() {
    channel = IOWebSocketChannel.connect('ws://192.168.43.144:5679');
    controller = TextEditingController();
    channel.stream.listen((data) => setState(() => list.add(data)));
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Color.fromRGBO(76, 205, 67, 1.0),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: new Text(
                "LET'S START !",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: new Form(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Type in your message"),
                      controller: editingController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: NiceButton(
                    width: 255,
                    elevation: 4.0,
                    radius: 52.0,
                    text: "Send",
                    background: Color.fromRGBO(76, 205, 67, 1.0),
                    onPressed: () {
                      if (editingController.text.isNotEmpty) {
                        print(editingController.text);
                        channel.sink.add(editingController.text);
                      }
                      editingController.text = '';
                      String value = list.last;
                      print(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: list.map((data) => Text(data)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
// ws://192.168.43.144:5678
// ws://echo.websocket.org
