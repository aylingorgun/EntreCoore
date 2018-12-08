import 'package:entrecor/Model/todoitem.dart';
import 'package:entrecor/Util/database_client.dart';
import 'package:entrecor/Util/dateformatter.dart';
import 'package:flutter/material.dart';

class KanbanScreen extends StatefulWidget {
  @override
  _KanbanScreenState createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();

  var db = new DatabaseHelper();

  final List<TODOItem> _itemList = <TODOItem>[];

  @override
  void initState() {
    super.initState();

    _readToDoList();
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();

    TODOItem todoItem = new TODOItem(text, dateFormatted());
    int savedItemId = await db.saveItem(todoItem);

    TODOItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item saved id: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (__, int index) {
                return Card(
                  color: Colors.black12,
                  child: new ListTile(
                    title: _itemList[index],
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: new Listener(
                      key: new Key(_itemList[index].itemName),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      onPointerDown: (pointerEvent) =>
                          _deleteToDo(_itemList[index].id, index),
                    ),
                  ),
                );
              },
            ),
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Just Do It",
                  icon: Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readToDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      //TODOItem todoItem = TODOItem.fromMap(item);
      setState(() {
        _itemList.add(TODOItem.map(item));
      });
      //print("Db items: ${todoItem.itemName}");
    });
  }

  _updateItem(TODOItem item, int index) {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Update Just do it",
                  icon: Icon(Icons.update)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            TODOItem newItemUpdated = TODOItem.fromMap({
              "itemName": _textEditingController.text,
              "dateCreated": dateFormatted(),
              "id": item.id
            });
            _handleSubmittedUpdate(index, item);
            await db.updateItem(newItemUpdated);
            setState(() {
              _readToDoList();
            });
            Navigator.pop(context);
          },
          child: Text("Update"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleSubmittedUpdate(int index, TODOItem item) {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName == item.itemName;
      });
    });
  }

  _deleteToDo(int id, int index) async {
    debugPrint("Deleted Item");

    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }
}
