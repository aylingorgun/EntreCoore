import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'package:entrecor/note_page.dart';
import 'package:flutter/widgets.dart';
import 'Tabbaar.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
              child: Text('Logout',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => _signOut(context)),
        ],
      ),
      body: Tabs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
        },
        tooltip: 'Add Note',
        child: Icon(Icons.note_add),
      ),
    );
  }
}
