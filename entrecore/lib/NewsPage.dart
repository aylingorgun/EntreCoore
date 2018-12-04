import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget{
  @override
  NewsPageState createState()=> new NewsPageState();
}
class NewsPageState extends State<NewsPage>{
  final String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e6dba1fdf08b43a2b2ddc4562d38d0b1';
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    
    setState(() {
          var resBody = json.decode(res.body);
          data = resBody["articles"];
    });

    return "Success !";
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        child: new Text(data[index]['author']),
                        padding: const EdgeInsets.all(20.0),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
}