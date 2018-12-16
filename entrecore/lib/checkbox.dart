import 'package:flutter/material.dart';

class CheckBoxScreen extends StatefulWidget {
  @override
  CheckBoxScreenState createState() => CheckBoxScreenState();

  final String value;
  CheckBoxScreen({Key key, this.value}) : super(key: key);
}

class CheckBoxScreenState extends State<CheckBoxScreen> {
  bool _isChecked = false;
  bool _isChecked2 = true;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'SUBLIST',
          style: TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.value,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CheckboxListTile(
                      title: new Text('Check Github'),
                      activeColor: Colors.red,
                      secondary: const Icon(Icons.donut_small),
                      value: _isChecked,
                      onChanged: (bool value) {
                        onChanged(value);
                      },
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      title: new Text('Ask StackOverflow'),
                      activeColor: Colors.red,
                      secondary: const Icon(Icons.donut_small),
                      value: _isChecked2,
                      onChanged: (bool value) {
                        onChanged(value);
                      },
                    ),
                    Divider(
                      height: 15.0,
                      color: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      title: new Text('Read Medium'),
                      activeColor: Colors.red,
                      secondary: const Icon(Icons.donut_small),
                      value: _isChecked,
                      onChanged: (bool value) {
                        onChanged(value);
                      },
                    ),
                    Divider(
                      height: 15.0,
                      color: Colors.redAccent,
                    ),
                    CheckboxListTile(
                      title: new Text('Check Dartlang.com'),
                      activeColor: Colors.red,
                      secondary: const Icon(Icons.donut_small),
                      value: _isChecked,
                      onChanged: (bool value) {
                        onChanged(value);
                      },
                    ),
                    Divider(
                      height: 15.0,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}
