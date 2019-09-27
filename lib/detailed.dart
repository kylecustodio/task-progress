import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task.dart';
import 'rowbuilder.dart';
import 'completion_meter.dart';
import 'task_dialog.dart';

class DetailedView extends StatefulWidget {
  final task;
  final taskList;
  final parentTask;

  DetailedView(
      {Key key,
      @required this.task,
      @required this.taskList,
      @required this.parentTask})
      : super(key: key);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  String title;
  GlobalKey<FormState> formKey;
  Color color;
  DateTime selectedDate;

  void _newSubtask() {
    title = null;
    color = widget.task.color;
    formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Subtask'),
          content: TaskDialog(
            dialogTitle: 'New Subtask',
            parent: this,
          ),
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
                if (formKey.currentState.validate()) {
                  setState(() {
                    widget.task.subtasks
                        .add(Task(title, color, DateTime.now()));
                  });
                  widget.task.isParent = widget.task.subtasks.length != 0;
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970, 8),
      lastDate: DateTime(2102)
    );
    if(picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newSubtask(),
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ),
          Visibility(
             visible: task.isParent,
             child: Center(
                //padding: EdgeInsets.all(32.0),
                child: CompletionMeter(
                   task: task,
                   radius: 120.0,
                )
              ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () async {
                    await _selectDate(context);
                    setState(() {
                      task.startDate = selectedDate ?? task.startDate;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Start Date',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 12.0),
                        ),
                        Text(
                          DateFormat('MM / dd / yy').format(task.startDate),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () async {
                    await _selectDate(context);
                    setState(() {
                      task.dueDate = selectedDate;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Due Date',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 12.0),
                        ),
                        Text(
                          task.dueDate == null
                            ? '-- / -- / --'
                              : DateFormat('MM / dd / yy')
                                  .format(task.dueDate),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, left: 24, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Subtasks',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: task.subtasks.length,
              itemBuilder: (BuildContext _context, index) => RowBuilder(
                task: task.subtasks[index],
                taskList: task.subtasks,
                parent: this,
                parentTask: task,
              )
            ),
          )
        ],
      )
    );
  }
}
