import 'package:flutter/material.dart';

import 'homepage.dart';
import 'signuppage.dart';
import 'loginpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     home: LoginPage(),
     routes: <String, WidgetBuilder> {
       '/landingpage': (BuildContext context) => new MyApp(),
       '/signup': (BuildContext context) => new SignupPage(),
       '/homepage': (BuildContext context) => new HomePage(),
     },
    );
  }
}
