import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = new List();
  final TextEditingController _controller = new TextEditingController();
  void fetchData() {
    getData().then((res) {
      setState(() {
        list.addAll(res);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _myFunction(BuildContext context){
    print("clicked "+ _controller.text);
  }

   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Title')),
      body: new Column(children: <Widget>[
        new Expanded(child: new Container(
          margin: new EdgeInsets.only(bottom: 30.0),
          child: new TextField(
            maxLines: null,
            controller: _controller,
          ),
          padding: new EdgeInsets.all(8.0),
        )),
        new RaisedButton(
          onPressed: () => _myFunction(context),
          child: new Center(child: new Text('Save'))
        )
      ]),
    );
  }

  Future<List> getData() async {
    var url = "https://api.github.com/users";
    List data = new List();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      data = json.decode(jsonString);
      return data;      
    }else{
      return data;
    }
  }
}
