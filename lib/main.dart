import 'package:flutter/material.dart';
import 'package:flutter_balta_io/model/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('executando o build');
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          leading: Text('leading'),
          actions: <Widget>[
            Icon(
              Icons.plus_one,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext ctxt, int index) {
            final item = widget.items[index];

            return CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (value) {
                print(value);
                setState(() {
                  //widget.items[index].done = value;
                  item.done = value;
                });
              },
            );
          },
        ));
  }
}
