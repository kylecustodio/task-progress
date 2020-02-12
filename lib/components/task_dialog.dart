import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final dialogTitle;
  final parent;

  TaskDialog({Key key, @required this.dialogTitle, @required this.parent})
      : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.parent.formKey,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              initialValue: widget.parent.title,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a title';
                }
                widget.parent.title = value.toString();
                return null;
              },
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<Color>(
              value: widget.parent.color,
              items: <Color>[
                Colors.red[200],
                Colors.amber[200],
                Colors.lightGreen[200],
                Colors.cyan[200],
                Colors.deepPurple[200],
              ].map((Color color) {
                return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      width: 15.0,
                      height: 15.0,
                    )
                  );
              }).toList(),
              onChanged: (Color value) {
                setState(() {
                  widget.parent.color = value;
                });
              },
            ),
          )
        ],
      )
    );
  }
}
