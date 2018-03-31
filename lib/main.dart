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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: list.length,
          itemBuilder: ((BuildContext _context, int position) {
            return new ListTile(
              title: new Text( list[position]['login'].toString()),
              subtitle: new Text(list[position]['url']),
              leading: new Image.network(list[position]['avatar_url']),
            );   
          }),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: fetchData,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
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
