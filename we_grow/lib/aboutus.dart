import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<About> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('About US'),
            backgroundColor: Color.fromRGBO(76, 205, 67, 1.0),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset('assets/members.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '''
ABOUT US → We 4 Young men from the well known university in Bangkok, KMITL.
Starting off together to build a garden to take care of your plant automatically.
WeGrowTheWorld is made for taking care of your plant either you want to grow them to make food or to use as a decorator. 
WeGrowTheWorld will help your workplace much more lively. Let’s grow the world together.
                      ''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 72.0,
          width: 72.0,
          child: FittedBox(),
        ));
  }
}
