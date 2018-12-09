import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();

  final int value;
  WebPage({Key key, this.value}) : super(key: key);
}

class _WebPageState extends State<WebPage> {
  final String url =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e6dba1fdf08b43a2b2ddc4562d38d0b1';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["articles"];
    });

    return "Success !";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text('News'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[widget.value]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Text(
                  data[widget.value]['author'],
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Text(
                  data[widget.value]['publishedAt'],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Image.network(data[widget.value]['urlToImage']),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Text(
                  data[widget.value]['content'],
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ));
  }
}
