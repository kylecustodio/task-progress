import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task.dart';
import 'rowbuilder.dart';
import 'task_dialog.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  List<Task> tasks = [];
  String title;
  Color color;
  GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    _load();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _save();
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'task';
    prefs.setString(key, json.encode(tasks));
  }

  _load() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'task';
    json.decode(prefs.getString(key)).forEach((map) => tasks.add(Task.fromJson(map)));
    setState(() {});
  }

  void _newTask() {
    title = null;
    color = Colors.deepPurple[200]; 
    formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Task'),
          content: TaskDialog(dialogTitle: 'New Task', parent: this,),
          actions: <Widget>[
            MaterialButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text('Save'),
              onPressed: () {
                if(formKey.currentState.validate()) {
                  Navigator.of(context).pop();
                  setState(() {
                    tasks.add(Task(title, color, DateTime.now()));
                  });
                }
              },
            ),
          ],
        );
      }
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Progress'),
      ),
      body: 
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16, left: 24, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tasks',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext _context, index) => RowBuilder(task: tasks[index], taskList: tasks, parent: this, parentTask: null,)
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _newTask();
        },
      ),
    );
  }
}