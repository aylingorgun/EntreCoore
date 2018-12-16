import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Database/DBHelper.dart';
import 'Model/Note.dart';
import 'note_list.dart';
import 'Util/dateformatter.dart';

void main() => runApp(new NotePage());

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Note contact = new Note();
  String topic, date;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('ADD NOTES',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            )),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'View List',
            onPressed: () {
              startNoteList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    dateFormatted2(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(labelText: "Topic"),
                  validator: (val) => val.length == 0 ? "Enter note" : null,
                  onSaved: (val) => this.topic = val,
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new MaterialButton(
                    minWidth: 150.0,
                    height: 42.0,
                    child: new Text('ADD NEW NOTE',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white)),
                    onPressed: submitNote,
                    color: Colors.redAccent,
                    highlightColor: Colors.purpleAccent.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startNoteList() {
    //Show new Screen to view Note List
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MyNoteList()));
  }

  void submitNote() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
      startNoteList();
    } else {
      return null;
    }
    var note = Note();
    note.topic = topic;
    note.date = dateFormatted2();

    var dbHelper = DBHelper();
    dbHelper.addNewNote(note);
    Fluttertoast.showToast(
        msg: 'Note was saved',
        toastLength: Toast.LENGTH_SHORT,
        bgcolor: '#FFD50000',
        textcolor: '#000');
  }
}
