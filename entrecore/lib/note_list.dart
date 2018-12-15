import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:entrecor/Database/DBHelper.dart';
import 'Model/Note.dart';

Future<List<Note>> getNoteFromDB() async {
  var dbHelper = DBHelper();
  Future<List<Note>> notes = dbHelper.getNotes();
  return notes;
}

class MyNoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyNoteListState();
}

class MyNoteListState extends State<MyNoteList> {
  //Create Controller
  final controller_topic = new TextEditingController();
  final controller_date = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('NOTES',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            )),
        backgroundColor: Colors.redAccent,
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Note>>(
          future: getNoteFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (note, index) {
                      return new Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0,top: 3.0),
                                  child: Text(
                                    snapshot.data[index].topic,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  snapshot.data[index].date,
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                SizedBox(height: 5.0,),
                                Divider(height: 10.0,color: Colors.red,),
                              ],
                            ),
                          ),

                          //Create Update /Delete button
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(16.0),
                                        content: new Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  TextFormField(
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            '${snapshot.data[index].topic}'),
                                                    controller:
                                                        controller_topic,
                                                  ),
                                                  TextFormField(
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            '${snapshot.data[index].date}'),
                                                    controller: controller_date,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          new FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('CANCEL')),
                                          new FlatButton(
                                              onPressed: () {
                                                var dbHelper = DBHelper();
                                                var note = new Note();
                                                note.id =
                                                    snapshot.data[index].id;
                                                note.topic =
                                                    controller_topic.text != ''
                                                        ? controller_topic.text
                                                        : snapshot
                                                            .data[index].topic;
                                                note.date =
                                                    controller_date.text != ''
                                                        ? controller_date.text
                                                        : snapshot
                                                            .data[index].date;

                                                //Update
                                                dbHelper.updateNote(note);
                                                Navigator.pop(context);
                                                setState(() {
                                                  getNoteFromDB(); //Refresh data
                                                });
                                                Fluttertoast.showToast(
                                                    msg: 'Note was updated',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    bgcolor: '#FFF',
                                                    textcolor: '#333');
                                              },
                                              child: Text('UPDATE')),
                                        ],
                                      ));
                            },
                            child: Icon(
                              Icons.update,
                              color: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var dbHelper = DBHelper();
                              dbHelper.deleteNote(snapshot.data[index]);
                              Fluttertoast.showToast(
                                  msg: 'Contact was deleted',
                                  toastLength: Toast.LENGTH_SHORT,
                                  bgcolor: '#FFF',
                                  textcolor: '#333');

                              //Refresh data
                              setState(() {
                                getNoteFromDB();
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          new Divider(),
                        ],
                      );
                    });
              } else if (snapshot.data.length == 0)
                return Text('No Data Found');
            }
            //Show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
