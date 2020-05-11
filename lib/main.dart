import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_balta_io/model/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    // items.add(Item(title: "Item 1", done: false));
    // items.add(Item(title: "Item 2", done: true));
    // items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controla as modificações na caixa de texto
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(Item(
        title: newTaskCtrl.text,
        done: false,
      ));
      save();
      newTaskCtrl.clear();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  //A leitura nunca é real time.
  //Future: funciona como uma promessa
  Future load() async {
    //Aguardar até o SharedPreferences carregar
    var prefs = await SharedPreferences.getInstance();

    var data = prefs.getString('data');

    if (data != null) {
      //Aqui temos um Iterable genérico.
      Iterable decoded = jsonDecode(data);
      //Montando a lista de itens.
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState() {
    //Recuerando os items slavos no SharedPreferences
    load();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('executando o build');
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: "Nova tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
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
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              print(direction);
              if (direction == DismissDirection.startToEnd) {
                remove(index);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        onPressed: add,
      ),
    );
  }
}
