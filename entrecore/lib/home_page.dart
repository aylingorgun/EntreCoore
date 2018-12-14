import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'package:entrecor/note_page.dart';
import 'package:flutter/widgets.dart';
import 'Tabbaar.dart';
import 'package:entrecor/MineSweeper/MainSweep.dart';

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
          title: Text('EntreCoore'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () => _signOut(context)),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text(
                    'Aylin',
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text('entrecoore@gmail.com',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white70)),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'http://aseteccr.com/Portals/_default/Skins/Flatna/img/icons/user@2x.png'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  )),
              ListTile(
                  title: Text("Fun Zone"),
                  trailing: Icon(Icons.games),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MineSweeper()),
                    );
                  }),
              Divider(
                color: Colors.redAccent,
              ),
              ListTile(
                onTap: () => _signOut(context),
                title: Text("Logout"),
                trailing: Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: Tabs(),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'FAB1',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage()),
                );
              },
              tooltip: 'Add Note',
              child: Icon(Icons.note_add),
            ),
            /*FloatingActionButton(
              heroTag: 'FAB2',
              child: Icon(Icons.share,color: Colors.white,),
              onPressed: null,
            ),*/
          ],
        ));
  }
}
