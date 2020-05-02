import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Center(
          child: Text(
            'App',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
