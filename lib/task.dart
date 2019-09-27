import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String title;
  bool complete = false;
  bool isParent = false;
  double progress = 0.0;
  Color color = Colors.deepPurple[200];
  DateTime startDate;
  DateTime dueDate;
  List<Task> subtasks = [];  

  Task(String title, Color color, DateTime startDate) {
    this.title = title;
    this.color = color;
    this.startDate = startDate;
    this.dueDate = null;
  }

  factory Task.fromJson(Map<String, dynamic> map) => _$TaskFromJson(map);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  // Getters
  double get taskProgress {
    progress = 0.0;
    if(complete) {
      progress = 1.0;
    }
    if(subtasks.length > 0) {
      double prog = 0.0;
      for(Task t in subtasks) {
        prog += t.taskProgress;
      }
      progress = prog / subtasks.length;
    }
    if(progress == 1.0) {
      complete = true;
    }
    return progress;
  }
  String get timeElapsed {
    var diff = DateTime.now().difference(startDate).inDays;
    return diff.toString();
  }
  String get timeLeft {
    if(dueDate == null) {
      return '--';
    }
    var diff = dueDate.difference(DateTime.now()).inDays;
    return diff.toString();
  }
}