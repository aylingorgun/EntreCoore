import 'package:flutter/material.dart';
import 'package:entrecor/Util/KanbanScreen.dart';

class KanbanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Kanban"),
      ),
      body: new KanbanScreen(),
    );
  }
}