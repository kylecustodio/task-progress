import 'package:flutter/material.dart';
import 'task.dart';
import 'detailed.dart';
import 'completion_meter.dart';
import 'task_dialog.dart';
import 'round_checkbox.dart';


class RowBuilder extends StatefulWidget {
  final Task task;
  final List<Task> taskList;
  final parent;
  final Task parentTask;

  RowBuilder({Key key, @required this.task, @required this.taskList, @required this.parent, @required this.parentTask}) : super(key: key);

  @override 
  _RowBuilderState createState() => _RowBuilderState();
}

class _RowBuilderState extends State<RowBuilder> {

  String title;
  Color color;
  GlobalKey<FormState> formKey;

  void _editTask() {
    title = widget.task.title;
    color = widget.task.color;
    formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TaskDialog(dialogTitle: 'Edit Task', parent: this,),
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
                  setState(() {
                    widget.task.title = title;
                    widget.task.color = color;
                  });
                  Navigator.of(context).pop();
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      margin: EdgeInsets.all(8),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        onTap: () {
          // Navigate to detailed task view
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailedView(task: widget.task, taskList: widget.taskList, parentTask: widget.parentTask,)
            )
          );
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Visibility(
                  visible: !widget.task.isParent,
                  child: RoundCheckbox(
                    activeColor: widget.task.color,
                    value: widget.task.complete,
                    onChanged: (value) {
                      widget.parent.setState(() {
                        widget.task.complete = !widget.task.complete;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: widget.task.isParent ? EdgeInsets.all(16) : EdgeInsets.all(0),
                  child: Text(
                    widget.task.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                PopupMenuButton<String>(
                  elevation: 6,
                  onSelected: (String choice) {
                    if (choice == 'Edit') {
                      //Prompt Edit
                      _editTask();
                    } else if (choice == 'Delete') {
                      //Delete
                      widget.parent.setState(() {
                        widget.task.subtasks.clear();
                        widget.taskList.remove(widget.task);
                        if(widget.parentTask != null) {
                          widget.parentTask.complete = false;
                          widget.parentTask.isParent = widget.parentTask.subtasks.length != 0;
                        }
                      });
                    }
                  },
                  itemBuilder: (BuildContext _context) {
                    return <String>['Edit', 'Delete'].map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            Visibility(
              visible: widget.task.isParent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child:   Column(
                      children: <Widget>[
                        Text(
                          'Days Elapsed',
                          style: TextStyle(color: Colors.white54, fontSize: 12.0),
                        ),
                        Text(
                          widget.task.timeElapsed,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CompletionMeter(
                      task: widget.task,
                      radius: 120.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child:   Column(
                      children: <Widget>[
                        Text(
                          'Days Left',
                          style: TextStyle(color: Colors.white54, fontSize: 12.0),
                        ),
                        Text(
                          widget.task.timeLeft,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}